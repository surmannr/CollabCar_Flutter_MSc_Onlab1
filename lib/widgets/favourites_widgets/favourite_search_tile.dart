import 'package:collabcar/models/favourite_search.dart';
import 'package:collabcar/models/search.dart';
import 'package:collabcar/providers/favourite_search_provider.dart';
import 'package:collabcar/screens/service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavouriteSearchTile extends StatelessWidget {
  const FavouriteSearchTile(
      {required this.favourite,
      required this.provider,
      required this.documentId,
      Key? key})
      : super(key: key);

  final FavouriteSearch favourite;
  final Function provider;
  final String documentId;

  DataRow buildHistoryElements(String title, var data) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        data is bool?
            ? data == true
                ? const DataCell(
                    Text('Igen'),
                  )
                : data == false
                    ? const DataCell(
                        Text('Nem'),
                      )
                    : const DataCell(
                        Text('Nem számít'),
                      )
            : DataCell(
                Text(data?.toString() ?? 'Nem számít'),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              provider(documentId);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Törlés',
          ),
          SlidableAction(
            onPressed: (context) async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceScreen(
                      search: favourite,
                    ),
                  ));
            },
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            icon: Icons.search,
            label: 'Keres',
          ),
        ],
      ),
      child: Card(
        child: ExpansionTile(
          textColor: Colors.black,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.place,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Text(
                      favourite.placeFrom?.address ??
                          'Nem volt megadva kiinduló állomás.',
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Icon(
                Icons.more_vert,
                color: Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.place,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Text(
                      favourite.placeTo?.address ??
                          'Nem volt megadva célállomás.',
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataTable(
                  headingRowHeight: 0,
                  columns: [
                    DataColumn(label: Container()),
                    DataColumn(label: Container()),
                  ],
                  rows: [
                    buildHistoryElements('Keresett időpont:', favourite.date),
                    buildHistoryElements(
                        'Ülések száma minimum:', favourite.minSeatingCapacity),
                    buildHistoryElements('Maximális ár:', favourite.maxPrice),
                    buildHistoryElements('Vezető neve:', favourite.driverName),
                    buildHistoryElements(
                        'Állatok szállítása:', favourite.canTransportPets),
                    buildHistoryElements(
                        'Bicikli szállítása:', favourite.canTransportBicycle),
                    buildHistoryElements(
                        'Autópálya:', favourite.isGoingHighway),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
