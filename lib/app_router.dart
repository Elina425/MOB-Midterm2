import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/homework_list_page.dart';
import 'pages/add_homework_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, __) => const HomeworkListPage()),
      GoRoute(path: '/add', builder: (_, __) => const AddHomeworkPage()),
    ],
  );
}
