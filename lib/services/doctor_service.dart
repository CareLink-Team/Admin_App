import 'package:admin_app/models/doctor.dart';
import 'package:admin_app/services/supabase_service.dart';

class DoctorService {
  final SupabaseService _supabase;

  DoctorService(this._supabase);

  Future<List<Doctor>> getAllDoctors() async {
    final res = await _supabase.client.from('doctors').select();

    return (res as List).map((e) => Doctor.fromJson(e)).toList();
  }

  Future<int> getDoctorsCount() async {
    final res = await _supabase.client.from('doctors').select('doctor_id');

    return (res as List).length;
  }
}
