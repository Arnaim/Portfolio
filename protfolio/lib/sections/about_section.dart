import 'package:flutter/material.dart';
import '../layouts/main_layout.dart';
import '../core/constants.dart'; 

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppConstants.primaryColor,
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: 80,
              backgroundImage: const AssetImage('assets/images/profile.jpeg'),
              backgroundColor: Colors.grey[300], 
            ),
          ),

          const SizedBox(height: 16),

          const Text(
            'Hello, I am Naimur Rahman Arnab',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const Text(
            'Flutter Developer | Computer Science Graduate',
            style: TextStyle(fontSize: 24, height: 1.5),
          ),

          const SizedBox(height: 32),

          // Boxed About Me Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppConstants.secondaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'About Me',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textPrimary,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'I am a Computer Science graduate with a strong focus on Flutter-based application development. '
                  'I have experience building responsive, user-centric applications with attention to clean architecture and maintainable code. '
                  'My work involves integrating APIs, managing application state, and designing intuitive user interfaces. '
                  'I enjoy solving practical problems through technology and continuously improving my skills through hands-on projects. '
                  'I am particularly interested in cross-platform development and modern application workflows.',
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: AppConstants.textPrimary,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Certificates Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppConstants.secondaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Certificates & Honors',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),

                // List of certificates
                _buildCertificateRow(
                  'Supervised Machine Learning: Regression & Classification',
                  'Coursera',
                ),
                _buildCertificateRow(
                  'Advanced Learning Algorithms',
                  'Coursera',
                ),
                _buildCertificateRow(
                  'App Development with Flutter',
                  'Ostad',
                ),
                _buildCertificateRow(
                  'ICPC Asia Dhaka Regional Contest — Contestant (2021)',
                  '',
                ),
                _buildCertificateRow(
                  'ICPC Asia Dhaka Regional Contest — Contestant (2023)',
                  '',
                ),
                _buildCertificateRow(
                  'NASA Space Apps Challenge 2024 — Participant',
                  '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget to display each certificate as a row
  Widget _buildCertificateRow(String title, String issuer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Icon(Icons.workspace_premium, color: Colors.amber, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              issuer.isNotEmpty ? '$title — $issuer' : title,
              style: const TextStyle(
                fontSize: 18,
                color: AppConstants.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
