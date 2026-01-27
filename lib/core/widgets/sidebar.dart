import 'package:flutter/material.dart';
import 'package:admin_app/core/theme/colors.dart';
import 'package:admin_app/core/theme/text_styles.dart';
import 'package:admin_app/core/routing/routes.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  static final List<_SidebarItemData> _items = [
    _SidebarItemData(
      icon: Icons.dashboard,
      label: 'Dashboard',
      route: Routes.dashboard,
    ),
    _SidebarItemData(
      icon: Icons.local_hospital,
      label: 'Doctors',
      route: Routes.doctors,
    ),
    _SidebarItemData(
      icon: Icons.people,
      label: 'Patients',
      route: Routes.patients,
    ),
    _SidebarItemData(
      icon: Icons.person_outline,
      label: 'Caretakers',
      route: Routes.caretakers,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 240,
      color: theme.colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'CareLink Admin',
              style: AppTextStyles.headingMedium.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Divider(color: theme.dividerColor),
          ..._items.map((item) => _SidebarItem(item: item)),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final _SidebarItemData item;

  const _SidebarItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        item.icon,
        size: 20,
        color: theme.colorScheme.onSurface.withOpacity(0.7),
      ),
      title: Text(
        item.label,
        style: AppTextStyles.label.copyWith(color: theme.colorScheme.onSurface),
      ),
      dense: true,
      horizontalTitleGap: 12,
      onTap: () {
        Navigator.pushReplacementNamed(context, item.route);
      },
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
