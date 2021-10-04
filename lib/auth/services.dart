
import 'dart:io';

import 'package:chat/provider/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

TextFormField buildTextFormField(
    {String text,
    TextInputType keyboardType,
    TextEditingController controller,
    Function validator,
    bool obscureText}) {
  return TextFormField(
    obscureText: obscureText == null ? false : true,
    validator: validator,
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(color: Colors.black.withOpacity(.6)),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.pink),
      ),
    ),
  );
}

String validatePassword(String value) {
  print(value);
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (value.length >= 10 &&
        !value.contains(RegExp(r'\W')) &&
        RegExp(r'\d+\w*\d+').hasMatch(value))
      return 'Enter valid password';
    else
      return null;
  }
}

String validateEmail(String value) {
  Pattern pattern =
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value) || value == null)
    return 'Enter a valid email address';
  else
    return null;
}

String validateUserName(String value) {
  if (value.isEmpty)
    return 'Enter a valid username address';
  else
    return null;
}

Future<void> createUser(
    String email, String pass, String username,File image,  BuildContext context) async {
  Provider.of<IsLoading>(context, listen: false).Loading();
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass);
    FirebaseStorage.instance.ref();
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user.uid)
        .set({
      'email': email,
      'username': username, // John Doe
      'password': pass,
    });

  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));

    Provider.of<IsLoading>(context, listen: false).notLoading();
  }
}

Future<void> signIn(String email, String pass, BuildContext context) async {
  Provider.of<IsLoading>(context, listen: false).Loading();

  var snackBar;
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pass);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.code)));

    Provider.of<IsLoading>(context, listen: false).notLoading();
  }
}



