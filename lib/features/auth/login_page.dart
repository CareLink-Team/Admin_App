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
      logo: Image.asset('lib/assets/logos/carelink_logo.png', height: 80),

      title: 'Admin Login',

      form: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _passwordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: theme.colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),

            const SizedBox(height: 24),

            Consumer<LoginController>(
              builder: (_, controller, __) {
                return Column(
                  children: [
                    if (controller.error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          controller.error!,
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
                      child: controller.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Sign in'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),

      footer: TextButton(
        onPressed: () {},
        child: const Text('Forgot password?'),
      ),
    );
  }
}
