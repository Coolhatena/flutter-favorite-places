import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends StatelessWidget {
  AddPlaceScreen({super.key});
  final _nameController = TextEditingController();

  void _submitPlace(BuildContext context) {
    final enteredName = _nameController.text.trim();

    if (enteredName.isEmpty || enteredName.length > 50) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid name')),
      );
      return;
    }

    final container = ProviderScope.containerOf(context);
    final newPlace = Place(name: enteredName);

    container.read(placesProvider.notifier).addPlace(newPlace);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Place added!')),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add new place"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    maxLength: 50,
                    decoration:
                        const InputDecoration(label: Text('Place name')),
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _submitPlace(context);
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Place"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
