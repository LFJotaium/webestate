import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../../../core/limited_cache_manager.dart';
import '../../../../../data/models/estate_models/abstract_estate_model.dart';
import '../../../../../data/models/estate_models/apartment_model.dart';
import '../../core/citysearch_service.dart';
import '../../core/firebase_service/firebase_service.dart';
import '../../data/repositories/estate_repository.dart';
import '../../l10n/generated/app_localizations.dart';
import 'feature_chip.dart';

class ProfileEstateCard extends StatelessWidget {
  final Estate estate;
  final int index;

  const ProfileEstateCard({Key? key, required this.estate, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final type = estate.type;
    final estateImages = estate.images;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            context.push('/estate_$type', extra: estate);
          },
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 380, // Maximum height for the card
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageSection(context, estateImages),
                Expanded(
                  child: _buildInfoSection(context, estate, type, localization),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTypeLabel(String type, AppLocalizations localization) {
    switch (type) {
      case 'apartment':
        return "شقة";
      case 'villa':
        return "فيلا";
      case 'house':
        return "منزل";
      case 'land':
        return "أرض";
      default:
        return type;
    }
  }

  Widget _buildImageSection(BuildContext context, List<String> images) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: images.isNotEmpty
          ? CachedNetworkImage(
        imageUrl: images[0],
        cacheManager: ImageCacheManager(),
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[200],
          child: Center(
            child: Icon(
              Icons.image_not_supported,
              color: Colors.grey[400],
            ),
          ),
        ),
      )
          : Container(
        color: Colors.grey[200],
        child: Center(
          child: Icon(
            Icons.image_not_supported,
            color: Colors.grey[400],
            size: 48,
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, Estate estate, String type,
      AppLocalizations localization) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            estate.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Text(
            "${localization.buy_promoted_price}: ${EstateRepository().formatNumber(estate.price.toInt())} ₪",
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (type != "land" && estate is Apartment)
                FeatureChip(
                  icon: Icons.king_bed,
                  label: '${(estate).totalRooms} غرف',
                ),
              if (type != "land" && estate is Apartment)
                FeatureChip(
                  icon: Icons.bathtub,
                  label: '${(estate).totalBathrooms} حمامات',
                ),
              FeatureChip(
                icon: Icons.aspect_ratio,
                label: '${estate.area} متر مربع',
              ),
              FeatureChip(
                icon: Icons.location_on,
                label: CityService().getLocalizedCity(
                    estate.city,
                    Localizations.localeOf(context).languageCode),
                color: Colors.blueAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}