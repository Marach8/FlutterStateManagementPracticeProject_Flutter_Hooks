import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSN_obgQ8LO0nfi7vQT2K6NNPPt_zzLF2HEYJAzA7s8g&s';

class StreamControllerInHooks extends HookWidget {
  const StreamControllerInHooks({super.key});

  @override
  Widget build(BuildContext context) {
    late final StreamController<double> controller;
    controller = StreamController<double>(onListen: (){controller.sink.add(0.0);});
    return Scaffold(
      appBar: AppBar(title: const Text('Homepage'), centerTitle: true),
      body: StreamBuilder<double>(
        stream: controller.stream,
        builder: (context, snapshot) {
          if(!snapshot.hasData){return const Center(child: CircularProgressIndicator());}
          else{
            final rotation = snapshot.data!;
            return GestureDetector(
              onTap: (){controller.sink.add(rotation + 10.0);},
              child: RotationTransition(
                turns: AlwaysStoppedAnimation(rotation/360),
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(url, fit:BoxFit.cover,),
                  )
                ),
              ),
            );
          }
        }
      )
    );
  }
}