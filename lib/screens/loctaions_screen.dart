import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constans.dart';
import '../providers/theme_provider.dart';
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
  String? suchText;

  Widget _getAppBar(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, child) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    notifier.toggleTheme();
                  },
                  icon: Icon(
                    notifier.darkTheme
                        ? Icons.wb_sunny_outlined
                        : Icons.nights_stay_outlined,
                    color: kAppBarElementsColor,
                  ),
                ),
                Text(
                  'Mentz',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: kAppBarElementsColor),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                                contentPadding:
                                    EdgeInsets.all(kDefaultPadding * 2),
                                title: Text(
                                  'Contact Info',
                                  textAlign: TextAlign.center,
                                ),
                                children: [
                                  Text(
                                    aboutMe,
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
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: notifier.darkTheme ? kSearchBgDark : kSearchBgLight,
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
                      icon:
                          const Icon(Icons.clear, color: kAppBarElementsColor),
                      onPressed: () {
                        setState(() {
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var locationsViewModel = LocationsViewModel(locationsApi: LocationsApi());
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120.0),
          child: Consumer<ThemeNotifier>(
            builder: (context, notifier, child) => Container(
              color: notifier.darkTheme ? KAppBarColorDark : KAppBarColorLight,
              child: Container(child: _getAppBar(context)),
            ),
          ),
        ),
        body: FutureBuilder<List<LocationModel>>(
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
    );
  }
}
