import 'package:collabcar/models/histories.dart';
import 'package:collabcar/providers/history_provider.dart';
import 'package:collabcar/widgets/history_widgets/history_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<HistoryProvider>(context).getFromDevice(),
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
                  (snapshot.data as Histories).searches.isEmpty) {
                return const Center(
                  child: Text('Nincsenek keresési előzményeid.'),
                );
              } else {
                return Consumer<HistoryProvider>(
                  builder: (context, value, child) => ListView.builder(
                    itemBuilder: (BuildContext context, int index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            HistoryTile(
                              history: value.histories.searches[index],
                              provider: value,
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: value.histories.searches.length,
                  ),
                );
              }
            }
          }
        });
  }
}
