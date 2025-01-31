import 'package:firebase/ui/pages.dart';
// import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      // data ambil dari file google-services.json
        apiKey: 'AIzaSyBF1wDhaw6AW0lZikI8nrBEkuYmR4cMLBY', // current_key
        appId: '1:572186552951:android:e657b845f064917d36b472', // mobilesdk_app_id
        messagingSenderId: '572186552951', // project_number
        projectId: 'auth-9d0e1' // project_id
    ),
  );
  // await FirebaseAppCheck.instance.activate(
  //   androidProvider: AndroidProvider.playIntegrity,
  //   webProvider: ReCaptchaV3Provider('A688DC86-E2F2-433F-868B-B10CA19418B0')
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        '/login' : (context) => SignInPage(),
        '/register' : (context) => SignUpPage(),
        '/home' : (context) => HomePage(),
      },
    );
  }
}
