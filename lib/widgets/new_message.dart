import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final myController = TextEditingController();
  String enteredMessage = '';
  sendMessage() async{

    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userDate =await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'username':userDate['username'],
      'userId':user.uid
    });
    myController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: 'Send a message ... ',
              ),
              onChanged: (val) {
                setState(() {
                  enteredMessage = val;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            onPressed: enteredMessage.trim().isEmpty ? null : sendMessage,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
