import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (ctx, chatSnapshots) {
        if (chatSnapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
          return Center(
            child: Text('No messages found'),
          );
        }

        if (chatSnapshots.hasError) {
          return Center(
            child: Text('Something went wrong...'),
          );
        }

        final loadedMessages = chatSnapshots.data!.docs;

        return ListView.builder(
          padding: EdgeInsets.only(bottom: 40, left: 13, right: 13),
          reverse: false,
          itemCount: loadedMessages!.length,
          itemBuilder: (ctx, index) => Text(
            loadedMessages[index].data()['text'],
          ),
        );
      },
    );
  }
}


// this code is from chatGPT.
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ChatMessages extends StatelessWidget {
//   const ChatMessages({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('chat')
//           .orderBy(
//             'createdAt',
//             descending: true,
//           )
//           .snapshots(),
//       builder: (ctx, chatSnapshots) {
//         if (chatSnapshots.connectionState == ConnectionState.waiting) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (chatSnapshots.hasError) {
//           return const Center(
//             child: Text('Something went wrong...'),
//           );
//         }
//         if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
//           return const Center(
//             child: Text('No messages found'),
//           );
//         }

//         final loadedMessages = chatSnapshots.data!.docs;

//         return ListView.builder(
//           padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
//           reverse: true, // Display newest messages first
//           itemCount: loadedMessages.length,
//           itemBuilder: (ctx, index) {
//             final messageData =
//                 loadedMessages[index].data() as Map<String, dynamic>;
//             final messageText =
//                 messageData['text'] as String? ?? 'No message content';

//             return Text(messageText);
//           },
//         );
//       },
//     );
//   }
// }

