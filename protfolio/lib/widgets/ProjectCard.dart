  import 'package:flutter/material.dart';
import 'package:protfolio/core/constants.dart';

Widget buildProjectCard(int index, {
  required String title,
  required String description,
  required String imageUrl, 
  required String githubUrl,
}) {
  return Card(
    color: AppConstants.tertiaryColor,
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Placeholder for image (add real Image.network later)
        Expanded(
          child: Container(
            color: AppConstants.surfaceColor,
            child: Center(
              child: Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}