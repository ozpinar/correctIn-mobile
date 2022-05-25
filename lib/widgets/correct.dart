import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Correct extends StatefulWidget {
  final List words;
  const Correct({Key? key, required this.words}) : super(key: key);

  @override
  State<Correct> createState() => _CorrectState();
}

class _CorrectState extends State<Correct> {
  List controllers = [];
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ...widget.words.map((word) {
          controllers.add(TextEditingController(
            text: word['value'],
          ));
          return TextField(
            controller: controllers[widget.words.indexOf(word)],
          );
        }).toList(),
      ],
    );
  }
}
