import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../../../user/presentation/bloc/user_event.dart';
import '../../../../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is Authenticated) {
                  context
                      .read<UserBloc>()
                      .add(LoadUserByUsername(_usernameController.text));
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const HomePage()),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                } else if (state is AuthError) {
                  return Text(state.message);
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          LoginEvent(
                            _usernameController.text,
                            _passwordController.text,
                          ),
                        );
                  },
                  child: const Text('Login'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
