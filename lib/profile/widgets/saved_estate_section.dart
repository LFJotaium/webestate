// saved_estates_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../data/models/estate_models/abstract_estate_model.dart';
import '../../data/application/saved_estates_provider.dart';
import 'estate_card.dart';
import 'estate_carousel.dart';

class SavedEstatesSection extends ConsumerStatefulWidget {
  final String userId;

  const SavedEstatesSection({required this.userId, Key? key}) : super(key: key);

  @override
  ConsumerState<SavedEstatesSection> createState() => _SavedEstatesSectionState();
}

class _SavedEstatesSectionState extends ConsumerState<SavedEstatesSection>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(savedEstatesProvider.notifier).loadSavedEstates(widget.userId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Map<String, List<Estate>> _groupEstatesByType(List<dynamic> estates) {
    final grouped = <String, List<Estate>>{
      'apartment': [],
      'villa': [],
      'house': [],
      'land': [],
    };

    for (final estate in estates) {
      grouped[estate.type]?.add(estate);
    }

    grouped.forEach((key, value) {
      value.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    });

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final estatesAsync = ref.watch(savedEstatesProvider);
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return estatesAsync.when(
      loading: () => Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      error: (error, stack) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'لم يتم التعبئة بنجاح',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref
                  .read(savedEstatesProvider.notifier)
                  .loadSavedEstates(widget.userId),
              style: FilledButton.styleFrom(
                minimumSize: const Size(150, 48),
              ),
              child: const Text('حاول مجددا'),
            ),
          ],
        ),
      ),
      data: (estates) {
        if (estates.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.bookmark_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                ),
                const SizedBox(height: 16),
                Text(
                  'لا يوجد عقارات محفوظة',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          );
        }

        final groupedEstates = _groupEstatesByType(estates);

        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Theme.of(context).colorScheme.primary,
                unselectedLabelColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
                labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'شقة'),
                  Tab(text: 'فيلا'),
                  Tab(text: 'منزل'),
                  Tab(text: 'أرض'),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: isDesktop ? 380 : 320,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildEstateList(groupedEstates['apartment'] ?? [], context),
                  _buildEstateList(groupedEstates['villa'] ?? [], context),
                  _buildEstateList(groupedEstates['house'] ?? [], context),
                  _buildEstateList(groupedEstates['land'] ?? [], context),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildEstateList(List<Estate> estates, BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    if (estates.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.bookmark_outline,
              size: 48,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'لا يوجد لديك ممتلك محفوظ من هذا النوع',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),
      );
    }

    return ProfileEstateCarousel(
      estates: estates,
      itemBuilder: (context, estate, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 4.0 : 0,
          ),
          child: ProfileEstateCard(
            estate: estate,
            index: index,
          ),
        );
      },
    );
  }
}
