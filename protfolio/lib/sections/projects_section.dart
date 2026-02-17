import 'package:flutter/material.dart';
import 'package:protfolio/widgets/ProjectCard.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});


@override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'My Projects',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'A selection of apps I\'ve built with Flutter',
                style: TextStyle(fontSize: 18, height: 1.5),
              ),
              const SizedBox(height: 64),
              
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = 1;
            if (constraints.maxWidth > 900) {
              crossAxisCount = 3;
            } else if (constraints.maxWidth > 600) {
              crossAxisCount = 2;
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
              itemCount: 6,
              itemBuilder: (context, index) {
                return buildProjectCard(index);
              },
            );
          },
        ),
            ],
          ),
        ),
    );
  }
}
