import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants.dart'; 

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 120, left: 24, right: 24, bottom: 24),
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
                  color: Colors.black.withValues(alpha: 0.1),
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
                  'A Computer Science graduate with a strong focus on Flutter-based application development, I have experience building responsive, user-centric applications with attention to clean architecture and maintainable code. '
                  'My work includes integrating REST APIs, managing application state, and designing intuitive user interfaces. '
                  'I enjoy solving practical problems through technology and continuously improving my skills through hands-on projects. '
                  'Particularly interested in cross-platform development and modern application workflows, I strive to build efficient and scalable solutions. '
                  'Currently conducting thesis research in the field of machine learning, further expanding my understanding of intelligent systems and data-driven solutions.'
                  ' '
                  'You can download my CV to see more details about my projects, skills, and experience from below.',
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


          // Download CV button
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.download, size: 20),
              label: const Text(
                'Download My CV',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              onPressed: () async {
                final Uri url = Uri.base.resolve('assets/pdf/Naimur_Rahman_Arnab_CV.pdf');

                await launchUrl(
                  url,
                  mode: LaunchMode.externalApplication,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                backgroundColor: AppConstants.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
              ),
            ),
          ),

const SizedBox(height: 48), // space before next section
          // Certificates Section
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppConstants.secondaryColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
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
