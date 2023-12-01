import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseStreamExample extends HookWidget {
  const UseStreamExample({super.key});

  @override
  Widget build(BuildContext context) {
    final dateTime = useStream(getTime());
    return Scaffold(
      appBar: AppBar(title: Text(dateTime.data ?? 'FlutterHooks'), centerTitle: true)
    );
  }
}


Stream<String> getTime() => 
Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now().toIso8601String());