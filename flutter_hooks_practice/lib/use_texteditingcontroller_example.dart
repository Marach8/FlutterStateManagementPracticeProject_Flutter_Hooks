import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class UseTextEditingControllerExample extends HookWidget {
  const UseTextEditingControllerExample({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final text = useState('');
    useEffect((){
      controller.addListener(() => text.value = controller.text);
      return null;
    }, [controller]);
    return Scaffold(
      appBar: AppBar(title: Text(text.value.isEmpty? 'FlutterHooks Demo': text.value), centerTitle: true),
      body: Column(
        children: [
          TextField(
            controller: controller
          ),
          const SizedBox(height: 10),
          Wrap(
            children: [
              Text(text.value.isEmpty ? 'YOU TYPED: whatever you type will appear here': 'YOU TYPED: ${text.value}'),
            ],
          )
        ]
      )
    );
  }
}