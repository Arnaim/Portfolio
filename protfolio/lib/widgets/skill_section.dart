import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:protfolio/core/constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 48,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main heading
          Text(
            'Skills & Expertise',
            style: TextStyle(
              fontSize: isDesktop ? 40 : 32,
              fontWeight: FontWeight.bold,
              color: AppConstants.surfaceColor,
            ),
          ),
          const SizedBox(height: 32),

          // Domain Expertise
          _buildCategoryTitle('Domain Expertise'),
          const SizedBox(height: 16),
          _buildSkillRow([
            _SkillItem(icon: FontAwesomeIcons.mobileScreen, label: 'Cross-Platform Mobile App Development'),
            _SkillItem(icon: FontAwesomeIcons.link, label: 'API Integration'),
            _SkillItem(icon: FontAwesomeIcons.fire, label: 'Firebase'),
            _SkillItem(icon: FontAwesomeIcons.brain, label: 'Basic AI Model Training'),
            _SkillItem(icon: FontAwesomeIcons.chartLine, label: 'Digital Marketing & SEO'),
          ]),

          const SizedBox(height: 16),

          // Languages
          _buildCategoryTitle('Languages'),
          const SizedBox(height: 16),
          _buildSkillRow([
            _SkillItem(icon: FontAwesomeIcons.code, label: 'Dart'),
            _SkillItem(icon: FontAwesomeIcons.python, label: 'Python'),
            _SkillItem(icon: FontAwesomeIcons.java, label: 'Java'),
            _SkillItem(icon: FontAwesomeIcons.code, label: 'C++'),
            _SkillItem(icon: FontAwesomeIcons.html5, label: 'HTML'),
            _SkillItem(icon: FontAwesomeIcons.css3Alt, label: 'CSS'),
          ]),

          const SizedBox(height: 16),

          // Frameworks and Tools
          _buildCategoryTitle('Frameworks & Tools'),
          const SizedBox(height: 16),
          _buildSkillRow([
            _SkillItem(icon: FontAwesomeIcons.flutter, label: 'Flutter'),
            _SkillItem(icon: FontAwesomeIcons.fire, label: 'Firebase'),
            _SkillItem(icon: FontAwesomeIcons.google, label: 'Google Workspace Administration'),
            _SkillItem(icon: FontAwesomeIcons.link, label: 'REST APIs'),
          ]),

          const SizedBox(height: 16),

          // Testing & Deployment
          _buildCategoryTitle('Testing & Deployment'),
          const SizedBox(height: 16),
          _buildSkillRow([
            _SkillItem(icon: FontAwesomeIcons.vial, label: 'Unit Testing (basic)'),
            _SkillItem(icon: FontAwesomeIcons.flaskVial, label: 'API Testing (Postman)'),
          ]),

          const SizedBox(height: 16),

          // Others
          _buildCategoryTitle('Others'),
          const SizedBox(height: 16),
          _buildSkillRow([
            _SkillItem(icon: FontAwesomeIcons.searchengin, label: 'Search Engine Optimization'),
            _SkillItem(icon: FontAwesomeIcons.magnifyingGlassChart, label: 'Strategic Keyword Research & Analysis'),
            _SkillItem(icon: FontAwesomeIcons.bullhorn, label: 'Digital Marketing Strategy'),
            _SkillItem(icon: FontAwesomeIcons.language, label: 'Bengali (Native)'),
            _SkillItem(icon: FontAwesomeIcons.language, label: 'English (Professional Proficiency)'),
            _SkillItem(icon: FontAwesomeIcons.gears, label: 'Agile methodology'),
          ]),
        ],
      ),
    );
  }

  Widget _buildCategoryTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w600,
        color: AppConstants.textSecondary,
      ),
    );
  }

  Widget _buildSkillRow(List<Widget> children) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: children,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppConstants.secondaryColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FaIcon(
            icon,
            size: 18,
            color: AppConstants.textPrimary,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppConstants.textPrimary
            ),
          ),
        ],
      ),
    );
  }
}