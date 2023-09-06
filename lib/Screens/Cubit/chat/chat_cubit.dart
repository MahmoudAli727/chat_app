// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:chat_app/models/messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  void sendMessages({required String message, required String email}) {
    messages.add({
      'message': message,
      "createdAt": DateTime.now(),
      "id": email,
    });
  }

  List<Messages> messageslist = [];

  void getmessages() {
    messages.orderBy("createdAt", descending: true).snapshots().listen((event) {
      messageslist.clear();
      for (var doc in event.docs) {
        messageslist.add(Messages.fromJson(doc));
      }
      emit(ChatSuccess(messageslist: messageslist));
    });
  }
}
