import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseAnimationControllerExample extends HookWidget {
  const UseAnimationControllerExample({super.key});

  final imageHeight = 300;
  final url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSN_obgQ8LO0nfi7vQT2K6NNPPt_zzLF2HEYJAzA7s8g&s';

  @override
  Widget build(BuildContext context) {
    final opacityController = useAnimationController(
      duration: const Duration(seconds: 1), lowerBound: 0.0, upperBound: 1.0, initialValue: 1.0,
    );
    final sizeController = useAnimationController(
      duration: const Duration(seconds: 1), lowerBound: 0.0, upperBound: 1.0, initialValue: 1.0,
      //animationBehavior: AnimationBehavior.preserve
    );
    final controller = useScrollController();
    useEffect((){
      controller.addListener((){
        final newOpacity = max(imageHeight - controller.offset, 0.0);
        final normalized = newOpacity.normalize(0.0, imageHeight).toDouble();
        opacityController.value = sizeController.value = normalized;
      });
      return null;
    },[controller]);
    return Scaffold(
      appBar: AppBar(title: const Text('useAnimationController Example'), centerTitle: true),
      body: Column (
        children: [
          SizeTransition(
            sizeFactor: sizeController,
            child: FadeTransition(
              opacity: opacityController,
              child: Image.network(
                url, height: imageHeight.toDouble(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 100, controller: controller,
              itemBuilder: (context, index) => ListTile(
                title: Text('Person ${index + 1}')
              )
            )
          )
        ],
      )
    );
  }
}


extension Normalize on num{
  num normalize(num rangeMin, num rangeMax, [num normalizedRangeMin = 0.0, num normalizedRangeMax = 1.0])
  => (normalizedRangeMax - normalizedRangeMin) * ((this - rangeMin) / (rangeMax - rangeMin)) + normalizedRangeMin;
}