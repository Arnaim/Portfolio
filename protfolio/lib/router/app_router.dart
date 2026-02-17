import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import screens and layout
import '../sections/home_section.dart';
import '../sections/about_section.dart';
import '../sections/projects_section.dart';
import '../sections/contact_section.dart';
import '../layouts/main_layout.dart';         

Page<dynamic> fadeTransitionPage({
  required LocalKey key,
  required Widget child,
  Duration duration = const Duration(milliseconds: 1000),
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

Page<dynamic> slideTransitionPage({
  required LocalKey key,
  required Widget child,
  Duration duration = const Duration(milliseconds: 1000),
}) {
  return CustomTransitionPage(
    key: key,
    child: child,
    transitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // from right
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => fadeTransitionPage(
            key: state.pageKey,
            child: const HomeSection(),
          ),
        ),
        GoRoute(
          path: '/about',
          pageBuilder: (context, state) => slideTransitionPage(
            key: state.pageKey,
            child: const AboutSection(),
          ),
        ),
        GoRoute(
          path: '/projects',
          pageBuilder: (context, state) => fadeTransitionPage(
            key: state.pageKey,
            child: const ProjectsSection(),
          ),
        ),
        GoRoute(
          path: '/contact',
          pageBuilder: (context, state) => slideTransitionPage(
            key: state.pageKey,
            child: const ContactSection(),
          ),
        ),
      ],
    ),
  ],
);