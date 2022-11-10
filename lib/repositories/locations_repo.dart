import '../models/location_model.dart';
import '../models/post_model.dart';

abstract class LocationsRepository {
  Future<List<LocationModel>> getAllLocations(String? suchText);
  Future<PostModel> getPostById(int id);
}
