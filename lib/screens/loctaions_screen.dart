import 'package:flutter/material.dart';
import '../constans.dart';
import '../repositories/locations_api.dart';

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

  Widget _getAppBar(bool search) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.wb_sunny_outlined)),
            Spacer(flex: 1),
            Text(
              'Plan Your Trip',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: kAppBarElementsColor),
            ),
            Spacer(flex: 10),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                            contentPadding: EdgeInsets.all(20),
                            alignment: Alignment.center,
                            title: Text('Contact Info'),
                            children: [
                              Text(
                                aboutMe,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ));
                },
                icon: Icon(
                  Icons.info_outline_rounded,
                  color: kAppBarElementsColor,
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: kSearchBg,
              borderRadius: BorderRadius.circular(kDefaultRadius),
            ),
            child: Center(
              child: TextField(
                keyboardType: TextInputType.streetAddress,
                textInputAction: TextInputAction.search,
                textCapitalization: TextCapitalization.sentences,
                controller: _searchController,
                style: TextStyle(color: kAppBarElementsColor),
                onChanged: (String text) {
                  setState(() {
                    suchText = text;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon:
                      const Icon(Icons.search, color: kAppBarElementsColor),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: kAppBarElementsColor),
                    onPressed: () {
                      setState(() {
                        _searchBoolean = false;
                        suchText = '';
                        _searchController.clear();
                      });
                    },
                  ),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: kAppBarElementsColor),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var locationsViewModel = LocationsViewModel(locationsApi: LocationsApi());
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Container(
            color: KAppBarColor,
            child: _getAppBar(_searchBoolean),
          ),
        ),
        body: Column(
          children: [
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
