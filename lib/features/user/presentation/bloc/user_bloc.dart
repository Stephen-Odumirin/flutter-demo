import 'package:bloc/bloc.dart';

import '../../domain/usecases/add_user.dart';
import '../../domain/usecases/delete_user.dart';
import '../../domain/usecases/get_user.dart';
import '../../domain/usecases/get_users.dart';
import '../../domain/usecases/update_user.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsers;
  final GetUser getUser;
  final AddUser addUser;
  final UpdateUser updateUser;
  final DeleteUser deleteUser;

  UserBloc({
    required this.getUsers,
    required this.getUser,
    required this.addUser,
    required this.updateUser,
    required this.deleteUser,
  }) : super(UserInitial()) {
    on<LoadUsers>(_onLoadUsers);
    on<LoadUser>(_onLoadUser);
    on<LoadUserByUsername>(_onLoadUserByUsername);
    on<AddUserEvent>(_onAddUser);
    on<UpdateUserEvent>(_onUpdateUser);
    on<DeleteUserEvent>(_onDeleteUser);
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await getUsers();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onLoadUser(LoadUser event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await getUser(event.id);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onLoadUserByUsername(
      LoadUserByUsername event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await getUsers();
      final user = users.firstWhere((u) => u.username == event.username);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onAddUser(AddUserEvent event, Emitter<UserState> emit) async {
    try {
      await addUser(event.user);
      add(LoadUsers());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onUpdateUser(UpdateUserEvent event, Emitter<UserState> emit) async {
    try {
      await updateUser(event.id, event.data);
      add(LoadUsers());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> _onDeleteUser(DeleteUserEvent event, Emitter<UserState> emit) async {
    try {
      await deleteUser(event.id);
      add(LoadUsers());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
