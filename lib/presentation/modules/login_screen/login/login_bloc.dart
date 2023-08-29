import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../common/service/local_manager/user_data_datasource/user_model.dart';
import '../../../../common/singletons.dart';
import '../../../common_widget/enum_common.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginUserEvent>(_onLogin);
  }
  Future<void> _onLogin(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      LoginInitialState(
        status: BlocStatusState.loading,
        viewModel: state.viewModel,
      ),
    );

    // final response = await _usecase.getListUserEntity();
    if (event.username == null || event.username?.trim() == '') {
      emit(
        LoginFailState(
          status: BlocStatusState.failure,
          viewModel: const _ViewModel(
            isLogin: false,
            errorMessage: 'Vui lòng nhập tài khoản',
          ),
        ),
      );
      return;
    }
    if (event.password == null || event.password?.trim() == '') {
      emit(
        LoginFailState(
          status: BlocStatusState.failure,
          viewModel: const _ViewModel(
            isLogin: false,
            errorMessage: 'Vui lòng nhập mật khẩu',
          ),
        ),
      );
      return;
    }
    try {
      final userCredential =
          await firebaseAuthService.signInWithEmailAndPassword(
              email: event.username!, password: event.password!);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userCredential.user?.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) async {
        if (documentSnapshot.exists) {
          await userDataData.setUser(UserModel(
              email: userCredential.user?.email,
              phoneNumber:
                  documentSnapshot.get(FieldPath(const ['phoneNumber'])),
              id: documentSnapshot.get(FieldPath(const ['doctorId'])),
              name: documentSnapshot.get(FieldPath(const ['name']))));
        } else {
          debugPrint('Document does not exist on the database');
        }
      });

      emit(
        LoginSuccessState(
          status: BlocStatusState.success,
          viewModel: state.viewModel.copyWith(
            isLogin: true,
            person: User(uuid: userCredential.user!.uid),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(
          LoginFailState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(
              isLogin: false,
              errorMessage: 'Không tìm thấy tài khoản',
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        emit(
          LoginFailState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(
              isLogin: false,
              errorMessage: 'Sai mật khẩu',
            ),
          ),
        );
      } else if (e.code == 'invalid-email') {
        emit(
          LoginFailState(
            status: BlocStatusState.failure,
            viewModel: const _ViewModel(
              isLogin: false,
              errorMessage: 'Vui lòng nhập email',
            ),
          ),
        );
      }
    } catch (e) {
      emit(
        LoginFailState(
          status: BlocStatusState.failure,
          viewModel: const _ViewModel(
            isLogin: false,
            errorMessage: 'Xảy ra lỗi',
          ),
        ),
      );
    }
  }
}

// var userList = [
//   User(name: 'PDA'),
// ];