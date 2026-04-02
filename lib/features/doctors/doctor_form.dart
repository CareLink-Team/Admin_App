import 'package:flutter/material.dart';
import 'package:admin_app/core/theme/app_theme.dart';
import 'package:admin_app/models/doctor.dart';

/// Reusable form widget for creating and editing doctors
class DoctorForm extends StatefulWidget {
  /// If provided, the form will be in edit mode and pre-fill fields
  final Doctor? initialDoctor;

  /// Called when the form is submitted with a valid doctor object
  final Function(Doctor) onSave;

  /// If true, the doctor ID field will be read-only
  final bool isEditing;

  const DoctorForm({
    super.key,
    this.initialDoctor,
    required this.onSave,
    this.isEditing = false,
  });

  @override
  State<DoctorForm> createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  late final TextEditingController _idController;
  late final TextEditingController _designationController;
  late final TextEditingController _contactController;
  late String? _selectedDepartment;
  bool _isLoading = false;

  // Form validation
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController(
      text: widget.initialDoctor?.doctorId ?? '',
    );
    _designationController = TextEditingController(
      text: widget.initialDoctor?.designation ?? '',
    );
    _contactController = TextEditingController(
      text: widget.initialDoctor?.contactNumber ?? '',
    );
    _selectedDepartment = widget.initialDoctor?.department;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDepartment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a department')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final doctor = Doctor(
        doctorId: _idController.text.trim(),
        designation: _designationController.text.trim(),
        department: _selectedDepartment!,
        contactNumber: _contactController.text.isEmpty
            ? null
            : _contactController.text.trim(),
      );

      widget.onSave(doctor);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor ID Field
            TextFormField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: 'Doctor ID *',
                hintText: 'e.g., DOC001',
                border: const OutlineInputBorder(),
                enabled: !widget.isEditing && !_isLoading,
              ),
              enabled: !widget.isEditing && !_isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Doctor ID is required';
                }
                if (value.length < 3) {
                  return 'Doctor ID must be at least 3 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Designation Field
            TextFormField(
              controller: _designationController,
              decoration: InputDecoration(
                labelText: 'Designation *',
                hintText: 'e.g., Dr. John Doe',
                border: const OutlineInputBorder(),
                enabled: !_isLoading,
              ),
              enabled: !_isLoading,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Designation is required';
                }
                if (value.length < 2) {
                  return 'Designation must be at least 2 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Department Field
            DropdownButtonFormField<String>(
              value: _selectedDepartment,
              decoration: InputDecoration(
                labelText: 'Department *',
                border: const OutlineInputBorder(),
                enabled: !_isLoading,
              ),
              items: Department.values
                  .map(
                    (dept) => DropdownMenuItem(
                      value: dept.label,
                      child: Text(dept.label),
                    ),
                  )
                  .toList(),
              onChanged: !_isLoading
                  ? (value) => setState(() => _selectedDepartment = value)
                  : null,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select a department';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Contact Number Field
            TextFormField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: 'Contact Number',
                hintText: '+1234567890',
                border: const OutlineInputBorder(),
                enabled: !_isLoading,
              ),
              enabled: !_isLoading,
              validator: (value) {
                if (value != null && value.isNotEmpty && value.length < 10) {
                  return 'Please enter a valid contact number';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        widget.isEditing ? 'Update Doctor' : 'Create Doctor',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _designationController.dispose();
    _contactController.dispose();
    super.dispose();
  }
}
