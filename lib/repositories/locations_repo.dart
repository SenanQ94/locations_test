import '../models/location_model.dart';

abstract class LocationsRepository {
  Future<List<LocationModel>> getLocationByName(String? suchText);
  //Future<LocationModel> getLocationById(int id);
}
