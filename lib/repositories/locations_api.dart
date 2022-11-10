// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

import '../models/location_model.dart';
import '../repositories/locations_repo.dart';

class LocationsApi extends LocationsRepository {
  @override
  Future<List<LocationModel>> getLocationByName(String? suchText) async {
    List<LocationModel> locations = [];
    try {
      var response = await Dio().get(
          'https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&type_sf=any&name_sf={$suchText}');

      var res = response.data as Map<String, dynamic>;
      var locationsList = res['locations'] as List;
      locations = locationsList
          .map((location) => LocationModel.getJson(location))
          .toList();
    } catch (e) {
      print(e);
    }

    return locations;
  }

  // @override
  // Future<LocationModel> getPostById(int id) {
  //   throw UnimplementedError();
  // }
}
