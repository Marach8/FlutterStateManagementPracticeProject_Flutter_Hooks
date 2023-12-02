import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

const url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSN_obgQ8LO0nfi7vQT2K6NNPPt_zzLF2HEYJAzA7s8g&s';

class UseReducerExample extends HookWidget {
  const UseReducerExample({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = useReducer<StateObject, Actions?>((StateObject state, Actions? actions) => 
      state.reduce(state, actions), initialState: const StateObject.zero(), initialAction: null);
    return Scaffold(
      appBar: AppBar(title: const Text('UseReducer Demo'), centerTitle: true),
      body: Column(
        children: [
          Wrap(
            children: [
              CustomButton(buttonName: 'RotateLeft', storage: storage, action: Actions.rotateLeft),
              CustomButton(buttonName: 'RotateRight', storage: storage, action: Actions.rotateRight),
              CustomButton(buttonName: 'IncreaseOpaciIty', storage: storage, action: Actions.alphaPlus),
              CustomButton(buttonName: 'DecreaseOpacity', storage: storage, action: Actions.alphaMinus)
            ]
          ),
          const SizedBox(height: 100),
          Opacity(
            opacity: storage.state.alpha,
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(storage.state.rotatingAngle/360),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.network(url, fit:BoxFit.cover,),
              ),
            ),
          ),
        ]
      )
    );
  }
}



enum Actions {rotateLeft, rotateRight, alphaPlus, alphaMinus}

@immutable
class StateObject{
  final double rotatingAngle, alpha;
  const StateObject({required this.rotatingAngle, required this.alpha});

  const StateObject.zero(): rotatingAngle = 0.0, alpha = 1.0;

  StateObject rotateLeft() => StateObject(alpha: alpha, rotatingAngle: rotatingAngle - 10.0);
  StateObject rotateRight() => StateObject(alpha: alpha, rotatingAngle: rotatingAngle + 10.0);
  StateObject alphaPlus() => StateObject(alpha: min(alpha + 0.1, 1.0), rotatingAngle: rotatingAngle);
  StateObject alphaMinus() => StateObject(alpha: max(alpha - 0.1, 0.0), rotatingAngle: rotatingAngle);

  StateObject reduce (StateObject formerState, Actions? actions){
    switch(actions){
      case Actions.rotateRight: return formerState.rotateRight();
      case Actions.rotateLeft: return formerState.rotateLeft();
      case Actions.alphaPlus: return formerState.alphaPlus();
      case Actions.alphaMinus: return formerState.alphaMinus();
      case null: return formerState;
    }
  }
}


class CustomButton extends StatelessWidget {
  final String buttonName; final Actions action;
  final Store<StateObject, Actions?> storage;
  const CustomButton({required this.buttonName, required this.storage, required this.action, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => storage.dispatch(action),
      child: Text(buttonName)
    );
  }
}
