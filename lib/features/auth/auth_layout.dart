import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget logo;
  final String title;
  final Widget form;
  final Widget? footer;

  const AuthLayout({
    super.key,
    required this.logo,
    required this.title,
    required this.form,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 48),

                logo,

                const SizedBox(height: 48),

                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 32),

                form,

                if (footer != null) ...[const SizedBox(height: 24), footer!],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
