// profile_header.dart
import 'package:flutter/material.dart';
import 'package:webestate/profile/widgets/profile_constants.dart';

import '../../../../../data/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;

  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: isDesktop ? 120 : 80,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.primary.withOpacity(0.05),
                  ],
                ),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: CircleAvatar(
                radius: isDesktop ? 60 : 50,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  user.fullName.substring(0, 1).toUpperCase(),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Text(
          user.fullName,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

      ],
    );
  }

  Color _getAccountTypeColor(BuildContext context, String type) {
    switch (type) {
      case 'premium':
        return Theme.of(context).colorScheme.primary.withOpacity(0.2);
      case 'admin':
        return Theme.of(context).colorScheme.error.withOpacity(0.2);
      default:
        return Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5);
    }
  }

  Color _getAccountTypeTextColor(BuildContext context, String type) {
    switch (type) {
      case 'premium':
        return Theme.of(context).colorScheme.primary;
      case 'admin':
        return Theme.of(context).colorScheme.error;
      default:
        return Theme.of(context).colorScheme.onSurfaceVariant;
    }
  }
}