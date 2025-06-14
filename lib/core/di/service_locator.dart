import 'package:get_it/get_it.dart';
import '../services/hive_service.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  // HiveService
  final hiveService = HiveService();
  await hiveService.init();
  getIt.registerSingleton<HiveService>(hiveService);
}
