import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routName);
            },
          )
        ],
      ),
      body: Consumer<GreatPlaces>(
          child: Center(
            child: Text("Got No Places yet, Start Adding some"),
          ),
          builder: (context, value, chiiild) => value.items.length <= 0
              ? chiiild
              : ListView.builder(
                  itemCount: value.items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: FileImage(value.items[index].image),
                      ),
                      title: Text(value.items[index].title),
                      onTap: () {
                        //go to detail page
                      },
                    );
                  },
                )),
    );
  }
}
