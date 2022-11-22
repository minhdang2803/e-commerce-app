part of 'admin_cubit.dart';

abstract class AdminState extends Equatable {
  const AdminState();
}

class AdminInitial extends AdminState {
  @override
  List<Object> get props => [];
}

class AdminLoading extends AdminState {
  @override
  List<Object?> get props => [];
}

class AdminSuccess extends AdminState {
  @override
  List<Object?> get props => [];
}

class AdminFail extends AdminState {
  final String? code;
  final String? error;
  const AdminFail({this.code, this.error});
  @override
  List<Object?> get props => [code, error];
}
