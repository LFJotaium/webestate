// user_listed_estates_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../data/models/estate_models/abstract_estate_model.dart';
import '../../data/application/user_listed_estates_provider.dart' show userListedEstatesProvider;
import 'estate_card.dart';
import 'estate_carousel.dart';

class UserListedEstatesSection extends ConsumerStatefulWidget {
  final String userId;

  const UserListedEstatesSection({required this.userId, Key? key})
      : super(key: key);

  @override
  ConsumerState<UserListedEstatesSection> createState() =>
      _UserListedEstatesSectionState();
}

class _UserListedEstatesSectionState
    extends ConsumerState<UserListedEstatesSection>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userListedEstatesProvider.notifier).loadEstates(widget.userId);
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
    final estatesAsync = ref.watch(userListedEstatesProvider);
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return estatesAsync.when(
      loading: () => _buildLoadingIndicator(theme),
      error: (error, stack) => _buildErrorWidget(context, error),
      data: (estates) {
        if (estates.isEmpty) {
          return _buildEmptyState(context);
        }

        final groupedEstates = _groupEstatesByType(estates);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: theme.colorScheme.primary,
                unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.6),
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.colorScheme.primary.withOpacity(0.1),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                labelStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: theme.textTheme.labelLarge,
                tabs: const [
                  Tab(text: 'شقة'),
                  Tab(text: 'فيلا'),
                  Tab(text: 'منزل'),
                  Tab(text: 'أرض'),
                ],
              ),
            ),
            SizedBox(
              height: isDesktop ? 410 : 350,
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

  Widget _buildLoadingIndicator(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, dynamic error) {
    return Center(
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
            'حدث خطأ في تحميل البيانات',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            error.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => ref
                .read(userListedEstatesProvider.notifier)
                .loadEstates(widget.userId),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.errorContainer,
              foregroundColor: Theme.of(context).colorScheme.onErrorContainer,
              minimumSize: const Size(150, 48),
            ),
            child: const Text('حاول مرة أخرى'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.house_outlined,
          size: 64,
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
        ),
        const SizedBox(height: 16),
        Text(
          'لا يوجد عقارات مسجلة',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: isDesktop ? 400 : null,
          child: Text(
            'يمكنك إضافة عقار جديد من خلال الزر الموجود في الأسفل',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
            ),
          ),
        ),
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () => context.push('/add_estate'),
          style: FilledButton.styleFrom(
            minimumSize: Size(isDesktop ? 200 : 150, 48),
          ),
          child: const Text('إضافة عقار جديد'),
        ),
      ],
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
              Icons.house_outlined,
              size: 48,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
            ),
            const SizedBox(height: 16),
            Text(
              'لا يوجد لديك ممتلك من هذا النوع',
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
            vertical: 8.0,
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
