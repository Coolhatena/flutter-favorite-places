import 'package:favorite_places/models/envs.dart';
import 'package:favorite_places/models/place.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatefulWidget {
  const PlaceDetails({super.key, required this.place});
  final Place place;

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails> {
  String? apiKey;

  @override
  void initState() {
    super.initState();
    getLocationImageUrl();
  }

  void getLocationImageUrl() async {
    final envs = await Envs.getEnvs();
    setState(() {
      apiKey = envs['google_maps_api_key'];
    });
  }

  String get locationImageUrl {
    final lat = widget.place.location.latitude;
    final lng = widget.place.location.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=$apiKey';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name),
      ),
      body: Stack(
        children: [
          Image.file(
            widget.place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundImage:
                        apiKey != null ? NetworkImage(locationImageUrl) : null,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(
                      widget.place.location.address,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
