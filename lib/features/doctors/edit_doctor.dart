import 'package:flutter/material.dart';
import 'package:admin_app/core/theme/app_theme.dart';
import 'package:admin_app/models/doctor.dart';
import 'package:admin_app/services/doctor_service.dart';
import 'package:admin_app/services/supabase_service.dart';
import 'doctor_form.dart';

/// Dialog for editing an existing doctor
class EditDoctorDialog extends StatefulWidget {
  /// The doctor to be edited
  final Doctor doctor;

  /// Called when the doctor is successfully updated
  final Function(Doctor) onSave;

  const EditDoctorDialog({
    super.key,
    required this.doctor,
    required this.onSave,
  });

  @override
  State<EditDoctorDialog> createState() => _EditDoctorDialogState();
}

class _EditDoctorDialogState extends State<EditDoctorDialog> {
  late DoctorService _doctorService;

  @override
  void initState() {
    super.initState();
    _doctorService = DoctorService(SupabaseService());
  }

  Future<void> _handleSave(Doctor doctor) async {
    try {
      final updated = await _doctorService.updateDoctor(
        widget.doctor.doctorId,
        doctor,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Doctor updated successfully')),
        );
        widget.onSave(updated);
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating doctor: $e'),
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
          const Text('Edit Doctor'),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      content: DoctorForm(
        initialDoctor: widget.doctor,
        onSave: _handleSave,
        isEditing: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
