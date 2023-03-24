import 'package:firebase_ddd_course/domain/core/value_object.dart';
import 'package:firebase_ddd_course/domain/notes/note.dart';
import 'package:firebase_ddd_course/domain/notes/todo_item.dart';
import 'package:firebase_ddd_course/domain/notes/value_objects.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kt_dart/kt.dart';

part 'note_dtos.freezed.dart';
part 'note_dtos.g.dart';

/* DTO = Data Transfer Object
DTO does not have any behavior except for storage, 
retrieval, serialization and deserialization of its own data 
(mutators, accessors, parsers and serializers). 

In other words, DTOs are simple objects that
should not contain any business logic but may contain serialization and 
deserialization mechanisms for transferring data over the wire
*/

@freezed
abstract class NoteDto implements _$NoteDto {
  const NoteDto._();

  // ignore: invalid_annotation_target
  @JsonSerializable(explicitToJson: true)
  const factory NoteDto({
    // Since we do not want to store id along with other fields
    // ignore: invalid_annotation_target
    @JsonKey(ignore: true) String? id,

    /**
     * -- identifier: id
     * {
     *    body: "some string",
     *    color: 1132131
     *    todos: [
     *        ...
     *    ]
     * }
     */

    required String body,
    required int color,
    required List<TodoItemDto> todos,
    // Placeholder --> Time on the server
    @ServerTimestampConverter() required FieldValue serverTimestamp,
  }) = _NoteDto;

  factory NoteDto.fromDomain(Note note) {
    return NoteDto(
      id: note.id.getOrCrash(),
      body: note.body.getOrCrash(),
      color: note.color.getOrCrash().value,
      todos: note.todos
          .getOrCrash()
          .map((todoItem) => TodoItemDto.fromDomain(todoItem))
          .asList(),
      serverTimestamp: FieldValue.serverTimestamp(),
    );
  }

  Note toDomain() {
    return Note(
      id: UniqueId.fromUniqueString(id!),
      body: NoteBody(body),
      color: NoteColor(Color(color)),
      todos: ListThree(todos.map((dto) => dto.toDomain()).toImmutableList()),
    );
  }

  factory NoteDto.fromJson(Map<String, dynamic> json) =>
      _$NoteDtoFromJson(json);

  factory NoteDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    return NoteDto.fromJson(doc.data()!).copyWith(id: doc.id);
  }
}

class ServerTimestampConverter implements JsonConverter<FieldValue, Object> {
  // Need to have const constructor in order to use as annotation
  const ServerTimestampConverter();

  @override
  FieldValue fromJson(Object json) {
    return FieldValue.serverTimestamp();
  }

  @override
  Object toJson(FieldValue fieldValue) => fieldValue;
}

@freezed
abstract class TodoItemDto implements _$TodoItemDto {
  // (implements) need to provide default constructor
  const TodoItemDto._();

  const factory TodoItemDto({
    required String id,
    required String name,
    required bool done,
  }) = _TodoItemDto;

  factory TodoItemDto.fromDomain(TodoItem todoItem) {
    return TodoItemDto(
      id: todoItem.id.getOrCrash(),
      name: todoItem.name.getOrCrash(),
      done: todoItem.done,
    );
  }

  // Because we include regular member function,
  // we need to change the definition of our freeze data class (implements)
  TodoItem toDomain() {
    return TodoItem(
      id: UniqueId.fromUniqueString(id),
      name: TodoName(name),
      done: done,
    );
  }

  factory TodoItemDto.fromJson(Map<String, dynamic> json) =>
      _$TodoItemDtoFromJson(json);
}
