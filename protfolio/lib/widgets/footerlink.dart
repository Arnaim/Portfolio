import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart'; 

class FooterLink extends StatelessWidget {
  final String label;
  final String url;

  const FooterLink({
    super.key,
    required this.label,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ).copyWith(
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppConstants.primaryColor; 
          }
          return AppConstants.textPrimary; 
        }),
        overlayColor: WidgetStateProperty.all(
          Colors.transparent, 
        ),
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
