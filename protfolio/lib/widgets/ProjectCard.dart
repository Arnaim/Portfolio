import 'package:flutter/material.dart';
import 'package:protfolio/core/constants.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildProjectCard(int index, {
  required String title,
  required String description,
  required String imageUrl,
  required String githubUrl,
}) {
  return Container(
    decoration: BoxDecoration(
      color: AppConstants.surfaceColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        Expanded(
          flex: 4,
          child: imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppConstants.tertiaryColor,
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 48, color: AppConstants.textSecondary),
                      ),
                    );
                  },
                )
              : Container(
                  color: AppConstants.tertiaryColor,
                  child: const Center(
                    child: Icon(Icons.image, size: 48, color: AppConstants.textSecondary),
                  ),
                ),
        ),

        // Details
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppConstants.textSecondary,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    icon: const Icon(Icons.arrow_forward, size: 18),
                    label: const Text('View Project'),
                    onPressed: () async {
                      final Uri uri = Uri.parse(githubUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppConstants.primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}