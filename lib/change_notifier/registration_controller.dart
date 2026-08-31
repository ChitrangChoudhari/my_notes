import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:my_notes/core/constants.dart';
import 'package:my_notes/core/dialogs.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/auth_service.dart';

class RegistrationController extends ChangeNotifier{


  bool _isRegisterMode = true;
  bool get isRegisterMode => _isRegisterMode;
  set isRegisterMode(bool value) {
    _isRegisterMode = value;
    notifyListeners();
  }

  bool _isPasswordHidden = true;
  bool get isPasswordHidden => _isPasswordHidden;
  set isPasswordHidden(bool value) {
    _isPasswordHidden = value;
    notifyListeners();
  }

  String _fullname='';
  set fullname(String value) {
    _fullname = value;
    notifyListeners();
  }
  String get fullname => _fullname.trim();

  String _email='';
  set email(String value) {
    _email = value;
    notifyListeners();
  }
  String get email => _email.trim();

  String _password='';
  set password(String value) {
    _password = value;
    notifyListeners();
  }
  String get password => _password;

  bool _isLoading=false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> authenticateWithEmailAndPassword({
    required BuildContext context,
  })
  async {
    isLoading=true;
    try{
      if (_isRegisterMode) {
        await AuthService.register(
          fullName: _fullname,
          email: _email,
          password: _password,
        );
        if(!context.mounted) return;
        showMessageDialogue(
            context: context,
            message: 'A verification email was sent to the provided email address. Please confirm your email to proceed.'
        );
        while (!AuthService.isEmailVerified) {
          await Future.delayed(
            Duration(seconds:5),
              ()=>AuthService.user?.reload(),
          );
        }
      }
      else{
        await AuthService.login(email: email, password: password);
      }
    }
    on FirebaseAuthException catch (e){
      if(!context.mounted) return;
      showMessageDialogue(
          context: context,
          message: authExceptionMapper[e.code]?? 'An unknown error occurred!'
      );
    }
    catch (e){
      if(!context.mounted) return;
      showMessageDialogue(
          context: context,
          message: 'An unknown error occurred!'
      );
    }
    finally{
      isLoading=false;
    }
  }

  Future<void> authenticateWithGoogle({
    required BuildContext context,
  }) async {
    try {
      if (kIsWeb){
      await _signInWithGoogle(context);
      }
      else if (Platform.isWindows) {
        // Windows-specific implementation
        await _signInWithGoogleUsingUrlLauncher(context);
      }
      else if (Platform.isAndroid) {
        await _signInWithGoogleAndroid(context);
      }
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialogue(
        context: context,
        message: 'An unknown error occurred: ${e.toString()}',
      );
    }
  }

  Future<void> _signInWithGoogleAndroid(BuildContext context) async {
    try {
      await AuthService.signInWithGoogle();
    } on NoGoogleAccountChosenException {
      return;
    } catch (e) {
      if (!context.mounted) return;
      showMessageDialogue(
        context: context,
        message: 'An unknown error occurred: ${e.toString()}',
      );
    }
  }

  Future<void> _signInWithGoogle(BuildContext context)
  async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: '206371356670-g9po58eloptumaic7of0q9e2npcl6ug4.apps.googleusercontent.com', // Required for web
        scopes: ['email', 'profile'],
      );
      await googleSignIn.signInSilently();
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        throw NoGoogleAccountChosenException();
      }
      final GoogleSignInAuthentication auth = await account.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    }
    on NoGoogleAccountChosenException {
      return;
    }
    on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      showMessageDialogue(
        context: context,
        message: 'An unknown error occurred: ${e.toString()}',
      );
    }
    catch (e) {
      if (!context.mounted) return;
      showMessageDialogue(
        context: context,
        message: 'An unknown error occurred: ${e.toString()}',
      );
    }
  }

  Future<void> _signInWithGoogleUsingUrlLauncher(BuildContext context) async {
    final serverFuture = _handleOAuthCallback();
    final authUrl = 'https://accounts.google.com/o/oauth2/auth?${_buildGoogleOAuthParams()}';
    if (!await launchUrl(Uri.parse(authUrl))) {
      throw Exception('Could not launch browser');
    }
    await serverFuture;
  }

  String _buildGoogleOAuthParams() {
    return Uri(queryParameters: {
      'client_id': '206371356670-g9po58eloptumaic7of0q9e2npcl6ug4.apps.googleusercontent.com',
      'redirect_uri': 'http://localhost:3000/auth',
      'response_type': 'code',
      'scope': 'email profile',
      'state': _generateStateToken(),
    }).query;
  }

  String _generateStateToken() {
    return base64UrlEncode(
        List.generate(32, (i) => Random.secure().nextInt(256))).replaceAll('=', '');
  }

  Future<void> _handleOAuthCallback() async {
    final server = await HttpServer.bind('localhost', 3000);
    server.listen((request) async {
      final code = request.uri.queryParameters['code'];
      if (code != null) {
        // Exchange code for tokens
        final credential = await _exchangeCodeForCredential(code);
        await FirebaseAuth.instance.signInWithCredential(credential);

        // Close server and respond
        request.response
          ..statusCode = 200
          ..write('Connected Successfully. \nThank you!');
        await request.response.close();
        await server.close();
      }
    });
  }

  Future<OAuthCredential> _exchangeCodeForCredential(String code) async {
    final response = await http.post(
      Uri.parse('https://oauth2.googleapis.com/token'),
      body: {
        'code': code,
        'client_id': '206371356670-g9po58eloptumaic7of0q9e2npcl6ug4.apps.googleusercontent.com',
        'client_secret': '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',
        'redirect_uri': 'http://localhost:3000/auth',
        'grant_type': 'authorization_code',
      },
    );

    final data = jsonDecode(response.body);
    return GoogleAuthProvider.credential(
      accessToken: data['access_token'],
      idToken: data['id_token'],
    );
  }


  Future<void> resetPassword({
    required BuildContext context,
    required String email,
  })
  async {
    isLoading=true;
    try {
      await AuthService.resetPassword(email: email);
      if(!context.mounted) return;
      showMessageDialogue(
          context: context,
          message: 'A reset password link was sent to $email. Please check your email to proceed'
      );
    }
    on FirebaseAuthException catch (e){
      if(!context.mounted) return;
      showMessageDialogue(
          context: context,
          message: authExceptionMapper[e.code]?? 'An unknown error occurred!'
      );
    }
    catch (e){
      if(!context.mounted) return;
      showMessageDialogue(
          context: context,
          message: 'An unknown error occurred!'
      );
    }
    finally{
      isLoading=false;
    }
  }
}

class NoGoogleAccountChosenException implements Exception{
  const NoGoogleAccountChosenException();
}


