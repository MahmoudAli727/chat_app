// ignore_for_file: unused_field, camel_case_types, file_names, sized_box_for_whitespace, non_constant_identifier_names

import 'package:chat_app/Screens/ChatPage.dart';
import 'package:chat_app/Screens/Cubit/chat/chat_cubit.dart';
import 'package:chat_app/Screens/Cubit/login/login_cubit_cubit.dart';
import 'package:chat_app/Screens/RegisterPage.dart';
import 'package:chat_app/const.dart';
import 'package:chat_app/widgets/CustomButton.dart';
import 'package:chat_app/widgets/TextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class loginPage extends StatelessWidget {
  static String id = "login";

  String? email;

  String? password;

  bool isloading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isloading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getmessages();
          Navigator.pushNamed(context, ChatPage.id, arguments: email);
          isloading = false;
        } else if (state is LoginFailure) {
          ShowSnackbar(context, state.errMessage);
          isloading = false;
        }
      },
      child: ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 226, 157, 47),
          body: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                        width: 100,
                        height: 100,
                        child: CircleAvatar(
                          backgroundImage: AssetImage(image),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Scholar Chat",
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Sign in",
                        style: TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextformField(
                      hintText: "Email",
                      onChange: (data) {
                        email = data;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextformField(
                      hintText: "Password",
                      onChange: (data) {
                        password = data;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                      Button: "login",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<LoginCubit>(context).loginSnackBar(
                              email: email!, password: password!);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "you don't have an account",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, RegisterPage.id);
                          },
                          child: const Text(
                            "  Sign Up",
                            style: TextStyle(
                                color: Color.fromARGB(255, 79, 126, 254),
                                fontSize: 20),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void ShowSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}
