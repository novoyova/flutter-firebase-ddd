import 'package:firebase_ddd_course/domain/notes/note.dart';
import 'package:firebase_ddd_course/presentation/notes/notes_overview/notes_overview_page.dart';
import 'package:firebase_ddd_course/presentation/sign_in/sign_in_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_ddd_course/presentation/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ddd_course/presentation/notes/note_form/note_form_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    // Initial path
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: SignInRoute.page),
    AutoRoute(page: NotesOverviewRoute.page),
    AutoRoute(page: NoteFormRoute.page, fullscreenDialog: true),
  ];
}
