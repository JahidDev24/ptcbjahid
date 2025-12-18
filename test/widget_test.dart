import 'package:flutter/services.dart'; // For PathProvider (if needed)
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Import Hive
import 'package:ptcbjahid/data/models/deal_model.dart'; // Import your Adapter

void main() {
  // 1. Setup Hive specifically for Widget Tests
  setUpAll(() async {
    // This uses an in-memory path so it doesn't touch real files
    TestWidgetsFlutterBinding.ensureInitialized();

    // Using Hive.init without path works better in some test envs,
    // or set a distinct temp path.
    // For pure Widget tests without real device storage, often MOCKING is better.
    // But to fix the crash:
    Hive.init('./test_hive_cache');

    // Register adapter if your code relies on it immediately
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(DealDataAdapter());
    }
  });

  tearDownAll(() async {
    // Clean up
    await Hive.deleteFromDisk();
  });

  testWidgets('Home Screen loads...', (WidgetTester tester) async {
    // ... your test code ...
  });
}
