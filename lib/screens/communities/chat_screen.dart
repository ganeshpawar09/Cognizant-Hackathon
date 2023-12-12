import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final String communityId;

  ChatScreen({required this.communityId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      body: ChatMessages(communityId: communityId),
    );
  }
}

class ChatMessages extends StatelessWidget {
  final String communityId;

  ChatMessages({required this.communityId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
    // StreamBuilder(
    //   stream: FirebaseFirestore.instance
    //       .collection('communities')
    //       .doc(communityId)
    //       .collection('messages')
    //       .orderBy('timestamp')
    //       .snapshots(),
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData) {
    //       return CircularProgressIndicator();
    //     }

    //     var messages = snapshot.data.docs;

    //     // Implement UI to display messages
    //     return ListView.builder(
    //       itemCount: messages.length,
    //       itemBuilder: (context, index) {
    //         var message = messages[index];
    //         return ListTile(
    //           title: Text(message['text']),
    //           subtitle: Text(message['sender']),
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
