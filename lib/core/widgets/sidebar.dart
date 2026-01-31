import 'package:flutter/material.dart';
import 'package:admin_app/core/theme/colors.dart';
import 'package:admin_app/core/theme/text_styles.dart';
import 'package:admin_app/core/routing/routes.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  static final List<_SidebarItemData> _items = [
    _SidebarItemData(
      icon: Icons.dashboard_rounded,
      label: 'Dashboard',
      route: Routes.dashboard,
    ),
    _SidebarItemData(
      icon: Icons.local_hospital_rounded,
      label: 'Doctors',
      route: Routes.doctors,
    ),
    _SidebarItemData(
      icon: Icons.people_alt_rounded,
      label: 'Patients',
      route: Routes.patients,
    ),
    _SidebarItemData(
      icon: Icons.person_search_rounded,
      label: 'Caretakers',
      route: Routes.caretakers,
    ),
    _SidebarItemData(
      icon: Icons.medication_liquid_rounded,
      label: 'Medicines',
      route: '/medicines',
    ), // Example for your medicines
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Get the current route to highlight the active item
    final currentRoute = ModalRoute.of(context)?.settings.name;

    return Container(
      width: 260, // Slightly wider for better breathing room
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(right: BorderSide(color: theme.dividerColor, width: 1)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 32),
          // Branding Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Image.asset('lib/assets/logos/carelink_logo.png', height: 32),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CARELINK',
                      style: AppTextStyles.label.copyWith(
                        color: const Color(0xFF2C4B99),
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    Text(
                      'ADMIN PANEL',
                      style: TextStyle(
                        color: const Color(0xFFE24065),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Navigation Items
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final item = _items[index];
                final isSelected = currentRoute == item.route;
                return _SidebarItem(item: item, isSelected: isSelected);
              },
            ),
          ),

          // Bottom Actions (Logout)
          const Divider(),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            title: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
            onTap: () {
              // Add your logout logic here
              Navigator.pushReplacementNamed(context, Routes.login);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final _SidebarItemData item;
  final bool isSelected;

  const _SidebarItem({required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = const Color(0xFF2C4B99);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? activeColor.withOpacity(0.08) : Colors.transparent,
      ),
      child: ListTile(
        onTap: isSelected
            ? null
            : () => Navigator.pushReplacementNamed(context, item.route),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Icon(
          item.icon,
          size: 22,
          color: isSelected
              ? activeColor
              : theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        title: Text(
          item.label,
          style: TextStyle(
            color: isSelected
                ? activeColor
                : theme.colorScheme.onSurface.withOpacity(0.8),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 14,
          ),
        ),
        // Active indicator bar
        trailing: isSelected
            ? Container(
                width: 4,
                height: 16,
                decoration: BoxDecoration(
                  color: activeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            : null,
      ),
    );
  }
}

class _SidebarItemData {
  final IconData icon;
  final String label;
  final String route;

  const _SidebarItemData({
    required this.icon,
    required this.label,
    required this.route,
  });
}
