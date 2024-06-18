import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:plz/Pages/shop.dart';
import 'package:plz/Pages/welcome.dart';
import 'package:provider/provider.dart';

import 'Pages/profile_image_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Shop()),
        ChangeNotifierProvider(
            create: (context) =>
                ProfileImageProvider()), // Add the ProfileImageProvider
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      home: Welcome(),
    );
  }
}
