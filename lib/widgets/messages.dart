import 'package:bubble/bubble.dart';
import 'package:chat/widgets/messageBubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              reverse: true,
              itemCount: snap.data.docs.length,
              itemBuilder: (ctx, index) {
                DocumentSnapshot doc = snap.data.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MessageBubble(
                    doc['text'],
                    doc['username'],
                    doc['userId'] == user.uid,
                  ),
                );
              });
        });
  }
}
// MessageBubble(doc['text'],doc['username'],doc['userId']==user.uid,),
