import 'package:admin_app/models/doctor.dart';
import 'package:admin_app/services/supabase_service.dart';

class DoctorService {
  final SupabaseService _supabase;

  DoctorService(this._supabase);

  /// Fetch all doctors from the database
  Future<List<Doctor>> getAllDoctors() async {
    try {
      final res = await _supabase.client.from('doctors').select();

      return (res as List)
          .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch doctors: $e');
    }
  }

  /// Get the total count of doctors
  Future<int> getDoctorsCount() async {
    try {
      final res = await _supabase.client.from('doctors').select('doctor_id');
      return (res as List).length;
    } catch (e) {
      throw Exception('Failed to get doctors count: $e');
    }
  }

  /// Fetch a single doctor by their ID
  Future<Doctor?> getDoctorById(String doctorId) async {
    try {
      final res = await _supabase.client
          .from('doctors')
          .select()
          .eq('doctor_id', doctorId)
          .maybeSingle();

      if (res == null) {
        return null;
      }

      return Doctor.fromJson(res as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch doctor: $e');
    }
  }

  /// Create a new doctor
  Future<Doctor> createDoctor(Doctor doctor) async {
    try {
      final response = await _supabase.client
          .from('doctors')
          .insert(doctor.toJson())
          .select()
          .single();

      return Doctor.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to create doctor: $e');
    }
  }

  /// Update an existing doctor
  Future<Doctor> updateDoctor(String doctorId, Doctor doctor) async {
    try {
      final response = await _supabase.client
          .from('doctors')
          .update(doctor.toJson())
          .eq('doctor_id', doctorId)
          .select()
          .single();

      return Doctor.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to update doctor: $e');
    }
  }

  /// Delete a doctor by their ID
  Future<void> deleteDoctor(String doctorId) async {
    try {
      await _supabase.client.from('doctors').delete().eq('doctor_id', doctorId);
    } catch (e) {
      throw Exception('Failed to delete doctor: $e');
    }
  }

  /// Search doctors by name or department
  Future<List<Doctor>> searchDoctors(String query) async {
    try {
      final res = await _supabase.client
          .from('doctors')
          .select()
          .ilike('designation', '%$query%')
          .or('department.ilike.%$query%');

      return (res as List)
          .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search doctors: $e');
    }
  }

  /// Get doctors filtered by department
  Future<List<Doctor>> getDoctorsByDepartment(String department) async {
    try {
      final res = await _supabase.client
          .from('doctors')
          .select()
          .eq('department', department);

      return (res as List)
          .map((e) => Doctor.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch doctors by department: $e');
    }
  }
}
