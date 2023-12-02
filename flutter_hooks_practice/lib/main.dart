import 'package:flutter/material.dart';
import 'package:flutter_hooks_practice/homepage.dart';
import 'package:flutter_hooks_practice/useListenable_useMemoized_example.dart';
import 'package:flutter_hooks_practice/usefuture_usememoized_example.dart';
import 'package:flutter_hooks_practice/use_texteditingcontroller_example.dart';
import 'package:flutter_hooks_practice/use_stream_example.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blue),
        useMaterial3: true
      ),
      home: const UseAnimationControllerExample()
    );
  }
}
