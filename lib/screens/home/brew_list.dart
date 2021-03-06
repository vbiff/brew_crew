import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/brew_tile.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class BrewList extends StatefulWidget {
  const BrewList({ Key? key }) : super(key: key);

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

final brews = Provider.of<List<Brew>?>(context) ?? [];

return ListView.builder(
  itemCount: brews.length,
  itemBuilder: (context, index) {
    return BrewTile(brew: brews[index]);
  },

// if (brews != null) {
// brews.forEach((brew) {
//   print(brew.name);
//   print(brew.strength);
//   print(brew.sugars);
// });
// }
// if (brews != null) {
// for (var doc in brews.docs) {
//   print(doc.data());
// }
// }
     
    );
  }
}