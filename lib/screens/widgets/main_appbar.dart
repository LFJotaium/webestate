import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../l10n/generated/app_localizations.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);

    final isDesktop = screenWidth >= 900;
    final isTablet = screenWidth >= 600 && screenWidth < 900;

    double basePadding = isDesktop ? 32 : (isTablet ? 24 : 16);
    double avatarRadius = isDesktop ? 28 : (isTablet ? 24 : 22);
    double iconSize = isDesktop ? 28 : (isTablet ? 24 : 22);
    double titleFontSize = isDesktop ? 24 : (isTablet ? 20 : 18);
    double subtitleFontSize = isDesktop ? 20 : (isTablet ? 18 : 16);
    double appBarHeight = isDesktop ? 120 : (isTablet ? 100 : 90);

    return SliverAppBar(
      pinned: true,
      floating: false,
      expandedHeight: appBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue.shade900,
                Colors.indigo.shade800,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Decorative circles
              Positioned(
                top: -screenHeight * 0.05,
                right: -screenWidth * 0.1,
                child: Container(
                  width: screenWidth * 0.25,
                  height: screenWidth * 0.25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.04),
                  ),
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.05,
                left: -screenWidth * 0.2,
                child: Container(
                  width: screenWidth * 0.3,
                  height: screenWidth * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.03),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + basePadding,
                  left: basePadding,
                  right: basePadding,
                  bottom: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Greetings
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "السلام عليكم",
                              style: GoogleFonts.tajawal(
                                fontSize: titleFontSize,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "ورحمة الله وبركاته",
                              style: GoogleFonts.tajawal(
                                fontSize: subtitleFontSize,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.85),
                              ),
                            ),
                          ],
                        ),

                        // Buttons
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: avatarRadius,
                              child: IconButton(
                                icon: Icon(Icons.add,
                                    color: Colors.blue.shade800,
                                    size: iconSize),
                                onPressed: () {
                                  if (FirebaseAuth.instance.currentUser != null) {
                                    context.push('/choose_screen');
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("لم تسجل دخولك لحسابك, يجب ان تسجل دخولك اولا."),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                    const Spacer(),

                    // Tiny white line
                    Container(
                      height: 2,
                      width: screenWidth * 0.25,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.6),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
