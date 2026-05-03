import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:protfolio/core/constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 120 : 24,
        vertical: 80,
      ),
      color: AppConstants.secondaryColor.withValues(alpha: 0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main heading
          Text(
            'Skills & Expertise',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 48),

          // Domain Expertise
          _buildCategory(context, 'Domain Expertise', [
            _SkillItem(icon: FontAwesomeIcons.mobileScreen, label: 'Cross-Platform Mobile App Development'),
            _SkillItem(icon: FontAwesomeIcons.link, label: 'API Integration'),
            _SkillItem(icon: FontAwesomeIcons.fire, label: 'Firebase'),
            _SkillItem(icon: FontAwesomeIcons.brain, label: 'Basic AI Model Training'),
            _SkillItem(icon: FontAwesomeIcons.chartLine, label: 'Digital Marketing & SEO'),
          ]),

          const SizedBox(height: 40),

          // Languages
          _buildCategory(context, 'Languages', [
            _SkillItem(icon: FontAwesomeIcons.code, label: 'Dart'),
            _SkillItem(icon: FontAwesomeIcons.python, label: 'Python'),
            _SkillItem(icon: FontAwesomeIcons.java, label: 'Java'),
            _SkillItem(icon: FontAwesomeIcons.code, label: 'C++'),
            _SkillItem(icon: FontAwesomeIcons.html5, label: 'HTML'),
            _SkillItem(icon: FontAwesomeIcons.css3Alt, label: 'CSS'),
          ]),

          const SizedBox(height: 40),

          // Frameworks and Tools
          _buildCategory(context, 'Frameworks & Tools', [
            _SkillItem(icon: FontAwesomeIcons.flutter, label: 'Flutter'),
            _SkillItem(icon: FontAwesomeIcons.fire, label: 'Firebase'),
            _SkillItem(icon: FontAwesomeIcons.google, label: 'Google Workspace Administration'),
            _SkillItem(icon: FontAwesomeIcons.link, label: 'REST APIs'),
          ]),
        ],
      ),
    );
  }

  Widget _buildCategory(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppConstants.accentColor,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: items,
        ),
      ],
    );
  }
}

class _SkillItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SkillItem({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppConstants.tertiaryColor.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: 16,
            color: AppConstants.primaryColor,
          ),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppConstants.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}