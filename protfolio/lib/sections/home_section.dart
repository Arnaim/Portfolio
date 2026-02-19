import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:protfolio/widgets/ProjectCard.dart';
import 'package:protfolio/widgets/skill_section.dart';
import '../core/constants.dart'; 


class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;

    return SingleChildScrollView(
      child: Column(
        children: [
         
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.85, 
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://images.pexels.com/photos/1144177/pexels-photo-1144177.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  fit: BoxFit.cover,
                ),

                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.25),
                        Colors.black.withOpacity(0.65),
                      ],
                    ),
                  ),
                ),

    
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isDesktop ? 80 : 32,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Hi, I\'m Naimur Rahman Arnab',
                          style: TextStyle(
                            fontSize: isDesktop ? 64 : 44,
                            fontWeight: FontWeight.bold,
                            color: AppConstants.textPrimary,
                            shadows: const [
                              Shadow(blurRadius: 10, color: Colors.black54, offset: Offset(2, 2)),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isDesktop ? 24 : 16),
                        Text(
                          'Junior Flutter Developer • Crafting clean, performant mobile & web apps',
                          style: TextStyle(
                            fontSize: isDesktop ? 28 : 20,
                            color: AppConstants.textPrimary.withOpacity(0.92),
                            shadows: const [
                              Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(1, 1)),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: isDesktop ? 48 : 32),
                        ElevatedButton(
                          onPressed: () => context.go('/projects'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 18),
                            backgroundColor: AppConstants.primaryColor,
                            foregroundColor: AppConstants.textPrimary,
                            elevation: 4,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text(
                            'See My Projects',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 40 : 24,
              vertical: 32,
            ),
            decoration: BoxDecoration(
              color: AppConstants.secondaryColor, 
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
                Text(
                  'What I Do',
                  style: TextStyle(
                    fontSize: isDesktop ? 42 : 32,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'I build cross-platform mobile applications and responsive web experiences using Flutter. '
                  'Focused on clean architecture, performance, beautiful UI/UX, and delivering real value.',
                  style: TextStyle(
                    fontSize: isDesktop ? 20 : 17,
                    color: AppConstants.textPrimary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),

               const SkillsSection(),
                Text(
                  'Recent Projects',
                  style: TextStyle(
                    fontSize: isDesktop ? 36 : 28,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossCount = isDesktop ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
                    return GridView.count(
                      crossAxisCount: crossCount,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 24,
                      crossAxisSpacing: 24,
                      childAspectRatio: 1.4,
                      children: List.generate(3, (index) {
                        return buildProjectCard(index, title: '', description: '', imageUrl: '', githubUrl: '');
                      }),
                    );
                  },
                ),

                const SizedBox(height: 64),

                // Optional: call-to-action or more sections
                Center(
                  child: OutlinedButton(
                    onPressed: () => context.go('/projects'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                      side: BorderSide(color: AppConstants.primaryColor, width: 2),
                      backgroundColor: AppConstants.primaryColor,
                      foregroundColor: AppConstants.textPrimary,
                    ),
                    child: Text(
                      'View All Projects',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 80),
              ],
            ),
          );
  }


}