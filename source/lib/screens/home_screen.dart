import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  FadeInDown(
                    child: const Text(
                      'Fun Party',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [Shadow(color: Colors.black26, offset: Offset(0, 4), blurRadius: 8)],
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _GameLink(
                      title: 'Party Cards',
                      icon: '🃏',
                      onTap: () => Navigator.pushNamed(context, '/player_setup', arguments: '/poker'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: _GameLink(
                      title: 'Bottle Spinner',
                      icon: '🔄',
                      onTap: () => Navigator.pushNamed(context, '/player_setup', arguments: '/spinner'),
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextButton(
                    onPressed: () => _showPrivacyPolicy(context),
                    child: const Text(
                      'Privacy Policy',
                      style: TextStyle(color: Colors.white54, fontSize: 12, decoration: TextDecoration.underline),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showPrivacyPolicy(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A1A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Privacy Policy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Last Updated: May 8, 2026',
                  style: TextStyle(color: Colors.white54, fontSize: 12, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 16),
                _policySection(
                  '1. Information We Collect',
                  'Party Games is designed to be used without requiring a user account. We do not collect personally identifiable information (PII) such as your name, email address, or phone number directly.\n\nHowever, we may collect non-personal information, such as:\n• Device type and operating system.\n• App usage statistics and interactions.\n• Approximate location (city/country level) for ad targeting.',
                ),
                _policySection(
                  '2. Third-Party Services & Ads',
                  'We use third-party advertising partners to serve advertisements. These partners may use cookies or similar technologies to collect information about your activities across different apps and websites to provide you with relevant ads.',
                ),
                _policySection(
                  '3. Age Recommendation (13+)',
                  'This application is intended for individuals aged 13 years or older. We do not knowingly collect information from children under 13. By using this application, you confirm that you are at least 13 years old.',
                ),
                _policySection(
                  '4. Data Security',
                  'We implement industry-standard security measures to protect the non-personal data collected by the app.',
                ),
                _policySection(
                  '5. Contact Us',
                  'If you have any questions about this Privacy Policy, you can contact us at:\nEmail: automation.sushil@gmail.com',
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE', style: TextStyle(color: Color(0xFFFF6B6B), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _policySection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}


class _GameLink extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const _GameLink({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222222),
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFF222222)),
          ],
        ),
      ),
    );
  }
}
