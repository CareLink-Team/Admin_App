import 'services/supabase_service.dart';

void main() {
  // runApp(const MyApp());
  final supabaseService = SupabaseService();
  supabaseService.initialize();
}
