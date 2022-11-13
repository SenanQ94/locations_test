// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../consts/constans.dart';
import '../widgets/my_appBar.dart';
import '../../models/location_model.dart';
import '../widgets/location_widget.dart';
import '../../providers/theme_provider.dart';
import '../../providers/search_provider.dart';
import '../../repositories/locations_api.dart';
import '../../view_models/locations_view_model.dart';

class LocationsScreen extends StatelessWidget {
  var locationsViewModel = LocationsViewModel(locationsApi: LocationsApi());
  String? suchText;
  // get Locations by taking the value of 'suchText' from SearchProvider and pass it to search
  // methode in locationsViewModel
  Future<List<LocationModel>> _getLocations(BuildContext context) {
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
              future: _getLocations(context),
              builder: (context, snapshot) {
                // check connectiong state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                // check if we have returned data
                if (snapshot.hasData) {
                  var locations = snapshot.data as List;

                  // check if the search result is an empty list
                  if (locations.isEmpty) {
                    return const Center(
                      child: const Text(
                        'Sorry, we did not find what you search for. \n Please check your search text.',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }
                  // check if the search result is not an empty list
                  // and build the list view with returned data
                  return ListView.builder(
                    itemCount: locations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LocationWidget(locations[index]);
                    },
                  );
                } else {
                  // show a messege if an error happend
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
