import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';
import 'package:uniLOLverse/app/widgets/widgets.dart';
import 'package:go_router/go_router.dart';

enum AuthMode { login, register }

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(pageId: PageId.auth, context: context),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/armor_of_the_fifth_age_taric_by_davidpan.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.go('/home');
            } else if (state is AuthFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator(color: Colors.red));
              }

              return Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 450, maxHeight: 500),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(150),
                    ),
                    child: AuthForm(
                      onLogin: (email, password) {
                        context.read<AuthBloc>().add(
                          AuthLogin(email: email, password: password),
                        );
                      },
                      onRegister: (email, password) {
                        context.read<AuthBloc>().add(
                          AuthRegister(email: email, password: password),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}