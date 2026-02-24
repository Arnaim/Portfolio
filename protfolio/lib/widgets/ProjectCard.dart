import 'package:flutter/material.dart';
import 'package:protfolio/core/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

Widget buildProjectCard(int index, {
  required String title,
  required String description,
  required String imageUrl,
  required String githubUrl,
  Timestamp? createdAt, // ← new: pass from Firestore
}) {
  // Format date if exists
  if (createdAt != null) {
    createdAt.toDate();
  }

  return Card(
    color: AppConstants.tertiaryColor,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image (top part)
        Expanded(
          flex: 5, // 60% height for image
          child: imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppConstants.surfaceColor,
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 48, color: Colors.grey),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                )
              : Container(
                  color: AppConstants.surfaceColor,
                  child: const Center(
                    child: Icon(Icons.image, size: 64, color: Colors.grey),
                  ),
                ),
        ),

        // Details
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              Text(
                description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),

              // Creation date
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 12),
                //   child: Row(
                //     children: [
                //       Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                //       const SizedBox(width: 6),
                //       Text(
                //         'Created: $formattedDate',
                //         style: TextStyle(
                //           fontSize: 13,
                //           color: Colors.grey[600],
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

              // GitHub button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: const Text('View on GitHub'),
                    onPressed: () async {
                      final Uri uri = Uri.parse(githubUrl);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      } else {
                        print('Could not launch $githubUrl');
                      }
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppConstants.primaryColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    ),
  );
}