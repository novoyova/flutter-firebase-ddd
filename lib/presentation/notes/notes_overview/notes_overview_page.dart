import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_ddd_course/application/auth/auth_bloc.dart';
import 'package:firebase_ddd_course/application/notes/note_actor/note_actor_bloc.dart';
import 'package:firebase_ddd_course/application/notes/note_watcher/note_watcher_bloc.dart';
import 'package:firebase_ddd_course/injection.dart';
import 'package:firebase_ddd_course/presentation/notes/notes_overview/widgets/notes_overview_body.dart';
import 'package:firebase_ddd_course/presentation/notes/notes_overview/widgets/uncompleted_switch.dart';
import 'package:firebase_ddd_course/presentation/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class NotesOverviewPage extends StatelessWidget {
  const NotesOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Reponsible for watching the notes from firestore
        BlocProvider<NoteWatcherBloc>(
            create: (context) => getIt<NoteWatcherBloc>()
              ..add(const NoteWatcherEvent.watchAllStarted())),

        // Responsible for deleting notes by long pressing on the note
        BlocProvider<NoteActorBloc>(
            create: (context) => getIt<NoteActorBloc>()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.maybeMap(
                unauthenticated: (_) =>
                    AutoRouter.of(context).replace(const SignInRoute()),
                orElse: () {},
              );
            },
          ),
          BlocListener<NoteActorBloc, NoteActorState>(
              listener: (context, state) {
            state.maybeMap(
              deleteFailure: (state) {
                FlushbarHelper.createError(
                  duration: const Duration(seconds: 5),
                  message: state.noteFailure.map(
                    unexpected: (_) =>
                        'Unexpected error occured while deleting, please contact support',
                    insufficientPermission: (_) => 'Insufficient permission ❌',
                    unableToUpdate: (_) => 'Impossible error',
                  ),
                ).show(context);
              },
              orElse: () {},
            );
          })
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Notes'),
            leading: IconButton(
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEvent.signedOut());
              },
              icon: const Icon(Icons.exit_to_app),
            ),
            actions: const [
              UncompletedSwitch(),
            ],
          ),
          body: const NotesOverviewBody(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(NoteFormRoute(editedNote: null));
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
