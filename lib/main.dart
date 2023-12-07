import 'package:firebase/controller/data_provider.dart';
import 'package:firebase/controller/firebase_provider.dart';
import 'package:firebase/firebase_options.dart';
import 'package:firebase/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>Providers()),
        ChangeNotifierProvider(create: (context)=>FirebaseProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:  HomePage(),
      ),
    );
  }
}

