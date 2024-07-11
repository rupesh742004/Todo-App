import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/src/screen/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await  initSharedPreferences();
  runApp(const MyApp());
}

Future<void> initSharedPreferences()async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.blueAccent));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home:HomeScreen(),
    );
  }
}
