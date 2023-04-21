import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yao_hariraya/yao_home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'AIzaSyA1ThG2V3TRfoWYFwh8cQq9_Bt5mallj9k',
        appId: '1:1040260335591:web:09d8c02c7839876e32df42',
        messagingSenderId: '1040260335591',
        projectId: 'yaomink-app-learn'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yaomink Idul Fitri',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const YaoHome());
  }
}
