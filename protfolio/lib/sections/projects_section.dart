import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protfolio/core/providers.dart';
import 'package:protfolio/widgets/ProjectCard.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});


@override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectsAsync = ref.watch(projectsStreamProvider);
    
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 120, left: 24, right: 24, bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'My Projects',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'A selection of apps I\'ve built with Flutter and other technologies.',
                style: TextStyle(fontSize: 18, height: 1.5),
              ),
              const SizedBox(height: 64),
              
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            if (constraints.maxWidth > 900) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 600) crossAxisCount = 2;

            return projectsAsync.when(
              data: (projects) {
                if (projects.isEmpty) {
                  return const Center(child: Text('No projects added yet'));
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio: 1.4,
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
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            );
          },
        )
       ],
     ),
    ),
  );
 }
}
