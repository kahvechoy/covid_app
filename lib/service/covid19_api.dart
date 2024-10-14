import 'dart:convert';

import 'package:api_challanges_skl/config/config.dart';
import 'package:api_challanges_skl/model/hoaxes.dart';
import 'package:api_challanges_skl/model/hospitals.dart';
import 'package:api_challanges_skl/model/news.dart';
import 'package:api_challanges_skl/model/stats.dart';
import 'package:http/http.dart' as http;

class Covid19Api {
  Future<List<Hoaxes>?> getHoaxes() async {
    var url = Uri.parse('${covid19URL}hoaxes');
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((hoaxs) => Hoaxes.fromJson(hoaxs)).toList();
    } else {
      print('Request gagal dengan status: ${response.statusCode}');
      return null;
    }
  }

  Future<List<News>?> getNews() async {
    var url = Uri.parse('${covid19URL}news');
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((news) => News.fromJson(news)).toList();
    } else {
      print('Request gagal dengan status: ${response.statusCode}');
      return null;
    }
  }

  Future<List<Hospitals>?> getHospitals() async {
    var url = Uri.parse('${covid19URL}hospitals');
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((hospitals) => Hospitals.fromJson(hospitals))
          .toList();
    } else {
      print('Request gagal dengan status: ${response.statusCode}');
      return null;
    }
  }

  Future<Stats> getStats() async {
    var url = Uri.parse('${covid19URL}stats');
    print(url);

    var response = await http.get(url);
    print(response.body);

    if (response.statusCode == 200) {
      return statsFromJson(response.body);
    } else {
      throw Exception('Failed to load status data');
    }
  }
}
