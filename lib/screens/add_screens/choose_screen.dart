import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ChooseScreen extends StatelessWidget {
  const ChooseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        leading:
            IconButton(onPressed: () {
              context.pop();
            }, icon: Icon(Icons.arrow_back_outlined,size: size.height * 0.03,)),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              Text(
                'قم باضافة عقارك!',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: size.height * 0.035,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'اختر نوع العقار التي تريد نشره',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: size.height * 0.018,
                    ),
              ),
              const SizedBox(height: 40),

              // Property Type Grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: size.width > 600 ? 4 : 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.1,
                  children: [
                    _PropertyTypeCard(
                      icon: Iconsax.home,
                      title: 'منزل',
                      color: Colors.blue,
                      onTap: () => context.push('/add_house'),
                    ),
                    _PropertyTypeCard(
                      icon: Iconsax.building,
                      title: 'شقة',
                      color: Colors.purple,
                      onTap: () => context.push('/add_apartment'),
                    ),
                    _PropertyTypeCard(
                      icon: Iconsax.courthouse,
                      title: 'فيلا',
                      color: Colors.orange,
                      onTap: () => context.push('/add_villa'),
                    ),
                    _PropertyTypeCard(
                      icon: Iconsax.tree,
                      title: 'أرض',
                      color: Colors.green,
                      onTap: () => context.push('/add_land'),
                    ),
             //       _PropertyTypeCard(
               //       icon: Iconsax.flag,
                ///      title: 'تجارية',
                //      color: Colors.red,
                 //     onTap: () => context.push('/add_commercial'),
               //     ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _PropertyTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;

  const _PropertyTypeCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 30,
                color: color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.indigo[900],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'اضغط للتسجيل',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: size.height * 0.014,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
