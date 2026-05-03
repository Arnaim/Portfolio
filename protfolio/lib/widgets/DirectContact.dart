import 'package:flutter/material.dart';
import 'package:protfolio/core/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildContactInfo() {
  return Container(
    padding: const EdgeInsets.all(32),
    decoration: BoxDecoration(
      color: AppConstants.surfaceColor,            
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppConstants.tertiaryColor.withValues(alpha: 0.3)), 
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Direct Contact',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppConstants.textPrimary),
        ),
        const SizedBox(height: 32),
        _buildContactItem(
          icon: Icons.email,
          text: 'cookynaimur@gmail.com',
          onTap: () async {
            final Uri emailLaunchUri = Uri(
              scheme: 'mailto',
              path: 'cookynaimur@gmail.com',
            );
            if (await canLaunchUrl(emailLaunchUri)) {
              await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
            }
          },
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          icon: Icons.link,
          text: 'GitHub Profile',
          onTap: () => launchUrl(Uri.parse('https://github.com/Arnaim')),
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          icon: Icons.link,
          text: 'LinkedIn Profile',
          onTap: () => launchUrl(Uri.parse('https://www.linkedin.com/in/naimurrahmanarnab')),
        ),
      ],
     ),
    );
  }

Widget _buildContactItem({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
}) {
  return TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      alignment: Alignment.centerLeft,
    ).copyWith(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.hovered)) {
          return AppConstants.primaryColor;
        }
        return AppConstants.textPrimary;
      }),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 20,
          color: AppConstants.textPrimary,  
        ),
        const SizedBox(width: 12),
        Text(text),
      ],
    ),
  );
}
