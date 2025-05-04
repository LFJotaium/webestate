import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/location_service.dart';


class LocationPickerScreen extends StatefulWidget {
  final LatLng? initialPosition;

  const LocationPickerScreen({super.key, this.initialPosition});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late MapController _mapController;
  LatLng? _selectedPosition;

  @override
  void initState() {
    super.initState();
    _selectedPosition = widget.initialPosition;
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (_selectedPosition != null) {
                Navigator.pop(context, _selectedPosition);
              }
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedPosition ?? const LatLng(31.7683, 35.2137),
              initialZoom: 14.0,
              onTap: (_, latLng) {
                setState(() => _selectedPosition = latLng);
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                userAgentPackageName: 'com.example.app',
                subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                tileProvider: CancellableNetworkTileProvider(), // ✅ Add this
              ),
              if (_selectedPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40.0,
                      height: 40.0,
                      point: _selectedPosition!,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          if (_selectedPosition != null)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Lat: ${_selectedPosition!.latitude.toStringAsFixed(4)}, '
                        'Lng: ${_selectedPosition!.longitude.toStringAsFixed(4)}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
           Positioned(
            bottom: 80,
            right: 16,
            child: FloatingActionButton(
              mini: true,
              child: Icon(Icons.my_location),
              onPressed: LocationService().getCurrentLocation, // Implement this function
            ),
          ),
        ],
      ),
    );
  }
}