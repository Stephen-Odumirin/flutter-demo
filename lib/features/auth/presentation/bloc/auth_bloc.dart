import 'package:bloc/bloc.dart';

import '../../domain/usecases/login.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUsecase;

  AuthBloc({required this.loginUsecase}) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await loginUsecase(event.username, event.password);
      emit(Authenticated(token));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}
