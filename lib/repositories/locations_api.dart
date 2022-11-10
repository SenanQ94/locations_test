// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

import '../models/location_model.dart';
import '../models/post_model.dart';
import '../repositories/locations_repo.dart';

class LocationsApi extends LocationsRepository {
  @override
  Future<List<LocationModel>> getAllLocations(String? suchText) async {
    List<LocationModel> locations = [];
    try {
      print('---------api conn ------');
      var response = await Dio().get(
          'https://mvvvip1.defas-fgi.de/mvv/XML_STOPFINDER_REQUEST?language=de&outputFormat=RapidJSON&type_sf=any&name_sf=$suchText');

      var res = response.data as Map<String, dynamic>;
      var locationsList = res['locations'] as List;
      locations = locationsList
          .map((location) => LocationModel.getJson(location))
          .toList();
    } catch (e) {
      print(e);
    }
    print(locations);
    return locations;
  }

  @override
  Future<PostModel> getPostById(int id) {
    throw UnimplementedError();
  }
}
