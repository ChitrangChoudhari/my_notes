import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../change_notifier/registration_controller.dart';


class AuthService{
  AuthService._();

  static final _auth=FirebaseAuth.instance;
  static User? get user => _auth.currentUser;
  static Stream<User?> get userStream => _auth.userChanges();
  static bool get isEmailVerified => user?.emailVerified??false;

  static Future<void> register({
    required String fullName,
    required String email,
    required String password,
  })
  async {
    try{
      final credential= await _auth.createUserWithEmailAndPassword(
        email:email,
        password:password,
      ).then((credential){
        credential.user?.sendEmailVerification();
        credential.user?.updateDisplayName(fullName);
      });
    }
    catch (e){
      rethrow;
    }
  }

  static Future<void> login({
    required String email,
    required String password,
})
  async {
    try{
      final credential= await _auth.signInWithEmailAndPassword(
        email:email,
        password:password,
      );
    }
    catch(e){
      rethrow;
    }
  }


  static Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if(googleUser==null){
      throw const NoGoogleAccountChosenException();
    }
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<void> resetPassword({
    required String email,
}) => _auth.sendPasswordResetEmail(email: email);

  static Future<void> logout() async{
    await _auth.signOut();
    await GoogleSignIn().signOut();
  }
}