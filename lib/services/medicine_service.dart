import 'package:admin_app/models/medicine.dart';
import 'package:admin_app/services/supabase_service.dart';

class MedicineService {
  final SupabaseService _supabase;

  MedicineService(this._supabase);

  Future<List<Medicine>> getAllMedicines() async {
    final res = await _supabase.client
        .from('medicines')
        .select()
        .order('created_at');

    return (res as List).map((e) => Medicine.fromJson(e)).toList();
  }

  Future<void> addMedicine(Medicine medicine) async {
    await _supabase.client.from('medicines').insert(medicine.toJson());
  }
}
