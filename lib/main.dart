import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kissan_mitr/home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDXkcM7HUj3a-xQkeVXKlqq-It6C2QhN1A",
      appId: "1:1092122527053:web:15795c3175eaa5fb8ce304",
      messagingSenderId: "1092122527053",
      projectId: "kissan-mitr-efee8",
      authDomain: "kissan-mitr-efee8.firebaseapp.com", // Optional for web
      storageBucket: "kissan-mitr-efee8.appspot.com", // Optional
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
