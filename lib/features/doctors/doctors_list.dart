import 'package:flutter/material.dart';
import 'package:admin_app/core/theme/app_theme.dart';
import 'package:admin_app/core/widgets/admin_layout.dart';
import 'package:admin_app/models/doctor.dart';
import 'package:admin_app/services/doctor_service.dart';
import 'package:admin_app/services/supabase_service.dart';
import 'doctor_detail.dart';
import 'create_doctor.dart';
import 'edit_doctor.dart';

class DoctorsList extends StatefulWidget {
  const DoctorsList({super.key});

  @override
  State<DoctorsList> createState() => _DoctorsListState();
}

class _DoctorsListState extends State<DoctorsList> {
  late DoctorService _doctorService;
  late Future<List<Doctor>> _doctorsFuture;
  final TextEditingController _searchController = TextEditingController();
  String _selectedDepartmentFilter = 'All';

  @override
  void initState() {
    super.initState();
    _doctorService = DoctorService(SupabaseService());
    _refreshDoctors();
  }

  void _refreshDoctors() {
    setState(() {
      _doctorsFuture = _doctorService.getAllDoctors();
    });
  }

  void _searchDoctors(String query) {
    if (query.isEmpty) {
      _refreshDoctors();
    } else {
      setState(() {
        _doctorsFuture = _doctorService.searchDoctors(query);
      });
    }
  }

  void _filterByDepartment(String department) {
    setState(() {
      _selectedDepartmentFilter = department;
      if (department == 'All') {
        _refreshDoctors();
      } else {
        _doctorsFuture = _doctorService.getDoctorsByDepartment(department);
      }
    });
  }

  Future<void> _showCreateDoctorDialog() async {
    showDialog(
      context: context,
      builder: (_) => CreateDoctorDialog(
        onSave: (_) {
          _refreshDoctors();
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _showEditDoctorDialog(Doctor doctor) async {
    showDialog(
      context: context,
      builder: (_) => EditDoctorDialog(
        doctor: doctor,
        onSave: (_) {
          _refreshDoctors();
          Navigator.pop(context);
        },
      ),
    );
  }

  Future<void> _deleteDoctor(Doctor doctor) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Doctor'),
        content: Text('Are you sure you want to delete ${doctor.designation}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await _doctorService.deleteDoctor(doctor.doctorId);
        _refreshDoctors();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${doctor.designation} deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Doctors Management',
              style: AppTextStyles.headingLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _showCreateDoctorDialog,
              icon: const Icon(Icons.add),
              label: const Text('Add Doctor'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Search and Filter Row
        Row(
          children: [
            // Search Bar
            Expanded(
              flex: 2,
              child: TextField(
                controller: _searchController,
                onChanged: _searchDoctors,
                decoration: InputDecoration(
                  hintText: 'Search by name or department...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.background),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.background),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Department Filter
            Expanded(child: _buildDepartmentDropdown()),
            const SizedBox(width: 16),

            // Refresh Button
            IconButton(
              onPressed: _refreshDoctors,
              icon: const Icon(Icons.refresh),
              tooltip: 'Refresh',
              style: IconButton.styleFrom(
                backgroundColor: AppColors.background,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Doctors Table
        Flexible(
          child: FutureBuilder<List<Doctor>>(
            future: _doctorsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return _buildLoadingState();
              }

              if (snapshot.hasError) {
                return _buildErrorState(snapshot.error.toString());
              }

              final doctors = snapshot.data ?? [];

              if (doctors.isEmpty) {
                return _buildEmptyState();
              }

              return _buildDoctorsTable(doctors);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDepartmentDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedDepartmentFilter,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.background),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.background),
        ),
      ),
      onChanged: (value) {
        if (value != null) _filterByDepartment(value);
      },
      items: [
        const DropdownMenuItem(value: 'All', child: Text('All Departments')),
        ...Department.values.map(
          (dept) =>
              DropdownMenuItem(value: dept.label, child: Text(dept.label)),
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text('Loading doctors...', style: AppTextStyles.bodyMuted),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Text('Error loading doctors', style: AppTextStyles.headingMedium),
          const SizedBox(height: 8),
          Text(
            error,
            style: AppTextStyles.bodyMuted,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _refreshDoctors,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_off_outlined,
            size: 48,
            color: AppColors.navInactiveForeground,
          ),
          const SizedBox(height: 16),
          Text('No doctors found', style: AppTextStyles.headingMedium),
          const SizedBox(height: 8),
          Text('Start by adding a new doctor', style: AppTextStyles.bodyMuted),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _showCreateDoctorDialog,
            icon: const Icon(Icons.add),
            label: const Text('Add First Doctor'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorsTable(List<Doctor> doctors) {
    return SingleChildScrollView(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.background),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('Doctor ID')),
              DataColumn(label: Text('Designation')),
              DataColumn(label: Text('Department')),
              DataColumn(label: Text('Contact')),
              DataColumn(label: Text('Actions')),
            ],
            rows: doctors.map((doctor) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      doctor.doctorId,
                      style: AppTextStyles.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataCell(
                    Text(
                      doctor.designation,
                      style: AppTextStyles.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        doctor.department,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      doctor.contactNumber ?? 'N/A',
                      style: AppTextStyles.body,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  DataCell(
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Tooltip(
                          message: 'View',
                          child: IconButton(
                            icon: const Icon(Icons.visibility, size: 18),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AdminLayout(
                                    title: 'Doctor Details',
                                    child: DoctorDetail(
                                      doctorId: doctor.doctorId,
                                    ),
                                  ),
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                          ),
                        ),
                        Tooltip(
                          message: 'Edit',
                          child: IconButton(
                            icon: const Icon(Icons.edit, size: 18),
                            onPressed: () => _showEditDoctorDialog(doctor),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                          ),
                        ),
                        Tooltip(
                          message: 'Delete',
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 18,
                              color: Colors.red,
                            ),
                            onPressed: () => _deleteDoctor(doctor),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(
                              minWidth: 36,
                              minHeight: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
            headingRowColor: MaterialStatePropertyAll(AppColors.background),
            dataRowHeight: 56,
            columnSpacing: 24,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
