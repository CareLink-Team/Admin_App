import 'package:admin_app/services/supabase_service.dart';
import 'package:admin_app/models/patient.dart';

class PatientService {
  final SupabaseService _supabase;

  PatientService(this._supabase);

  Future<List<Patient>> getAllPatients() async {
    final res = await _supabase.client.from('patients').select();

    return (res as List).map((e) => Patient.fromJson(e)).toList();
  }

  Future<int> getPatientsCount() async {
    final res = await _supabase.client.from('patients').select('patient_id');

    return (res as List).length;
  }
}
