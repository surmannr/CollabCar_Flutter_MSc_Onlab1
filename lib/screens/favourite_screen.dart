import 'package:cloud_firestore/cloud_firestore.dart';
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
    return StreamBuilder(
        stream: Provider.of<FavouriteSearchProvider>(context).getFromFirebase(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final documents = snapshot.data!.docs;
            if (snapshot.error != null) {
              // ...
              // Do error handling stuff
              return const Center(
                child: Text('An error occurred!'),
              );
            } else {
              if (snapshot.hasData && documents.isEmpty) {
                return const Center(
                  child: Text('Nincs kedvenc keresési előzményed.'),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          FavouriteSearchTile(
                            favourite:
                                documents[index].data() as FavouriteSearch,
                            provider:
                                Provider.of<FavouriteSearchProvider>(context)
                                    .deleteFavouriteElement,
                            documentId: documents[index].reference.id,
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: documents.length,
                );
              }
            }
          }
        });
  }
}
