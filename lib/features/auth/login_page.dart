import 'package:admin_app/core/routing/routes.dart';
import 'package:admin_app/features/auth/auth_layout.dart';
import 'package:admin_app/features/auth/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthLayout(
      // Pointing to your existing asset path
      logo: Image.asset('lib/assets/logos/carelink_logo.png', height: 100),
      title: 'CareLink',
      form: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Sign in to your account",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),

            // Email Field
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email Address', // Changed from labelText to hintText
                prefixIcon: const Icon(Icons.email_outlined, size: 22),
                filled: true,
                fillColor: theme.colorScheme.primary.withOpacity(0.05),
                // This padding ensures the cursor and text are perfectly centered
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
            ),

            const SizedBox(height: 20),

            // Password Field
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password', // Changed from labelText to hintText
                prefixIcon: const Icon(Icons.lock_person_outlined, size: 22),
                filled: true,
                fillColor: theme.colorScheme.primary.withOpacity(0.05),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    width: 1,
                  ),
                ),
              ),
              validator: (v) =>
                  (v == null || v.length < 6) ? 'Min 6 chars' : null,
            ),

            const SizedBox(height: 32),

            Consumer<LoginController>(
              builder: (_, controller, __) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (controller.error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Text(
                          controller.error!,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: theme.colorScheme.error),
                        ),
                      ),

                    ElevatedButton(
                      onPressed: controller.isLoading
                          ? null
                          : () async {
                              if (!_formKey.currentState!.validate()) return;
                              final success = await controller.login(
                                email: _emailController.text.trim(),
                                password: _passwordController.text,
                              );
                              if (success && context.mounted) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  Routes.dashboard,
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: const Color(0xFF2C4B99),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text(
                              'LOGIN',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Issues logging in?"),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Contact Tech Support',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
