import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecases/login.dart';
import '../../domain/entities/token.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUsecase;
  final SharedPreferences prefs;

  AuthBloc({required this.loginUsecase, required this.prefs})
      : super(_initialState(prefs)) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  static AuthState _initialState(SharedPreferences prefs) {
    final saved = prefs.getString('token');
    if (saved != null) {
      return Authenticated(Token(saved));
    }
    return AuthInitial();
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await loginUsecase(event.username, event.password);
      await prefs.setString('token', token.token);
      emit(Authenticated(token));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) {
    prefs.remove('token');
    emit(AuthInitial());
  }
}
