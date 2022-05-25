import 'package:correctin/widgets/chat_person.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ChatPerson(),
        ChatPerson(),
        ChatPerson(),
        ChatPerson(),
        ChatPerson(),
        ChatPerson(),
        ChatPerson(),
        ChatPerson(),
        ChatPerson(),
        ChatPerson(),
        ChatPerson(),
      ],
    );
  }
}
