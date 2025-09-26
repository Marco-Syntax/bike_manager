import 'dart:convert';
import 'package:bike_manager/models/bike.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IBikeStorage {
  Future<void> saveBikes(List<Bike> bikes);
  Future<List<Bike>> loadBikes();
}

class BikeStorage implements IBikeStorage {
  static const String _bikesKey = 'bikes';

  @override
  Future<void> saveBikes(List<Bike> bikes) async {
    final prefs = await SharedPreferences.getInstance();
    final bikesJson = bikes.map((bike) => bike.toJson()).toList();
    await prefs.setString(_bikesKey, jsonEncode(bikesJson));
  }

  @override
  Future<List<Bike>> loadBikes() async {
    final prefs = await SharedPreferences.getInstance();
    final bikesString = prefs.getString(_bikesKey);
    if (bikesString == null) return [];
    final List<dynamic> bikesJson = jsonDecode(bikesString);
    return bikesJson.map((json) => Bike.fromJson(json)).toList();
  }
}
