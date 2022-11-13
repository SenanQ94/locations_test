import 'package:dio/dio.dart';
import 'package:collection/collection.dart';

import '../network.dart';
import '../models/location_model.dart';

class LocationsApi {
  Future<List<LocationModel>> getLocationByName(String? suchText) async {
    List<LocationModel> locations = [];
    //define request params
    Map<String, dynamic> queryparams = {
      'language': 'de',
      'outputFormat': 'RapidJSON',
      'type_sf': 'any',
      'name_sf': suchText,
    };
    try {
      //connecting to the API
      var response = await Dio().get(apiBaseURL, queryParameters: queryparams);
      var locationsList = response.data['locations'] as List;
      locations = locationsList
          .map((location) => LocationModel.createFromJSON(location))
          .toList();
      // sort the locations according to matchQuality values
      locations.sort((a, b) => b.matchQuality!.compareTo(a.matchQuality!));

      //put best match at first
      var index = locations.indexWhere((location) => location.isBest == true);
      locations.swap(0, index);
    } catch (e) {
      print(e);
    }
    return locations;
  }
}
