import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../helpers/location_helper.dart';
import '../screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function onSelectPlace;

  LocationInput(this.onSelectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    // Getting users current location
    final locData = await Location().getLocation();

    final staticMapUrl = LocationHelper.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );

    setState(() {
      _previewImageUrl = staticMapUrl;
    });
    widget.onSelectPlace(locData.latitude, locData.longitude);
  }

  Future<void> _selectOnMap() async {
    //final LatLng selectedLocation = await Navigator.of(context).push(
    var selectedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapScreen(
          isSelecting: true,
        ),
      ),
    );
    if (selectedLocation == null) {
      return;
    } else {
      widget.onSelectPlace(
          selectedLocation.latitude, selectedLocation.longitude);
      //setting to preview window
      setState(
        () {
          _previewImageUrl = LocationHelper.generateLocationPreviewImage(
            latitude: selectedLocation.latitude,
            longitude: selectedLocation.longitude,
          );
        },
      );
      // setting back to null cause if we first fetched current location
      //& then we wanna manually select then for preview purpose we must
      // set it to null
      selectedLocation = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          child: _previewImageUrl == null
              ? Text(
                  "No Location Chosen",
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              label: Text("Current Location"),
              textColor: Theme.of(context).primaryColor,
              onPressed: () {
                _getCurrentUserLocation();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              label: Text("Select On Map"),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
            ),
          ],
        ),
      ],
    );
  }
}
