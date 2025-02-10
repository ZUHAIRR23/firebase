import 'package:firebase/ui/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyBF1wDhaw6AW0lZikI8nrBEkuYmR4cMLBY',
        appId: '1:572186552951:android:e657b845f064917d36b472',
        messagingSenderId: '572186552951',
        projectId: 'auth-9d0e1'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignInPage(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => SignInPage(),
        '/register': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/note': (context) => NotePage(),
        '/profile': (context) => ProfilePage(),
        '/changePassword': (context) => ChangePasswordPage(),
      },
    );
  }
}
