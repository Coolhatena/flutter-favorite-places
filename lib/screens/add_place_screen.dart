import 'dart:io';

import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _nameController = TextEditingController();

  File? _selectedImage;

  void _submitPlace(BuildContext context) {
    final enteredName = _nameController.text.trim();

    if (enteredName.isEmpty || enteredName.length > 50) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid name')),
      );
      return;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image.')),
      );
      return;
    }

    final container = ProviderScope.containerOf(context);
    final newPlace = Place(name: enteredName, image: _selectedImage!);

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
                  const SizedBox(height: 10),
                  ImageInput(
                    onPickImage: (image) {
                      _selectedImage = image;
                    },
                  ),
                  const SizedBox(height: 16),
                  LocationInput(),
                  const SizedBox(height: 16),
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
