import 'package:flutter/material.dart';
import '../models/location_model.dart';

class LocationWidget extends StatefulWidget {
  final LocationModel location;

  LocationWidget(this.location);

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  bool _isExpanded = false;
  Widget _getIcon(String? type) {
    switch (type) {
      case 'street':
        return Icon(
          Icons.add_road_outlined,
          color: Colors.blueAccent,
        );
      case 'suburb':
        return Icon(
          Icons.location_city,
          color: Colors.blueAccent,
        );

      case 'poi':
        return Icon(
          Icons.my_location_outlined,
          color: Colors.blueAccent,
        );

      case 'stop':
        return Icon(
          Icons.traffic_outlined,
          color: Colors.blueAccent,
        );

      default:
        return Icon(
          Icons.location_on_outlined,
          color: Colors.blueAccent,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: _isExpanded ? 160 : 100,
      child: Card(
        margin: EdgeInsets.all(5),
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ListTile(
              tileColor:
                  widget.location.isBest == true ? Colors.amber[100] : null,
              leading: FittedBox(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _getIcon(widget.location.type),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '${widget.location.type!.toUpperCase()}',
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.justify,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              ),
              title: Text('${widget.location.name}'),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      'Coords: (${widget.location.coord![0]} , ${widget.location.coord![1]})'),
                  if (widget.location.isBest == true)
                    Text(
                      'The Best',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.blueGrey,
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
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              height: _isExpanded ? 60 : 0,
              child: ListView(
                children: [
                  Row(children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Icon(
                        Icons.arrow_downward_sharp,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(child: Divider()),
                  ]),
                  Row(
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
                          color: Colors.grey,
                        ),
                      )
                    ],
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
