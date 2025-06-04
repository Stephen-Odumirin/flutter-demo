import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'login_wrapper.dart';

void main() {
  final authRemoteDataSource = AuthRemoteDataSourceImpl(http.Client());
  final authRepository = AuthRepositoryImpl(remoteDataSource: authRemoteDataSource);
  runApp(MyApp(repository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl repository;
  const MyApp({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FakeStore App',
      home: RepositoryProvider.value(
        value: repository,
        child: BlocProvider(
          create: (_) => AuthBloc(loginUsecase: Login(repository)),
          child: const LoginWrapper(),
        ),
      ),
    );
  }
}
