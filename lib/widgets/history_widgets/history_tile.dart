import 'package:collabcar/models/search.dart';
import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({required this.history, Key? key}) : super(key: key);

  final Search history;

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
    return Card(
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
                    history.placeFrom?.address ??
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
                    history.placeTo?.address ?? 'Nem volt megadva célállomás.',
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
                  buildHistoryElements('Keresett időpont:', history.date),
                  buildHistoryElements(
                      'Ülések száma minimum:', history.minSeatingCapacity),
                  buildHistoryElements('Maximális ár:', history.maxPrice),
                  buildHistoryElements('Vezető neve:', history.driverName),
                  buildHistoryElements(
                      'Állatok szállítása:', history.canTransportPets),
                  buildHistoryElements(
                      'Bicikli szállítása:', history.canTransportBicycle),
                  buildHistoryElements('Autópálya:', history.isGoingHighway),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
