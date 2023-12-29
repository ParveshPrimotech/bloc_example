import 'package:equatable/equatable.dart';

@override
abstract class UserEvent extends Equatable{
  const UserEvent();
}

class LoadUserEvent extends UserEvent{
  @override
  List<Object?> get props=>[];
}