import 'package:admin_app/models/caretaker.dart';
import 'package:admin_app/services/supabase_service.dart';

class CaretakerService {
  final SupabaseService _supabase;

  CaretakerService(this._supabase);

  Future<List<Caretaker>> getAllCaretakers() async {
    final res = await _supabase.client.from('caretakers').select();

    return (res as List).map((e) => Caretaker.fromJson(e)).toList();
  }

  Future<int> getCaretakersCount() async {
    final res = await _supabase.client
        .from('caretakers')
        .select('caretaker_id');

    return (res as List).length;
  }
}
