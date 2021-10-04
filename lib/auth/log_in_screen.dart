import 'package:chat/auth/services.dart';
import 'package:chat/auth/sign_up_screen.dart';
import 'package:chat/provider/loading.dart';
import 'package:chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String id = 'LoginScreen';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
                  buildTextFormField(
                      validator: validateEmail,
                      controller: emailController,
                      text: 'Email Address',
                      keyboardType: TextInputType.emailAddress),
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
                      if (_formKey.currentState.validate()) {
                        await signIn(
                                emailController.text.trim().toString(),
                                passwordController.text.trim().toString(),
                                context)
                            .then((value) {
                          Provider.of<IsLoading>(context, listen: false)
                              .notLoading();
                          Navigator.pushNamed(context, ChatScreen.id);
                        });
                      }
                    },
                    child: Container(
                      width: 80,
                      height: 35,
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
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
                      Navigator.pushNamed(context, SignUpScreen.id);
                    },
                    child: Text(
                      "Create new account",
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
