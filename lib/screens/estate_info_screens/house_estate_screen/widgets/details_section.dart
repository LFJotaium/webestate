import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../data/models/estate_models/house_model.dart';
import 'shared/detail_item.dart';

class DetailsSection extends StatelessWidget {
  final House house;

  const DetailsSection({super.key, required this.house});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth <
        600; // You can adjust the size threshold for small screens
    final isWeb = MediaQuery.of(context).size.width > 600;

    // Dynamic padding and font sizes based on screen width
    final textStyle = GoogleFonts.cairo(
      fontSize: isSmallScreen ? 16 : 18, // Smaller text on smaller screens
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.onBackground,
    );

    return FadeInUp(
      delay: 250.ms,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تفاصيل العقار",
            style: textStyle,
          ),
          SizedBox(
              height:
                  isSmallScreen ? 8 : 12), // Adjusted space for small screens
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: isWeb ? 3 : 2,
            childAspectRatio: isWeb ? 4 : 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            padding: EdgeInsets.zero,
            children: [
              DetailItem(
                  icon: Iconsax.calendar,
                  label: "تاريخ الإضافة",
                  value: _formatDate(house.listedAt)),
              DetailItem(
                  icon: Iconsax.buildings,
                  label: "عدد الطوابق",
                  value: house.totalFloors.toString()),
              DetailItem(
                  icon: Iconsax.document,
                  label: "حالة العقار",
                  value: house.available ? "متاح" : "غير متاح"),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String getType(String type) {
    if (type == "Rent") {
      return "ايجار";
    }
    if (type == "Sell") {
      return "بيع";
    }
    return "غير معروف";
  }
}
