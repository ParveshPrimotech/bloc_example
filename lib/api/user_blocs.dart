import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/api/user_event.dart';
import 'package:untitled/api/user_repository.dart';
import 'package:untitled/api/user_states.dart';

class UserBloc extends Bloc<UserEvent, UserStates> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserLoadingStates()) {
    on<LoadUserEvent>(
      (event, emit) async {
        emit(UserLoadingStates());
        try {
          final users = await userRepository.getUsers();
          emit(UserLoadedStates(users));
        } catch (e) {
          emit(UserErrorState(e.toString()));
        }
      },
    );
  }
}
