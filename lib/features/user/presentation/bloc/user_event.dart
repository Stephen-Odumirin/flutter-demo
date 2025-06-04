import 'package:equatable/equatable.dart';
import '../../domain/entities/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object?> get props => [];
}

class LoadUsers extends UserEvent {}

class LoadUser extends UserEvent {
  final int id;
  const LoadUser(this.id);

  @override
  List<Object?> get props => [id];
}

class AddUserEvent extends UserEvent {
  final User user;
  const AddUserEvent(this.user);
}

class UpdateUserEvent extends UserEvent {
  final int id;
  final Map<String, dynamic> data;
  const UpdateUserEvent(this.id, this.data);
}

class DeleteUserEvent extends UserEvent {
  final int id;
  const DeleteUserEvent(this.id);
}
