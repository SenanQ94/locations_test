import 'package:flutter/material.dart';
import 'package:mvvm/constans.dart';
import 'package:mvvm/repositories/locations_api.dart';

import '../models/location_model.dart';
import '../view_models/locationss_view_model.dart';
import '../widgets/location_widget.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({Key? key}) : super(key: key);

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _searchBoolean = false;
  String? suchText;
  @override
  Widget build(BuildContext context) {
    var locationsViewModel = LocationsViewModel(locationsApi: LocationsApi());

    return Scaffold(
      appBar: _searchBoolean
          ? AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  //color: kScaffoldColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: TextField(
                    keyboardType: TextInputType.streetAddress,
                    textInputAction: TextInputAction.search,
                    textCapitalization: TextCapitalization.sentences,
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (String text) {
                      setState(() {
                        suchText = text;
                      });
                    },
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _searchBoolean = false;
                            _searchController.clear();
                          });
                        },
                      ),
                      hintText: 'Search...',
                    ),
                  ),
                ),
              ),
            )
          : AppBar(
              title: const Text('Search for Location'),
              //backgroundColor: kScaffoldColor,
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _searchBoolean = true;
                      });
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
      body: Center(
        child: FutureBuilder<List<LocationModel>>(
            future: locationsViewModel.searchByName(suchText),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasData) {
                var locations = snapshot.data as List;
                if (locations.isEmpty) {
                  return const Center(
                    child: Text(
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
                  child: Text('Something went wrong, Please try again later!'),
                );
              }
            }),
      ),
    );
  }
}
