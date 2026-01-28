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
      // Soft gradient background for a professional look
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primaryContainer.withOpacity(0.4),
              theme.colorScheme.surface,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Card(
                elevation: 8,
                shadowColor: Colors.black12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
                color: theme
                    .colorScheme
                    .surface, // Adjust to a light blue if desired
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      logo,
                      const SizedBox(height: 16),
                      Text(
                        title,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF2C4B99), // CareLink Blue
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "ADMIN PANEL",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: const Color(0xFFE24065), // CareLink Pink/Red
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                      ),
                      const SizedBox(height: 40),
                      form,
                      if (footer != null) ...[
                        const SizedBox(height: 24),
                        footer!,
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
