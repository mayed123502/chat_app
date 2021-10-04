import 'dart:io'  ;

import 'package:chat/auth/log_in_screen.dart';
import 'package:chat/auth/services.dart';
import 'package:chat/auth/user_picker.dart';
import 'package:chat/provider/loading.dart';
import 'package:chat/provider/select_image.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatelessWidget {
  static const String id = 'SignUpScreen';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  UserImagePicker(),
                  buildTextFormField(
                      validator: validateEmail,
                      controller: emailController,
                      text: 'Email Address',
                      keyboardType: TextInputType.emailAddress),
                  buildTextFormField(
                      validator: validateUserName,
                      controller: usernameController,
                      text: 'Username',
                      keyboardType: TextInputType.name),
                  buildTextFormField(
                      obscureText: true,
                      validator: validatePassword,
                      controller: passwordController,
                      text: 'Password',
                      keyboardType: TextInputType.visiblePassword),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      print(passwordController.text.trim().toString());
                      if (Provider.of<SelectImage>(context, listen: false).isSelectImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please pick an image.")));

                        return;
                      }

                      if (_formKey.currentState.validate()) {
                        await createUser(
                                emailController.text.trim().toString(),
                                passwordController.text.trim().toString(),
                                usernameController.text.trim().toString(),
                            Provider.of<SelectImage>(context, listen: false).image  ,
                                context)
                            .then((value) {
                          Provider.of<IsLoading>(context, listen: false)
                              .notLoading();
                          Navigator.pushNamed(context, ChatScreen.id);
                        });
                      }
                    },
                    child: Provider.of<IsLoading>(
                              context,
                            ).isLoading ==
                            true
                        ? CircularProgressIndicator()
                        : Container(
                            width: 80,
                            height: 35,
                            alignment: Alignment.center,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, LoginScreen.id);
                    },
                    child: Text(
                      "I already have an account",
                      style: TextStyle(
                        color: Colors.pink,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
