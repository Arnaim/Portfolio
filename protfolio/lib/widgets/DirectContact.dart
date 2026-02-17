import 'package:flutter/material.dart';
import 'package:protfolio/core/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildContactInfo() {
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: AppConstants.secondaryColor,            
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.grey[300]!), 
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Direct Contact',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppConstants.textPrimary),
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          icon: Icons.email,
          text: 'Mail me',
          onTap: () => launchUrl(Uri.parse('mailto:cookynaimur@gmail.com')),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          icon: Icons.link,
          text: 'My Github',
          onTap: () => launchUrl(Uri.parse('https://github.com/Arnaim')),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          icon: Icons.link,
          text: 'My LinkedIn',
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
      foregroundColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.hovered)) {
          return AppConstants.primaryColor;
        }
        return AppConstants.textPrimary;
      }),
      overlayColor: MaterialStateProperty.all(Colors.transparent),
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
