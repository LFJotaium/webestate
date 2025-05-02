import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:latlong2/latlong.dart' as latlong;

import '../../../../core/citysearch_service.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'location_picker.dart';

class LocationStep extends StatefulWidget {
  final Animation<double> fadeAnimation;
  final TextEditingController cityController;
  final TextEditingController locationDescController;
  final TextEditingController phoneController;
  final latlong.LatLng? initialLocation;
  final Function(latlong.LatLng)? onLocationChanged;

  const LocationStep({
    required this.fadeAnimation,
    required this.cityController,
    required this.locationDescController,
    required this.phoneController,
    this.initialLocation,
    this.onLocationChanged,
  });

  @override
  _LocationStepState createState() => _LocationStepState();
}

class _LocationStepState extends State<LocationStep> {
  latlong.LatLng? _location;

  @override
  void initState() {
    super.initState();
    _location = widget.initialLocation;
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context).add_apartment_location,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: widget.cityController.text.isEmpty ? null : widget.cityController.text,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).add_apartment_city,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.location_city),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
              items: cities.map<DropdownMenuItem<String>>((city) {
                String cityValue = Localizations.localeOf(context).languageCode == 'ar'
                    ? city['arabic']!
                    : city['hebrew']!;
                String englishCityValue = city['english']!;

                return DropdownMenuItem<String>(
                  value: englishCityValue,
                  child: Text(
                    cityValue,
                    style: TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  widget.cityController.text = value;
                }
              },
            ).animate().slideX(begin: 0.1, end: 0),
            SizedBox(height: 16),
            TextFormField(
              controller: widget.locationDescController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).add_apartment_addressDesc,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.location_on),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              maxLines: 2,
              textDirection: AppLocalizations.of(context).localeName == 'ar' ||
                  AppLocalizations.of(context).localeName == 'he'
                  ? TextDirection.rtl : TextDirection.ltr,
            ).animate().slideX(begin: 0.1, end: 0),
            SizedBox(height: 16),
            TextFormField(
              controller: widget.phoneController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context).add_apartment_phone,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: Icon(Icons.phone),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              keyboardType: TextInputType.phone,
              textDirection: AppLocalizations.of(context).localeName == 'ar' ||
                  AppLocalizations.of(context).localeName == 'he'
                  ? TextDirection.rtl : TextDirection.ltr,
            ).animate().slideX(begin: 0.1, end: 0),
            SizedBox(height: 16),
            Container(
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    flutter_map.FlutterMap(
                      options: flutter_map.MapOptions(
                        initialCenter: _location ?? const latlong.LatLng(32.51712600, 35.14853100),
                        initialZoom: 8.0,
                        onTap: (_, latLng) {
                          setState(() {
                            _location = latLng;
                            widget.onLocationChanged?.call(latLng);
                          });
                        },
                        interactionOptions: const flutter_map.InteractionOptions(
                          flags: flutter_map.InteractiveFlag.all &
                          ~flutter_map.InteractiveFlag.rotate,
                        ),
                      ),
                      children: [
                        flutter_map.TileLayer(
                          urlTemplate: 'http://mt0.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                          subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                          userAgentPackageName: 'com.example.app',
                        ),
                        if (_location != null)
                          flutter_map.MarkerLayer(
                            markers: [
                              flutter_map.Marker(
                                width: 40,
                                height: 40,
                                point: _location!,
                                child: Icon(Icons.location_pin,
                                    color: Colors.red, size: 40),
                              ),
                            ],
                          ),
                      ],
                    ),
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: FloatingActionButton(
                        heroTag: 'open_full_map',
                        onPressed: () async {
                          final position = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LocationPickerScreen(
                                initialPosition: _location,
                              ),
                            ),
                          );
                          if (position != null) {
                            setState(() {
                              _location = position;
                              widget.onLocationChanged?.call(position);
                            });
                          }
                        },
                        child: Icon(Icons.fullscreen),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().slideX(delay: 200.ms, begin: 0.1, end: 0),
            if (_location != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Lat: ${_location!.latitude.toStringAsFixed(4)}, '
                      'Lng: ${_location!.longitude.toStringAsFixed(4)}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}