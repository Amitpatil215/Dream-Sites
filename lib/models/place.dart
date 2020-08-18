import 'package:flutter/cupertino.dart';
import 'dart:io'; // for file data type

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  PlaceLocation({
    @required this.latitude,
    @required this.longitude,
    this.address,
  });
}

class Place {
  final String id;
  final String title;
  final File image; // we storing data in file so using file data type
  final PlaceLocation location;

  Place({
    @required this.id,
    @required this.title,
    @required this.location,
    @required this.image,
  });
}
