import 'package:dartz/dartz.dart';
import 'package:firebase_ddd_course/domain/auth/auth_failure.dart';
import 'package:firebase_ddd_course/domain/auth/user.dart';
import 'package:firebase_ddd_course/domain/auth/value_objects.dart';

// Using this interface allows us to write sign-in form application logic
// without having a clue about how the authentication is actually implemented

// Simplify the interface of two classes [FirebaseAuth, GoogleSignIn]
// into just one class using IAuthFacade (role of facade)
// Unit: like void don't return value
abstract class IAuthFacade {
  Future<Option<User>> getSignedInUser();

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });

  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<void> signOut();
}
