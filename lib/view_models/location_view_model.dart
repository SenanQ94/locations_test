import '../models/location_model.dart';

class LocationViewModel {
  LocationModel? locationModel;

  LocationViewModel({this.locationModel});

  get id => locationModel?.id;
  get name => locationModel?.name;
  get coord => locationModel?.coord;
  get type => locationModel?.type;
  get matchQuality => locationModel?.matchQuality;
  get isBest => locationModel?.isBest;
  get parent => locationModel?.parent;
}
