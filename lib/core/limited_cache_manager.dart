import 'dart:html';  // For browser storage (web)
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageCacheManager extends CacheManager {
  static const key = "imageCache";
  static final ImageCacheManager _instance = ImageCacheManager._internal();

  factory ImageCacheManager() => _instance;

  ImageCacheManager._internal() : super(Config(key));

  // For web, use IndexedDB or localStorage (for metadata) to store cache.
  Future<void> nukeImageCaches() async {
    // Empty the Flutter Cache Manager cache
    await emptyCache();

    // Clear the in-memory image cache in Flutter
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();

    try {
      await DefaultCacheManager().emptyCache();
    } catch (_) {
      debugPrint("Error clearing Flutter Cache Manager cache.");
    }

    // For web, clear IndexedDB cache or other browser-based caches if needed
    try {
      // Clear IndexedDB or related storage to remove large assets.
      window.localStorage.remove(key); // This removes your specific cache key from localStorage
    } catch (_) {
      debugPrint("Error clearing localStorage cache.");
    }
  }

  // Apply cache aging policy for web
  Future<void> applyCacheAgingPolicy({
    Duration maxAge = const Duration(days: 1),
    int maxItems = 15,
  }) async {
    // Here, we manage cache using localStorage or IndexedDB.
    // localStorage can be used for metadata or small items,
    // and IndexedDB is ideal for images or larger assets.

    try {
      final cacheInfo = window.localStorage[key]; // Fetch cached data info
      if (cacheInfo != null) {
        // Track cache timestamp for better cache expiry handling
        final cacheTimestamp = int.tryParse(cacheInfo);

        // Expire cache items older than `maxAge`
        if (cacheTimestamp != null &&
            DateTime.now().millisecondsSinceEpoch - cacheTimestamp > maxAge.inMilliseconds) {
          await nukeImageCaches();
          debugPrint("Cache expired, clearing images.");
        }
      }

      // Limit cache to `maxItems` to avoid bloating localStorage
      final cacheItems = await _getCacheItems();
      if (cacheItems.length > maxItems) {
        // Remove oldest cache items or clear cache based on your policy.
        final itemsToRemove = cacheItems.sublist(0, cacheItems.length - maxItems);
        for (var item in itemsToRemove) {
          await _removeItemFromCache(item);
        }
        debugPrint("Exceeded maxItems, removed oldest cache items.");
      }
    } catch (e) {
      debugPrint('Error applying cache aging policy: $e');
    }

    debugPrint('Cache policy applied');
  }

  // Helper function to retrieve cache items
  Future<List<String>> _getCacheItems() async {
    try {
      // For demo, we'll get all items from localStorage, but for a larger app,
      // IndexedDB would be the best choice for performance.
      return window.localStorage.keys.toList();
    } catch (e) {
      debugPrint('Error getting cache items: $e');
      return [];
    }
  }

  // Helper function to remove a single item from cache
  Future<void> _removeItemFromCache(String key) async {
    try {
      window.localStorage.remove(key);
      debugPrint("Removed item from cache: $key");
    } catch (e) {
      debugPrint('Error removing item from cache: $e');
    }
  }
}
