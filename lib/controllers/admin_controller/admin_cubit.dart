import 'package:bloc/bloc.dart';
import 'package:ecom/data/local/auth_local.dart';
import 'package:ecom/data/repository/auth_repository.dart';
import 'package:ecom/utils/exception.dart';
import 'package:ecom/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'admin_state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit() : super(AdminInitial());

  final form = GlobalKey<FormState>();
  final repository = AuthRepository.instance();
  Future<void> loginAdmin(String email, String password) async {
    try {
      emit(AdminLoading());
      final response = await repository.loginWithEmail(email, password);
      if (response) {
        await Future.delayed(const Duration(seconds: 2));
        SharedPrefWrapper.instance.setBool('isAdmin', true);
        emit(AdminSuccess());
      } else {
        emit(const AdminFail(error: "Wrong admin account"));
      }
    } on PlatformException catch (exception) {
      emit(AdminFail(code: exception.code, error: exception.message));
    } on RemoteException catch (error) {
      emit(AdminFail(error: error.errorMessage));
    } on Exception catch (e) {
      final clm = e.toString();
      emit(AdminFail(error: clm));
    }
  }

  Future<void> logOut() async {
    try {
      emit(AdminLoading());
      SharedPrefWrapper.instance.remove('isAdmin');
      emit(AdminInitial());
    } on PlatformException catch (exception) {
      emit(AdminFail(code: exception.code, error: exception.message));
    } on RemoteException catch (error) {
      emit(AdminFail(error: error.errorMessage));
    } on Exception catch (e) {
      final clm = e.toString();
      emit(AdminFail(error: clm));
    }
  }
}
