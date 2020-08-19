import 'dart:io';

import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/db_helper.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items]; // getting copy of _itmes converting it to list
  }

  addPlace(String tittle, File image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: tittle,
      location: null,
      image: image,
    );

    // adding new place to _items list
    _items.add(newPlace);
    notifyListeners();

    //storing in database
    DBHelper.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }
}
