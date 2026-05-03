import 'package:flutter/material.dart';
import 'package:protfolio/widgets/DirectContact.dart';
import '../core/constants.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart'; 

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _messageSent = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

// add this import

void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'message': _messageController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      setState(() {
        _messageSent = true;
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
      });

      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) setState(() => _messageSent = false);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Message sent! I\'ll get back to you soon.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send: $e')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: 120,
          left: isDesktop ? 80 : 24,
          right: isDesktop ? 80 : 24,
          bottom: 40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Heading
            const Text(
              'Get in Touch',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Have a project idea, question, or just want to say hi?\n'
              'I\'d love to hear from you.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, height: 1.5),
            ),

            const SizedBox(height: 64),

            // Two-column layout on desktop, stacked on mobile
            isDesktop
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left: Form
                      Expanded(
                        flex: 3,
                        child: _buildForm(),
                      ),
                      const SizedBox(width: 80),
                      // Right: Contact info
                      Expanded(
                        flex: 2,
                        child: buildContactInfo(),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      _buildForm(),
                      const SizedBox(height: 64),
                      buildContactInfo(),
                    ],
                  ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Your Name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Your Email',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _messageController,
            decoration: const InputDecoration(
              labelText: 'Message',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 6,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a message';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: AppConstants.backgroundColor,
            ),
            child: const Text(
              'Send Message',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(height: 16),
          if (_messageSent)
            const Text(
              'Thank you! Your message has been sent. I\'ll get back to you soon.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppConstants.tertiaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }




}