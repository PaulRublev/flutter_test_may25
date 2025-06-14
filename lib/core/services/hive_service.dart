import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

const String userBoxName = 'user';
const String dataBoxName = 'data';

class HiveService {
  Future<void> init() async {
    final dir = await getApplicationSupportDirectory();
    await Hive.initFlutter(dir.path);

    // Пример регистрации адаптера:
    // Hive.registerAdapter(UserModelAdapter());

    await Hive.openBox(userBoxName);
    await Hive.openBox(dataBoxName);
  }

  Box get userBox => Hive.box(userBoxName);

  Box get dataBox => Hive.box(dataBoxName);
}
