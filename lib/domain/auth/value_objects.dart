import 'package:dartz/dartz.dart';
import 'package:firebase_ddd_course/domain/core/failures.dart';
import 'package:firebase_ddd_course/domain/core/value_object.dart';
import 'package:firebase_ddd_course/domain/core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  // private constructor
  const EmailAddress._(this.value);

  factory EmailAddress(String input) {
    return EmailAddress._(validateEmailAddress(input));
  }
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  // private constructor
  const Password._(this.value);

  factory Password(String input) {
    return Password._(validatePassword(input));
  }
}
