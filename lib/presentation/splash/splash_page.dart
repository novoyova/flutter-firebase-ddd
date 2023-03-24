import 'package:auto_route/auto_route.dart';
import 'package:firebase_ddd_course/application/auth/auth_bloc.dart';
import 'package:firebase_ddd_course/presentation/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
          initial: (_) {},
          authenticated: (_) {
            debugPrint('I am authenticated!');
            AutoRouter.of(context).replace(const NotesOverviewRoute());
          },
          unauthenticated: (_) {
            debugPrint('I am unauthenticated!');
            AutoRouter.of(context).replace(const SignInRoute());
          },
        );
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
