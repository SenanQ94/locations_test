import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../constans.dart';
import '../widgets/my_appBar.dart';
import '../models/location_model.dart';
import '../widgets/location_widget.dart';
import '../providers/theme_provider.dart';
import '../providers/search_provider.dart';
import '../repositories/locations_api.dart';
import '../view_models/locations_view_model.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({Key? key}) : super(key: key);

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  var locationsViewModel = LocationsViewModel(locationsApi: LocationsApi());
  String? suchText;

  Future<List<LocationModel>> _getLocations() {
    suchText = Provider.of<SearchProvider>(context).suchText;
    return locationsViewModel.searchByName(suchText);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Consumer<ThemeNotifier>(
            builder: (context, notifier, child) => Container(
              color: notifier.darkTheme ? KAppBarColorDark : KAppBarColorLight,
              child: Container(child: MyAppBar()),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding / 2),
          child: FutureBuilder<List<LocationModel>>(
              future: _getLocations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  var locations = snapshot.data as List;
                  if (locations.isEmpty) {
                    return const Center(
                      child: const Text(
                        'Sorry, we did not find what you search for. \n Please check your search text.',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LocationWidget(locations[index]);
                    },
                  );
                } else {
                  return const Center(
                    child: const Text(
                        'Something went wrong, Please try again later!'),
                  );
                }
              }),
        ),
      ),
    );
  }
}
