import 'dart:io';

import 'package:flutter/cupertino.dart';
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
    DBHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList.map((element) {
      return Place(
        id: element['id'],
        title: element['title'],
        location: null,
        image: File(element['image']),
      );
    }).toList();
    notifyListeners();
  }
}
