import 'package:cloud_firestore/cloud_firestore.dart';
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
            } else if (constraints.maxWidth > 600) crossAxisCount = 2;

            return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('projects')
                  .snapshots(),
              
              builder: (context, snapshot) {
                print('Firestore stream status: ${snapshot.connectionState}');
                print('Has data: ${snapshot.hasData}');
                print('Error: ${snapshot.error}');
                print('Number of docs: ${snapshot.data?.docs.length ?? 0}');
                // Loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // Error state
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final projects = snapshot.data?.docs ?? [];

                // Empty state
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
                    final doc = projects[index];
                    final data = doc.data() as Map<String, dynamic>;

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
            );
          },
        )
       ],
     ),
    ),
  );
 }
}
