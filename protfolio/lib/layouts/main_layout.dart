// lib/layouts/main_layout.dart
import 'package:flutter/material.dart';
import 'package:protfolio/widgets/AppBar_link.dart';
import 'package:protfolio/widgets/footerlink.dart';
import '../core/constants.dart';

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Naimur Rahman Arnab',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        backgroundColor: AppConstants.surfaceColor,
        actions: const [
          AppBarLink(label: 'Home', route: '/'),
          SizedBox(width: 36),
          AppBarLink(label: 'About', route: '/about'),
          SizedBox(width: 36),
          AppBarLink(label: 'Projects', route: '/projects'),
          SizedBox(width: 36),
          AppBarLink(label: 'Contact', route: '/contact'),
          SizedBox(width: 36),
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            child,
            const SizedBox(height: 80),

            // Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : 24,
                vertical: 40,
              ),
              color: const Color.fromRGBO(33, 33, 33, 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    FooterLink(
                      label: 'GitHub',
                      url: 'https://github.com/Arnaim',
                    ),
                    SizedBox(width: 32),
                    FooterLink(
                      label: 'LinkedIn',
                      url: 'https://www.linkedin.com/in/naimurrahmanarnab',
                    ),
                    SizedBox(width: 32),
                    FooterLink(
                      label: 'Email',
                      url: 'mailto:cookynaimur@gmail.com',
                    ),
                  ],
                ),


                  const SizedBox(height: 24),

                  Text(
                    '© ${DateTime.now().year} Naimur Rahman Arnab. Built with Flutter.',
                    style: const TextStyle(color: AppConstants.textSecondary, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'All rights reserved.',
                    style: TextStyle(color: AppConstants.tertiaryColor, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}