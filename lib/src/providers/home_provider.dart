import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_piggy/src/models/PiggyModel.dart';

class HomeProvider extends ChangeNotifier {
  Future<void> addToPiggy(Piggymodel piggy) async {}

  Future<void> _saveToLocal(Piggymodel piggy) async {
    const storage = FlutterSecureStorage();

    await storage.write(key: 'piggies', value: piggy);
  }
}
