// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_cubit_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginCubitInitial());

  Future<void> loginSnackBar(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      // ignore: unused_local_variable
      UserCredential auth = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
// ignore: unused_catch_clause
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "user-not-found") {
        emit(LoginFailure(errMessage: "user not found"));
      } else if (ex.code == "wrong-password") {
        emit(LoginFailure(errMessage: "wrong password"));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: "something went wrong"));
    }
  }
}
