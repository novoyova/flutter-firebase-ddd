import 'package:dartz/dartz.dart';
import 'package:firebase_ddd_course/domain/notes/note.dart';
import 'package:firebase_ddd_course/domain/notes/note_failure.dart';
import 'package:kt_dart/kt.dart';

abstract class INoteRepository {
  // Watch notes
  Stream<Either<NoteFailure, KtList<Note>>> watchAll();

  // Watch uncompleted notes
  Stream<Either<NoteFailure, KtList<Note>>> watchUncompleted();

  // CUD
  Future<Either<NoteFailure, Unit>> create(Note note);
  Future<Either<NoteFailure, Unit>> update(Note note);
  Future<Either<NoteFailure, Unit>> delete(Note note);
}
