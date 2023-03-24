import 'package:firebase_ddd_course/domain/notes/note.dart';
import 'package:flutter/material.dart';

class ErrorNoteCard extends StatelessWidget {
  final Note note;

  const ErrorNoteCard({
    super.key,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.error,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            Text(
              'Invalid note, please contact support',
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 2),
            Text(
              'Details for nerds:',
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            Text(
              note.failureOption.fold(
                () => '',
                (f) => f.toString(),
              ),
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
