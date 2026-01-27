import 'package:flutter/material.dart';
import 'package:admin_app/core/theme/text_styles.dart';
import 'package:admin_app/core/theme/colors.dart';

class TopBar extends StatelessWidget {
  final String title;

  const TopBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(color: theme.dividerColor.withOpacity(0.4)),
        ),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: AppTextStyles.headingMedium.copyWith(
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Spacer(),
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            child: Icon(Icons.person, size: 18, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
