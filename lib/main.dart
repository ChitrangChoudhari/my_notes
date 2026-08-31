import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/change_notifier/registration_controller.dart';
import 'package:my_notes/pages/registration_page.dart';
import 'package:my_notes/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'change_notifier/note_provider.dart';
import 'core/constants.dart';
import 'firebase_options.dart';
import 'pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => NotesProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => RegistrationController(),
          ),
        ],
      child: MaterialApp(
        title: 'My Notes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: navy),
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: whiteblue,
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: navy,
            titleTextStyle: TextStyle(
              color: white,
              fontSize: 32,
            ),
          ),
        ),
        home: StreamBuilder<User?>(
          stream: AuthService.userStream,
          builder: (context, snapshot) {
            return snapshot.hasData && AuthService.isEmailVerified
                ? const MainPage()
                : const RegistrationPage();
          }
        )
      )
    );
  }
}

