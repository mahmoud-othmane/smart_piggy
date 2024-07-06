import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smart_piggy/src/models/PiggyModel.dart';

class HomeProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  Future<void> addToPiggy(Piggymodel piggy) async {
    if (piggy.amount != null) {
      await _saveToLocal(piggy);
    }
  }

  Future<void> _saveToLocal(Piggymodel piggy) async {
    List<Piggymodel> tempPiggies = await _getAllDataString();
    tempPiggies.add(piggy);
    final jsons = tempPiggies.map((piggy) => piggy.toJson()).toList();
    String? piggiesJsonString = json.encode(jsons);
    await storage.write(key: 'piggies', value: piggiesJsonString);
  }

  Future<List<Piggymodel>> _getAllDataString() async {
    List jsonString = json.decode((await storage.read(key: 'piggies')) ?? '');
    return Piggymodel.fromJsonList(jsonString);
  }
}
