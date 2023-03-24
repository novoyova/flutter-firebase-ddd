import 'package:firebase_ddd_course/domain/core/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_ddd_course/domain/core/value_object.dart';
import 'package:firebase_ddd_course/domain/core/value_transformers.dart';
import 'package:firebase_ddd_course/domain/core/value_validators.dart';
import 'package:flutter/material.dart';
import 'package:kt_dart/kt.dart';

class NoteBody extends ValueObject<String> {
  static const maxLength = 1000;

  @override
  final Either<ValueFailure<String>, String> value;

  const NoteBody._(this.value);

  factory NoteBody(String input) {
    return NoteBody._(
      validateMaxStringLength(input, maxLength).flatMap(validateStringNotEmpty),
    );
  }
}

class TodoName extends ValueObject<String> {
  static const maxLength = 30;

  @override
  final Either<ValueFailure<String>, String> value;

  const TodoName._(this.value);

  factory TodoName(String input) {
    return TodoName._(
      validateMaxStringLength(input, maxLength)
          .flatMap(validateStringNotEmpty)
          .flatMap(validateSingleLine),
    );
  }
}

class NoteColor extends ValueObject<Color> {
  static const List<Color> predefinedColors = [
    Color(0xFFFAFAFA), // canvas
    Color(0xFFFA8072), // salmon
    Color(0xFFFEDC56), // mustard
    Color(0xFFD0F0C0), // tea
    Color(0XFFFCA3B7), // flamingo
    Color(0xFF997950), // tortilla
    Color(0xFFFFFDD0), // cream
  ];

  @override
  final Either<ValueFailure<Color>, Color> value;

  const NoteColor._(this.value);

  factory NoteColor(Color input) {
    return NoteColor._(
      right(makeColorOpaque(input)),
    );
  }
}

class ListThree<T> extends ValueObject<KtList<T>> {
  static const maxLength = 3;

  @override
  final Either<ValueFailure<KtList<T>>, KtList<T>> value;

  const ListThree._(this.value);

  factory ListThree(KtList<T> input) {
    return ListThree._(
      validateMaxListLength(input, maxLength),
    );
  }

  int get length {
    return value.getOrElse(() => emptyList()).size;
  }

  bool get isFull {
    return length == maxLength;
  }
}
