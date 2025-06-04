import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  final AuthRepositoryImpl repository;
  final SharedPreferences prefs;
  const SplashPage({Key? key, required this.repository, required this.prefs}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => RepositoryProvider.value(
            value: widget.repository,
            child: BlocProvider(
              create: (_) => AuthBloc(loginUsecase: Login(widget.repository), prefs: widget.prefs),
              child: const LoginWrapper(),
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.store, size: 80, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
