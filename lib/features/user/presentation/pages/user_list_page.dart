import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import 'user_page.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UsersLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<UserBloc>().add(LoadUsers());
              },
              child: ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  final user = state.users[index];
                  return ListTile(
                    title: Text(user.username),
                    subtitle: Text(user.email),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<UserBloc>(),
                            child: UserPage(userId: user.id),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
      // Swipe down to refresh the list
    );
  }
}
