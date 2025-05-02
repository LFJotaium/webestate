

import 'package:intl/intl.dart';

import '../../l10n/generated/app_localizations.dart';
import '../models/enums/estate_enums.dart';
import '../../core/auth_service/fiirebase_auth_service.dart';
import '../../core/firebase_service/firebase_service.dart';

class EstateRepository{

  String getTypeENUM(EstateType type, AppLocalizations l10n) {
    switch (type) {
      case EstateType.apartment:
        return l10n.filterScreenApartment;
      case EstateType.villa:
        return l10n.filterScreenVilla;
      case EstateType.house:
        return l10n.filterScreenHouse;
      case EstateType.land:
        return l10n.filterScreenLand;
      }
  }
  String getForENUM(String type, AppLocalizations l10n) {
    type = type.toLowerCase();
    switch (type) {
      case "rent":
        return l10n.main_tabs_rent;
      case "sell":
        return l10n.main_tabs_buy;
    }
    return "??";
  }




  String formatNumber(int number) {
    if (number < 1000) {
      return number.toString();
    }

    // For numbers 1000 and greater, format with commas
    return NumberFormat("#,##0").format(number);
  }


  String getTypeString(String type, AppLocalizations l10n) {

    switch (type) {
      case "apartment":
        return l10n.filterScreenApartment;
      case "villa":
        return l10n.filterScreenVilla;
      case "house":
        return l10n.filterScreenHouse;
      case "land":
        return l10n.filterScreenLand;
    }
    return "??";
  }




}