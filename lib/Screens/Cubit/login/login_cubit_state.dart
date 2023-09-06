// ignore_for_file: must_be_immutable

part of 'login_cubit_cubit.dart';

@immutable
abstract class LoginState {}

class LoginCubitInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  String errMessage;
  LoginFailure({required this.errMessage});
}
