import 'package:chat/auth/log_in_screen.dart';
import 'package:chat/auth/sign_up_screen.dart';
import 'package:chat/provider/loading.dart';
import 'package:chat/provider/select_image.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<IsLoading>(
          create: (context) => IsLoading(),
        ),
        ChangeNotifierProvider<SelectImage>(
          create: (context) => SelectImage(),
        ),
      ],

      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.pink,
            backgroundColor: Colors.pink,
            accentColor: Colors.deepPurple,
            accentColorBrightness: Brightness.dark),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snap) {
            if (snap.hasData) {
              return ChatScreen();
            } else {
              return LoginScreen();
            }
          },
        ),
        routes: {
          ChatScreen.id: (context) => ChatScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
        });
  }
}
// Navigator.pushNamed(context, HomePage.id);
