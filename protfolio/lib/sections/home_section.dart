import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:protfolio/core/providers.dart';
import 'package:protfolio/widgets/ProjectCard.dart';
import 'package:protfolio/widgets/skill_section.dart';
import '../core/constants.dart'; 


class HomeSection extends ConsumerWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 900;
    final recentProjectsAsync = ref.watch(recentProjectsProvider);

    return Column(
      children: [
        // Hero Section
        SizedBox(
          height: MediaQuery.of(context).size.height, 
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(
                'https://images.pexels.com/photos/1144177/pexels-photo-1144177.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                fit: BoxFit.cover,
              ).animate().fadeIn(duration: 1200.ms),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppConstants.backgroundColor.withValues(alpha: 0.3),
                      AppConstants.backgroundColor,
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
                        'Hi, I\'m ${AppConstants.name}',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontSize: isDesktop ? 72 : 48,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: 600.ms, delay: 200.ms).slideY(begin: 0.2, end: 0),
                      
                      const SizedBox(height: 16),
                      
                      Text(
                        AppConstants.tagline,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: isDesktop ? 24 : 18,
                          color: AppConstants.textSecondary,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(duration: 600.ms, delay: 400.ms).slideY(begin: 0.2, end: 0),
                      
                      const SizedBox(height: 48),
                      
                      ElevatedButton(
                        onPressed: () => context.go('/projects'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 22),
                          backgroundColor: AppConstants.primaryColor,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          'Explore My Work',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ).animate().fadeIn(duration: 600.ms, delay: 600.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // What I Do Section
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 120 : 24,
            vertical: 100,
          ),
          child: Column(
            crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              Text(
                'Bridging Code & Impact',
                style: Theme.of(context).textTheme.headlineMedium,
              ).animate(onPlay: (controller) => controller.repeat()).shimmer(duration: 2000.ms, color: AppConstants.accentColor.withValues(alpha: 0.3)),
              
              const SizedBox(height: 24),
              
              Text(
                'I am a Software Engineer passionate about crafting seamless digital experiences. While I specialize in Flutter for high-performance cross-platform apps, I am equally at home working with backend systems, RESTful architectures, and data-driven solutions. I don\'t just write code; I build tools that solve real-world problems.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: isDesktop ? TextAlign.left : TextAlign.center,
              ),
            ],
          ),
        ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.1, end: 0),

        const SkillsSection().animate().fadeIn(duration: 800.ms, delay: 200.ms),

        // Recent Projects Section
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 120 : 24,
            vertical: 80,
          ),
          child: Column(
            children: [
              Text(
                'Recent Projects',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 48),

              recentProjectsAsync.when(
                data: (projects) {
                  if (projects.isEmpty) {
                    return const Center(child: Text('No recent projects yet'));
                  }

                  return LayoutBuilder(
                    builder: (context, constraints) {
                      int crossCount = isDesktop ? 3 : (constraints.maxWidth > 600 ? 2 : 1);

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossCount,
                          mainAxisSpacing: 32,
                          crossAxisSpacing: 32,
                          childAspectRatio: 0.85, // Adjusted for more vertical space
                        ),
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          final data = projects[index];

                          return buildProjectCard(
                            index,
                            title: data['title'] as String? ?? 'Untitled Project',
                            description: data['description'] as String? ?? 'No description',
                            imageUrl: data['imageUrl'] as String? ?? '',
                            githubUrl: data['githubUrl'] as String? ?? '',
                          ).animate().fadeIn(duration: 600.ms, delay: (100 * index).ms).slideY(begin: 0.1, end: 0);
                        },
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => const Center(child: Text('Error loading recent projects')),
              ),

              const SizedBox(height: 64),

              OutlinedButton(
                onPressed: () => context.go('/projects'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  side: const BorderSide(color: AppConstants.primaryColor, width: 2),
                  foregroundColor: AppConstants.textPrimary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'View All Projects',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 100),
      ],
    );
  }
}