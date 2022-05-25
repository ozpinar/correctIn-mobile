import 'package:flutter/material.dart';

class ChatPerson extends StatelessWidget {
  const ChatPerson({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 0,
          blurRadius: 2,
          offset: const Offset(0, 0),
        ),
      ]),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Image.asset(
              "assets/images/profile.png",
              scale: 0.7,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                child: Text(
                  "Emiliano Espana",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Text("I think you are learning italian as well!"),
            ],
          )
        ],
      ),
    );
  }
}
