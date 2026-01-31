import 'package:flutter/material.dart';
import 'sidebar.dart';
import 'topbar.dart';

class AdminLayout extends StatelessWidget {
  final Widget child;
  final String title;

  const AdminLayout({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Fixed Navigation Sidebar
          const Sidebar(),

          // Main Content Area
          Expanded(
            child: Container(
              color: const Color(
                0xFFF8FAFC,
              ), // Subtle off-white background to make cards pop
              child: Column(
                children: [
                  TopBar(title: title),

                  // Content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 1400,
                          ), // Keeps layout balanced
                          child: child,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
