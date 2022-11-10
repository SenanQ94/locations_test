import '../models/location_model.dart';
import '../repositories/locations_repo.dart';
import '../view_models/location_view_model.dart';

class LocationsViewModel {
  String title = 'Posts Page';
  LocationsRepository? locationsRepository;

  LocationsViewModel({this.locationsRepository});

  Future<List<LocationViewModel>> searchByName(String? suchText) async {
    List<LocationModel> listOfLocations =
        await locationsRepository!.getLocationByName(suchText);

    return listOfLocations
        .map((location) => LocationViewModel(locationModel: location))
        .toList();
  }
}
