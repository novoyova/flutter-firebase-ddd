import 'package:auto_route/auto_route.dart';
import 'package:firebase_ddd_course/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:firebase_ddd_course/injection.dart';
import 'package:firebase_ddd_course/presentation/sign_in/widgets/sign_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: BlocProvider(
        create: (context) => getIt<SignInFormBloc>(),
        child: const SignInForm(),
      ),
    );
  }
}
