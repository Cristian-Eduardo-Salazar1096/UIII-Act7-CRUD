import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:myapp/pages/app_nombre_page.dart';
import 'package:myapp/pages/edit_product_page.dart';
import 'package:myapp/pages/home_page.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mi CRUD OXXO",
      initialRoute: "/",
      routes: {
        "/": (context) => const Home(),
        "/add": (context) => const AddProductPage(),
        "/edit": (context) => const EditProductPage(),
      },
    );
  }
}