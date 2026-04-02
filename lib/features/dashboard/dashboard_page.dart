import 'package:flutter/material.dart';
import 'package:admin_app/core/theme/app_theme.dart';
import 'package:admin_app/core/routing/routes.dart';
import 'package:admin_app/core/widgets/stat_card.dart';
import 'package:admin_app/services/doctor_service.dart';
import 'package:admin_app/services/patient_service.dart';
import 'package:admin_app/services/medicine_service.dart';
import 'package:admin_app/services/caretaker_service.dart';
import 'package:admin_app/services/supabase_service.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DoctorService _doctorService;
  late PatientService _patientService;
  late MedicineService _medicineService;
  late CaretakerService _caretakerService;

  int _doctorsCount = 0;
  int _patientsCount = 0;
  int _unassignedCount = 0;
  int _medicinesCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _loadDashboardData();
  }

  void _initializeServices() {
    final supabase = SupabaseService();
    _doctorService = DoctorService(supabase);
    _patientService = PatientService(supabase);
    _medicineService = MedicineService(supabase);
    _caretakerService = CaretakerService(supabase);
  }

  Future<void> _loadDashboardData() async {
    setState(() => _isLoading = true);
    try {
      final doctors = await _doctorService.getDoctorsCount();
      final patients = await _patientService.getPatientsCount();
      final medicines = await _medicineService.getMedicinesCount();

      // Calculate unassigned (example: patients without assigned doctor)
      final allPatients = await _patientService.getAllPatients();
      final unassigned = allPatients
          .where((p) => p.doctor_id.isEmpty || p.doctor_id == 'null')
          .length;

      if (mounted) {
        setState(() {
          _doctorsCount = doctors;
          _patientsCount = patients;
          _medicinesCount = medicines;
          _unassignedCount = unassigned;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading dashboard: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _refreshDashboard() async {
    await _loadDashboardData();
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Dashboard refreshed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with title and action buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hospital Overview",
              style: AppTextStyles.headingLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                _buildActionButton(
                  context: context,
                  icon: Icons.person_add,
                  label: "Add Patient",
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, Routes.patients),
                ),
                const SizedBox(width: 12),
                _buildActionButton(
                  context: context,
                  icon: Icons.refresh,
                  label: "Refresh",
                  onTap: _refreshDashboard,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Loading State
        if (_isLoading)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text('Loading dashboard...', style: AppTextStyles.bodyMuted),
              ],
            ),
          )
        else
          // Metrics Grid
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 4, // 4 items in a row for Web
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 2.2,
            children: [
              StatCard(
                title: "Total Doctors",
                value: _doctorsCount.toString(),
                icon: Icons.person_add_alt_1_outlined,
                color: AppColors.primary,
                trend: "+3.2%",
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.doctors),
              ),
              StatCard(
                title: "Total Patients",
                value: _patientsCount.toString(),
                icon: Icons.wheelchair_pickup_outlined,
                color: AppColors.alertRed,
                trend: "+8.5%",
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.patients),
              ),
              StatCard(
                title: "Unassigned",
                value: _unassignedCount.toString(),
                icon: Icons.assignment_late_outlined,
                color: AppColors.warning,
                trend: "-2.1%",
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.patients),
              ),
              StatCard(
                title: "Medicine Stock",
                value: _medicinesCount.toString(),
                icon: Icons.medical_services_outlined,
                color: AppColors.success,
                trend: "+1.8%",
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.medicines),
              ),
            ],
          ),

        if (!_isLoading) ...[
          const SizedBox(height: 40),

          // Bottom section (Recent Activity and Doctor Availability)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildSectionContainer(
                  "Recent Patient Admissions",
                  AppColors.surface,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: _buildSectionContainer(
                  "Doctor Availability",
                  AppColors.surface,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildSectionContainer(String title, Color backgroundColor) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.background),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.label.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Center(
              child: Text(
                'Coming Soon',
                style: AppTextStyles.bodyMuted.copyWith(fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.primary.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
