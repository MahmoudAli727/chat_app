// ignore_for_file: must_be_immutable

part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  final List<Messages> messageslist;
  ChatSuccess({required this.messageslist});
}
