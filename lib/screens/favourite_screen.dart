import 'package:collabcar/models/favourite_search.dart';
import 'package:collabcar/providers/favourite_search_provider.dart';
import 'package:collabcar/widgets/favourites_widgets/favourite_search_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<FavouriteSearchProvider>(context).getFromFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              // ...
              // Do error handling stuff
              return const Center(
                child: Text('An error occurred!'),
              );
            } else {
              if (snapshot.hasData &&
                  (snapshot.data as List<FavouriteSearch>).isEmpty) {
                return const Center(
                  child: Text('Nincs kedvenc keresési előzményed.'),
                );
              } else {
                return Consumer<FavouriteSearchProvider>(
                  builder: (context, value, child) => ListView.builder(
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            FavouriteSearchTile(
                              favourite: value.favourites[index],
                              provider: value,
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: value.favourites.length,
                  ),
                );
              }
            }
          }
        });
  }
}
