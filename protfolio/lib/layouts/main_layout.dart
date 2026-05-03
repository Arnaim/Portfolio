// lib/layouts/main_layout.dart
import 'dart:ui';
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
      extendBodyBehindAppBar: true,
      backgroundColor: AppConstants.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              title: const Text(
                'Naimur Rahman Arnab',
                style: TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.bold,
                  color: AppConstants.textPrimary
                ),
              ),
              backgroundColor: AppConstants.backgroundColor.withValues(alpha: 0.7),
              elevation: 0,
              centerTitle: false,
              actions: [
                const AppBarLink(label: 'Home', route: '/'),
                const SizedBox(width: 24),
                const AppBarLink(label: 'About', route: '/about'),
                const SizedBox(width: 24),
                const AppBarLink(label: 'Projects', route: '/projects'),
                const SizedBox(width: 24),
                const AppBarLink(label: 'Contact', route: '/contact'),
                const SizedBox(width: 36),
              ],
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            child,
            
            // Footer
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : 24,
                vertical: 60,
              ),
              color: AppConstants.secondaryColor,
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
                      SizedBox(width: 40),
                      FooterLink(
                        label: 'LinkedIn',
                        url: 'https://www.linkedin.com/in/naimurrahmanarnab',
                      ),
                      SizedBox(width: 40),
                      FooterLink(
                        label: 'Email',
                        url: 'mailto:cookynaimur@gmail.com',
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),
                  Divider(color: AppConstants.tertiaryColor.withValues(alpha: 0.3)),
                  const SizedBox(height: 40),

                  Text(
                    '© ${DateTime.now().year} Naimur Rahman Arnab. Built with Flutter.',
                    style: const TextStyle(color: AppConstants.textSecondary, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'All rights reserved.',
                    style: TextStyle(color: AppConstants.textSecondary, fontSize: 12),
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