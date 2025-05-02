// location_section.dart
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webestate/data/models/estate_models/house_model.dart';


class LocationSection extends StatelessWidget {
  final House house;

  const LocationSection({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: FadeInUp(
          delay: 500.ms,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "الموقع",
                      style: GoogleFonts.cairo(
                        fontSize: isWeb ? 18 : 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _openMaps(house.latitude, house.longitude),
                      child: Text(
                        "فتح في الخريطة",
                        style: GoogleFonts.cairo(
                          color: theme.colorScheme.primary,
                          fontSize: isWeb ? 16 : 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: isWeb ? 300 : 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(house.latitude, house.longitude),
                      initialZoom: 10.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://mt1.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                        userAgentPackageName: 'com.example.app',
                        subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(house.latitude, house.longitude),
                            child: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      CircleLayer(
                        circles: [
                          CircleMarker(
                            point: LatLng(house.latitude, house.longitude),
                            radius: 200,
                            useRadiusInMeter: true,
                            color: theme.colorScheme.primary.withOpacity(0.2),
                            borderColor: theme.colorScheme.primary,
                            borderStrokeWidth: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  house.locationDescription,
                  style: GoogleFonts.cairo(
                    fontSize: isWeb ? 16 : 14,
                    color: theme.colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openMaps(double lat, double lng) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}