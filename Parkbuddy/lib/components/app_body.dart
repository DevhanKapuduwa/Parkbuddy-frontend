import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';

class AppBody extends StatelessWidget {
  final List<Map<String, dynamic>> messages;

  AppBody({required this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        bool isUserMessage = messages[index]['isUserMessage'] ?? false;
        Message message = messages[index]['message'];

        return Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          alignment:
              isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.blue : Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message.text!.text?[0] ?? '',
              style:
                  TextStyle(color: isUserMessage ? Colors.white : Colors.red),
            ),
          ),
        );
      },
    );
  }
}
