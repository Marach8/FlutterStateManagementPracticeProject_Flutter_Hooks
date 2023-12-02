import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';


class UseListenableAndUseMemoizedExample extends HookWidget {
  const UseListenableAndUseMemoizedExample({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = useListenable(useMemoized(() => CountDownTimer(number: 20)));
    return Scaffold(
      appBar: AppBar(title: const Text('CountDownTimer'), centerTitle: true),
      body: Center(child: Text(stream.value.toString()))
    );
  }
}



class CountDownTimer extends ValueNotifier<int>{
  late StreamSubscription subscription;
  CountDownTimer({required int number}): super(number){
    subscription = Stream.periodic(const Duration(seconds:1), (event) => number - event)
    .takeWhile((element) => element >= 0).listen((value) => this.value = value);
  }

  @override 
  void dispose(){subscription.cancel(); super.dispose();}
}