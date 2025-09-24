import 'dart:convert';
import 'package:bike_manager/models/bike.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BikeStorage {
  static const String _bikesKey = 'bikes';

  Future<void> saveBikes(List<Bike> bikes) async {
    final prefs = await SharedPreferences.getInstance();
    final bikesJson = bikes.map((bike) => bike.toJson()).toList();
    await prefs.setString(_bikesKey, jsonEncode(bikesJson));
  }

  Future<List<Bike>> loadBikes() async {
    final prefs = await SharedPreferences.getInstance();
    final bikesString = prefs.getString(_bikesKey);
    if (bikesString == null) return [];
    final List<dynamic> bikesJson = jsonDecode(bikesString);
    return bikesJson.map((json) => Bike.fromJson(json)).toList();
  }
}
