import 'package:hive_flutter/hive_flutter.dart';
import 'package:ptcbjahid/data/models/deal_model.dart';

class DealLocalDataSource {
  static const String _boxName = 'dealsBox';

  Future<void> cacheDeals(List<DealData> deals) async {
    final box = await Hive.openBox<DealData>(_boxName);
    // Clear old cache before saving new "Top" deals to avoid duplicates/stale data
    // For a real app, you might want more complex logic (like appending),
    // but for an assignment, replacing the cache is acceptable and stable.
    await box.clear();
    await box.addAll(deals);
  }

  Future<List<DealData>> getLastDeals() async {
    final box = await Hive.openBox<DealData>(_boxName);
    return box.values.toList();
  }
}
