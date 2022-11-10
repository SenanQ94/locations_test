import 'package:flutter/material.dart';
import '../repositories/locations_api.dart';
import '../view_models/location_view_model.dart';
import '../view_models/locationss_view_model.dart';

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
    var locationViewModel =
        LocationsViewModel(locationsRepository: LocationsApi());

    return Scaffold(
      appBar: _searchBoolean
          ? AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                      // border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            )
          : AppBar(
              title: const Text('Search for Location'),
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
        child: FutureBuilder<List<LocationViewModel>>(
            future: locationViewModel.searchByName(suchText),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                var locations = snapshot.data;

                return ListView.builder(
                  itemCount: locations?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.pink,
                          child: Text('#${index + 1}'),
                        ),
                        trailing: locations![index].isBest
                            ? const Text(
                                'The best',
                                style: TextStyle(color: Colors.blue),
                              )
                            : null,
                        title: Text(locations[index].name),
                        subtitle: Text('Type: ${locations[index].type}'),
                      ),
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}
