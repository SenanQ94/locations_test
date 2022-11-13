import 'package:flutter/material.dart';

import '../../consts/constans.dart';
import '../../models/location_model.dart';

class LocationWidget extends StatefulWidget {
  final LocationModel location;

  LocationWidget(this.location);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool _isExpanded = false;

  // set Icon according to the Type of the location
  IconData _getIcon(String? type) {
    switch (type) {
      case 'street':
        return Icons.add_road_outlined;

      case 'suburb':
        return Icons.location_city;

      case 'poi':
        return Icons.my_location_outlined;

      case 'stop':
        return Icons.traffic_outlined;

      default:
        return Icons.location_on_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _isExpanded ? 160 : 100,
      child: Card(
        margin: EdgeInsets.all(kDefaultPadding / 2),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            InkWell(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },

              // show the basic information about the location

              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      _getIcon(widget.location.type),
                      size: kDefaultIconSize,
                    ),
                    Text(
                      '${widget.location.type!.toUpperCase()}',
                      style: TextStyle(fontSize: 8),
                    ),
                  ],
                ),
                title: Text('${widget.location.name}'),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Coords: (${widget.location.coord![0]} , ${widget.location.coord![1]})'),
                    if (widget.location.isBest == true)
                      Text(
                        'The Best',
                        style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      )
                  ],
                ),
                trailing: IconButton(
                  icon: _isExpanded
                      ? Icon(Icons.expand_less)
                      : Icon(Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ),
            ),

            // show extra information about the parent of the location

            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _isExpanded ? 60 : 0,
              child: ListView(
                children: [
                  Row(children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.arrow_downward_sharp,
                      ),
                    ),
                    Expanded(child: Divider()),
                  ]),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          widget.location.parent!['name'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.location.parent!['type'],
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
