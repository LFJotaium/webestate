// profile_authenticated_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webestate/profile/widgets/saved_estate_section.dart';

import '../../../../../data/models/user_model.dart';
import '../../../../../data/repositories/user_repository.dart' show userProvider;
import 'profile_header.dart';
import 'section_title.dart';
import 'info_card.dart';
import 'action_button.dart';
import 'UserListedEstatesSection.dart';

class ProfileAuthenticatedView extends ConsumerWidget {
  final UserModel user;

  const ProfileAuthenticatedView({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          ProfileHeader(user: user),
          const SizedBox(height: 32),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: isDesktop ? 40.0 : 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SectionTitle(title: 'المعلومات الشخصية'),
                const SizedBox(height: 12),
                InfoCard(
                  icon: Icons.person_outline,
                  items: [
                    _buildInfoItem('الاسم الكامل', user.fullName),
                    _buildInfoItem('البريد الإلكتروني', user.email),
                    _buildInfoItem(
                        'رقم الهاتف',
                        user.phone.isNotEmpty ? user.phone : 'غير متوفر'),
                  ],
                ),
                const SizedBox(height: 32),
                if (user.listingIds.isNotEmpty && user.listingIds.first.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SectionTitle(title: 'ممتلكاتي'),
                      const SizedBox(height: 12),
                      UserListedEstatesSection(userId: user.userId),
                      const SizedBox(height: 32),
                    ],
                  ),
                if (user.savedEstateIds.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SectionTitle(title: 'العقارات المحفوظة'),
                      const SizedBox(height: 12),
                      SavedEstatesSection(userId: user.userId),
                      const SizedBox(height: 32),
                    ],
                  ),
                const SectionTitle(title: 'الإجراءات'),
                const SizedBox(height: 12),
                ActionButton(
                  text: 'تعديل الملف الشخصي',
                  icon: Icons.edit_outlined,
                  onPressed: () => context.push('/profile/edit'),
                ),
                ActionButton(
                  text: 'تسجيل الخروج',
                  icon: Icons.logout,
                  onPressed: () => _showLogoutDialog(context, ref),
                  isDestructive: true,
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Divider(height: 24),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'تسجيل الخروج',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        content: Text(
          'هل أنت متأكد أنك تريد تسجيل الخروج؟',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'إلغاء',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
              ref.read(userProvider.notifier).signOut();
            },
            child: Text(
              'تسجيل الخروج',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ],
        actionsAlignment: isDesktop ? MainAxisAlignment.end : MainAxisAlignment.center,
        actionsPadding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 24 : 16,
          vertical: 16,
        ),
      ),
    );
  }
}