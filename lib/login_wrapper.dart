import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/bloc/auth_state.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'home_page.dart';

class LoginWrapper extends StatelessWidget {
  const LoginWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is Authenticated) {
          Future.microtask(() => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<AuthBloc>(),
                    child: const HomePage(),
                  ),
                ),
              ));
          return const SizedBox.shrink();
        }
        return const LoginPage();
      },
    );
  }
}
