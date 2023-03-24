import 'package:dartz/dartz.dart';
import 'package:firebase_ddd_course/domain/notes/i_note_repository.dart';
import 'package:firebase_ddd_course/domain/notes/note.dart';
import 'package:firebase_ddd_course/domain/notes/note_failure.dart';
import 'package:firebase_ddd_course/domain/notes/value_objects.dart';
import 'package:firebase_ddd_course/presentation/notes/note_form/misc/todo_item_primitive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:kt_dart/kt.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';
part 'note_form_bloc.freezed.dart';

@injectable
class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final INoteRepository _noteRepository;

  NoteFormBloc(this._noteRepository) : super(NoteFormState.initial()) {
    on<NoteFormEvent>((event, emit) async {
      await event.map(
        initialized: (e) {
          emit(e.initialNoteOption.fold(
            () => state,
            (initialNote) => state.copyWith(
              note: initialNote,
              isEditing: true,
            ),
          ));
        },
        bodyChanged: (e) {
          emit(state.copyWith(
            note: state.note.copyWith(
              body: NoteBody(e.bodyStr),
            ),
            saveFailureOrSuccessOption: none(),
          ));
        },
        colorChanged: (e) {
          emit(state.copyWith(
            note: state.note.copyWith(
              color: NoteColor(e.color),
            ),
            saveFailureOrSuccessOption: none(),
          ));
        },
        todosChanged: (e) {
          emit(state.copyWith(
            note: state.note.copyWith(
              todos: ListThree(e.todos.map(
                (primitive) => primitive.toDomain(),
              )),
            ),
            saveFailureOrSuccessOption: none(),
          ));
        },
        saved: (e) async {
          Either<NoteFailure, Unit>? failureOrSuccess;

          emit(state.copyWith(
            isSaving: true,
            saveFailureOrSuccessOption: none(),
          ));

          if (state.note.failureOption.isNone()) {
            failureOrSuccess = state.isEditing
                ? await _noteRepository.update(state.note)
                : await _noteRepository.create(state.note);
          }

          emit(state.copyWith(
            isSaving: false,
            showErrorMessages: true,
            saveFailureOrSuccessOption: optionOf(failureOrSuccess),
          ));
        },
      );
    });
  }
}
