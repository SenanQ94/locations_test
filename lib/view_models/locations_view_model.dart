import '../repositories/locations_api.dart';
import '../models/location_model.dart';

class LocationsViewModel {
  LocationsApi? locationsApi;

  LocationsViewModel({this.locationsApi});

  //pass data between the view and the model

  Future<List<LocationModel>> searchByName(String? suchText) async {
    List<LocationModel> listOfLocations =
        await locationsApi!.getLocationByName(suchText);

    return listOfLocations
        .map((location) => LocationModel(
              id: location.id,
              name: location.name,
              coord: location.coord,
              type: location.type,
              matchQuality: location.matchQuality,
              isBest: location.isBest,
              parent: location.parent,
            ))
        .toList();
  }
}
