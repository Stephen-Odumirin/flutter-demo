import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'login_wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final authRemoteDataSource = AuthRemoteDataSourceImpl(http.Client());
  final authRepository = AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
  runApp(MyApp(repository: authRepository, prefs: prefs));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl repository;
  final SharedPreferences prefs;
  const MyApp({Key? key, required this.repository, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FakeStore App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.teal,
      ),
      home: RepositoryProvider.value(
        value: repository,
        child: BlocProvider(
          create: (_) => AuthBloc(loginUsecase: Login(repository), prefs: prefs),
          child: const LoginWrapper(),
        ),
      ),
    );
  }
}
