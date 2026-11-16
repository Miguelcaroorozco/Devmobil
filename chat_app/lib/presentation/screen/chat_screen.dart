import 'package:chat_app/presentation/widgets/her_message_bubble.dart';
import 'package:chat_app/presentation/widgets/my_message_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQPmP875ibQzL-JaqB6yjB3GNKLsI5ebf03NQmTjYY80g&s=10'),
          ),
        ),
        title: const Text('Mi love ¬_¬'),
      ),
      body: _Chatview(),
    );
  }
}

class _Chatview extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
          return (index % 2 ==0)
            ? MyMessageBubble()
            : HerMessageBubble();
        },))
      ],
    );
  } 
}