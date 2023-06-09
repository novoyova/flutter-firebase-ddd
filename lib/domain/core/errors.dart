import 'package:firebase_ddd_course/domain/core/failures.dart';

class UnexpectedValueError extends Error {
  final ValueFailure valueFailure;

  UnexpectedValueError(this.valueFailure);

  @override
  String toString() {
    const explaination =
        "Encountered a ValueFailure at an unrecoverable point. Terminating.";
    return Error.safeToString('$explaination Failure was: $valueFailure');
  }
}

class NotAuthenticatedError extends Error {}
