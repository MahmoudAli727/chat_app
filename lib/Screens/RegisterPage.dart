// import 'package:chat_app/const.dart';
// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, file_names

import 'package:chat_app/Screens/Cubit/register/register_cubit.dart';
import 'package:chat_app/const.dart';
import 'package:chat_app/widgets/CustomButton.dart';
import 'package:chat_app/widgets/TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  static String id = "Rigester";

  String? email;

  String? password;

  GlobalKey<FormState> formKey = GlobalKey();

  bool isloading = false;

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
      if (state is RegisterLoading) {
        isloading = true;
      } else if (state is RegisterSuccess) {
        Navigator.pop(context);
        isloading = false;
      } else if (state is RegisterFailure) {
        ShowSnackBar(context, state.errMessage);
        isloading = false;
      }
    }, builder: (context, state) {
      return ModalProgressHUD(
        inAsyncCall: isloading,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 240, 36, 77),
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
                    // ChatApp()
                    Container(
                      width: 100,
                      height: 100,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(
                            // "assets/pngtree-user-login-or-authenticate-icon-on-gray-background-flat-icon-ve-png-image_1742031 (1).jpg"),
                            image),
                      ),
                    ),
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
                        "Sign Up",
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
                      Button: "Sign Up",
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .RegisterSnackBar(
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
                          "You already have an account",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "  Sign in",
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
      );
    });
  }

  void ShowSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> RegisterSnackBar() async {
    // ignore: unused_local_variable
    UserCredential auth = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
