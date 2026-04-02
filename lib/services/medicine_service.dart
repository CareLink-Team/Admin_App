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

  Future<void> updateMedicine(String medicineId, Medicine medicine) async {
    await _supabase.client
        .from('medicines')
        .update(medicine.toJson())
        .eq('medicine_id', medicineId);
  }

  Future<void> deleteMedicine(String medicineId) async {
    await _supabase.client
        .from('medicines')
        .delete()
        .eq('medicine_id', medicineId);
  }

  Future<int> getMedicinesCount() async {
    try {
      final res = await _supabase.client
          .from('medicines')
          .select('medicine_id');
      return (res as List).length;
    } catch (e) {
      throw Exception('Failed to get medicines count: $e');
    }
  }
}
