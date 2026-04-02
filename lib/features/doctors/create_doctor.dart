import 'package:flutter/material.dart';
import 'package:admin_app/core/theme/app_theme.dart';
import 'package:admin_app/models/doctor.dart';
import 'package:admin_app/services/doctor_service.dart';
import 'package:admin_app/services/supabase_service.dart';
import 'doctor_form.dart';

/// Dialog for creating a new doctor
class CreateDoctorDialog extends StatefulWidget {
  /// Called when the doctor is successfully created
  final Function(Doctor) onSave;

  const CreateDoctorDialog({super.key, required this.onSave});

  @override
  State<CreateDoctorDialog> createState() => _CreateDoctorDialogState();
}

class _CreateDoctorDialogState extends State<CreateDoctorDialog> {
  late DoctorService _doctorService;

  @override
  void initState() {
    super.initState();
    _doctorService = DoctorService(SupabaseService());
  }

  Future<void> _handleSave(Doctor doctor) async {
    try {
      final created = await _doctorService.createDoctor(doctor);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Doctor created successfully')),
        );
        widget.onSave(created);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating doctor: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Add New Doctor'),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: DoctorForm(onSave: _handleSave, isEditing: false),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
