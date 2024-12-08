import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourPlacesScreen extends ConsumerStatefulWidget {
  const YourPlacesScreen({super.key});

  @override
  ConsumerState<YourPlacesScreen> createState() {
    return _YourPlacesScreenState();
  }
}

class _YourPlacesScreenState extends ConsumerState<YourPlacesScreen> {
  late Future<void> _placesFuture;

  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(placesProvider.notifier).loadPlaces();
  }

  void addPlace() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const AddPlaceScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
            child: FutureBuilder(
              future: _placesFuture,
              builder: (context, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      itemCount: yourPlaces.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(
                          radius: 26,
                          backgroundImage: FileImage(yourPlaces[index].image),
                        ),
                        title: Text(
                          yourPlaces[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
                        subtitle: Text(
                          yourPlaces[index].location.address,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                        ),
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
            ),
          );

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
