import 'package:flutter/material.dart';
import 'package:admin_app/core/widgets/stat_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Hospital Overview",
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),

        // Metrics Grid
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4, // 4 items in a row for Web
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 2.2, // Adjusts card height
          children: const [
            StatCard(
              title: "Total Doctors",
              value: "48",
              icon: Icons.person_add_alt_1_outlined,
              color: Color(0xFF2C4B99),
            ),
            StatCard(
              title: "Total Patients",
              value: "1,240",
              icon: Icons.wheelchair_pickup_outlined,
              color: Color(0xFFE24065),
            ),
            StatCard(
              title: "Unassigned",
              value: "12",
              icon: Icons.assignment_late_outlined,
              color: Colors.orange,
            ),
            StatCard(
              title: "Medicine Stock",
              value: "850",
              icon: Icons.medical_services_outlined,
              color: Colors.teal,
            ),
          ],
        ),

        const SizedBox(height: 40),

        // Bottom section (e.g., Recent Activity or Notifications)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: _buildSectionContainer("Recent Patient Admissions"),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: _buildSectionContainer("Doctor Availability"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionContainer(String title) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }
}
