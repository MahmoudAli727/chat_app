// ignore_for_file: unused_local_variable, file_names
import 'package:chat_app/Screens/Cubit/chat/chat_cubit.dart';
import 'package:chat_app/const.dart';
import 'package:chat_app/models/messages.dart';
import 'package:chat_app/widgets/ChatBuble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  static String id = "Chat";

  // ChatPage({super.key});
  final _controller = ScrollController();

  TextEditingController controller = TextEditingController();

  List<Messages> messagesList = [];

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "ChatApp",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                if (state is ChatSuccess) {
                  messagesList = state.messageslist;
                }
              },
              builder: (context, state) {
                //new edit
                messagesList = BlocProvider.of<ChatCubit>(context).messageslist;
                return ListView.builder(
                  reverse: true,
                  controller: _controller,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].id == email
                        ? ChatBuble(
                            message: messagesList[index],
                          )
                        : ChatBubleForFriend(message: messagesList[index]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: controller,
              onSubmitted: (value) {
                if (value != '') {
                  BlocProvider.of<ChatCubit>(context)
                      .sendMessages(message: value, email: email);
                  controller.clear();
                  _controller.animateTo(0,
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn);
                }
              },
              decoration: InputDecoration(
                hintText: "Send a message",
                suffixIcon: const Icon(
                  Icons.send,
                  color: KprimaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(
                    color: KprimaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
