// ignore_for_file: unused_local_variable, depend_on_referenced_packages, non_constant_identifier_names

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> RegisterSnackBar(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential auth = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == "weak-password") {
        emit(RegisterFailure(errMessage: "weak password"));
      } else if (ex.code == "email-already-in-use") {
        emit(RegisterFailure(errMessage: "email already exists"));
      }
    } catch (e) {
      emit(RegisterFailure(errMessage: e.toString()));
    }
  }
}
