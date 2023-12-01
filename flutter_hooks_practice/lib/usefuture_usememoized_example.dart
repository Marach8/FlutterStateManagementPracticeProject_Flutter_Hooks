import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseFutureAndUseMemoizedExample extends HookWidget {
  const UseFutureAndUseMemoizedExample({super.key});

  @override
  Widget build(BuildContext context) {
    final future = useMemoized(() => NetworkAssetBundle(Uri.parse(url)).load(url)
      .then((data) => data.buffer.asUint8List()).then((data) => Image.memory(data)));
      final image = useFuture(future);
    return Scaffold(
      appBar: AppBar(title: const Text('HomePage'), centerTitle: true),
      body: Column(
        children: [image.data].marach().toList()
      )
    );
  }
}

extension Marach<T> on Iterable<T?>{
  Iterable<T> marach<E>([ E? Function(T?)? transform]) 
    => map(transform ?? (e) => e).where((e) => e != null).cast();
}


const url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSN_obgQ8LO0nfi7vQT2K6NNPPt_zzLF2HEYJAzA7s8g&s';