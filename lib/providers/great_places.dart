import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';
import '../helpers/location_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items]; // getting copy of _itmes converting it to list
  }

  Place findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  addPlace(String tittle, File image, PlaceLocation pickedLocation) async {
    //getting place human redable address
    final address = await LocationHelper.getPlaceAddress(
        pickedLocation.latitude, pickedLocation.longitude);
    final updateLocation = PlaceLocation(
      latitude: pickedLocation.latitude,
      longitude: pickedLocation.longitude,
      address: address,
    );
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: tittle,
      location: updateLocation,
      image: image,
    );

    // adding new place to _items list
    _items.add(newPlace);
    notifyListeners();

    //storing in database
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map((element) {
      return Place(
        id: element['id'],
        title: element['title'],
        location: PlaceLocation(
          latitude: element['loc_lat'],
          longitude: element['loc_lng'],
          address: element['address'],
        ),
        image: File(element['image']),
      );
    }).toList();
    notifyListeners();
  }
}
