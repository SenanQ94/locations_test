import 'package:flutter/material.dart';

class ApplicationChallenge extends StatefulWidget {
  const ApplicationChallenge({Key? key}) : super(key: key);

  @override
  State<ApplicationChallenge> createState() => _ApplicationChallengeState();
}

class _ApplicationChallengeState extends State<ApplicationChallenge> {
  final TextEditingController _searchController = TextEditingController();
  bool _searchBoolean = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _searchBoolean
          ? AppBar(
              title: Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (String text) {
                      if (_searchController.text.isNotEmpty) {}
                      if (_searchController.text.isEmpty) {
                        setState(() {});
                      }
                    },
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            setState(() {
                              _searchBoolean = false;
                            });
                          },
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none),
                  ),
                ),
              ),
            )
          : AppBar(
              title: const Text('Search for a Meal'),
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
      body: const Center(
        child: Padding(
            padding: EdgeInsets.all(10.0), child: Center(child: Text('hi'))),
      ),
    );
  }
}
