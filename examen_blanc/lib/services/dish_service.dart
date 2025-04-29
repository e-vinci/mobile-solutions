import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/dish.dart';

const _apiUrl = "https://sebstreb.github.io/binv2110-examen-blanc-api/dishes";

Future<List<Dish>> fetchDishes() async {
  var response = await get(Uri.parse(_apiUrl));

  if (response.statusCode != 200) {
    throw Exception("Error ${response.statusCode} fetching movies");
  }

  return compute((input) {
    final jsonList = jsonDecode(input);
    return jsonList
        .map<Dish>((jsonObj) => Dish(
              name: jsonObj["name"],
              price: jsonObj["price"],
              category: jsonObj["category"],
              imagePath: jsonObj["imagePath"],
            ))
        .toList();
  }, response.body);
}
