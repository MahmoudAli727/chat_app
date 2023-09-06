// import 'package:chat_app/main.dart';
import 'package:chat_app/Screens/ChatPage.dart';
import 'package:chat_app/Screens/Cubit/chat/chat_cubit.dart';
import 'package:chat_app/Screens/Cubit/login/login_cubit_cubit.dart';
import 'package:chat_app/Screens/Cubit/register/register_cubit.dart';
import 'package:chat_app/Screens/RegisterPage.dart';
import 'package:chat_app/Screens/loginPage.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => LoginCubit()),
    BlocProvider(create: (context) => RegisterCubit()),
    BlocProvider(create: (context) => ChatCubit()),
  ], child: const ChatApp()));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        loginPage.id: (context) => loginPage(),
        RegisterPage.id: (context) => RegisterPage(),
        ChatPage.id: (context) => ChatPage()
      },
      // home: loginPage(),
      initialRoute: loginPage.id,
    );
  }
}
