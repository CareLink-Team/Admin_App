import 'package:admin_app/services/supabase_service.dart';

class DashboardService {
  final SupabaseService _supabase;

  DashboardService(this._supabase);

  Future<int> totalPatients() async {
    final res = await _supabase.client.from('patients').select('patient_id');
    return (res as List).length;
  }

  Future<int> totalDoctors() async {
    final res = await _supabase.client.from('doctors').select('doctor_id');
    return (res as List).length;
  }

  Future<int> totalCaretakers() async {
    final res = await _supabase.client
        .from('caretakers')
        .select('caretaker_id');
    return (res as List).length;
  }
}
