import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourPlacesScreen extends ConsumerWidget {
  const YourPlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final yourPlaces = ref.watch(placesProvider);

    Widget content = yourPlaces.isEmpty
        ? const Center(
            child: Text(
              "No places added yet.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: yourPlaces.length,
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(
                  radius: 26,
                  backgroundImage: FileImage(yourPlaces[index].image),
                ),
                title: Text(yourPlaces[index].name),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PlaceDetails(
                        place: yourPlaces[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          );

    void addPlace() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddPlaceScreen(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Places"),
        actions: [
          IconButton(
            onPressed: addPlace,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: content,
    );
  }
}
