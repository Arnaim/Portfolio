import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protfolio/core/constants.dart';

class AppBarLink extends StatelessWidget {
  final String label;
  final String route;

  const AppBarLink({super.key, required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.go(route),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ).copyWith(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppConstants.primaryColor;
          }
          return AppConstants.textPrimary;
        }),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        textStyle: WidgetStateProperty.all(
          const TextStyle(
            fontSize: 16,
            decoration: TextDecoration.none,
          ),
        ),
      ),
      child: Text(label),
    );
  }
}
