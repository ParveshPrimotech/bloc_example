import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/api/user_model.dart';

@immutable
abstract class UserStates extends Equatable {}

class UserLoadingStates extends UserStates {
  @override
  List<Object?> get props => [];
}

class UserLoadedStates extends UserStates {
  final List<UserModel> users;

  UserLoadedStates(this.users);

  @override
  List<Object?> get props => [users];
}

class UserErrorState extends UserStates {
  final String error;

  UserErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
