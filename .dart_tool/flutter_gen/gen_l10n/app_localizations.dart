import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_he.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('he')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Bayti'**
  String get appTitle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'Find your perfect property'**
  String get appTagline;

  /// No description provided for @estate_type_apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get estate_type_apartment;

  /// No description provided for @estate_type_villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get estate_type_villa;

  /// No description provided for @estate_type_house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get estate_type_house;

  /// No description provided for @estate_type_land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get estate_type_land;

  /// No description provided for @estate_for_sell.
  ///
  /// In en, this message translates to:
  /// **'For Sale'**
  String get estate_for_sell;

  /// No description provided for @estate_for_rent.
  ///
  /// In en, this message translates to:
  /// **'For Rent'**
  String get estate_for_rent;

  /// No description provided for @profileScreen_profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileScreen_profileTitle;

  /// No description provided for @profileScreen_notLoggedIn.
  ///
  /// In en, this message translates to:
  /// **'You are not logged in'**
  String get profileScreen_notLoggedIn;

  /// No description provided for @profileScreen_loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get profileScreen_loginButton;

  /// No description provided for @profileScreen_welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get profileScreen_welcomeMessage;

  /// No description provided for @profileScreen_emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get profileScreen_emailLabel;

  /// No description provided for @profileScreen_nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get profileScreen_nameLabel;

  /// No description provided for @profileScreen_signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get profileScreen_signOut;

  /// No description provided for @profileScreen_profilePhoto.
  ///
  /// In en, this message translates to:
  /// **'Profile Photo'**
  String get profileScreen_profilePhoto;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to your account'**
  String get loginTitle;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @emailError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailError;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @passwordError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordError;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get loginButton;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Log in with Google'**
  String get loginWithGoogle;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @signupNow.
  ///
  /// In en, this message translates to:
  /// **'Sign up now'**
  String get signupNow;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginNow.
  ///
  /// In en, this message translates to:
  /// **'Log in now'**
  String get loginNow;

  /// No description provided for @registration_firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get registration_firstName;

  /// No description provided for @registration_firstNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your first name'**
  String get registration_firstNameHint;

  /// No description provided for @registration_lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get registration_lastName;

  /// No description provided for @registration_lastNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your last name'**
  String get registration_lastNameHint;

  /// No description provided for @registration_phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get registration_phoneNumber;

  /// No description provided for @registration_phoneHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get registration_phoneHint;

  /// No description provided for @registration_emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get registration_emailLabel;

  /// No description provided for @registration_emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get registration_emailHint;

  /// No description provided for @registration_passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get registration_passwordLabel;

  /// No description provided for @registration_passwordHint.
  ///
  /// In en, this message translates to:
  /// **'••••••••'**
  String get registration_passwordHint;

  /// No description provided for @registration_registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registration_registerButton;

  /// No description provided for @registration_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip Registration'**
  String get registration_skip;

  /// No description provided for @registration_verifyInfo.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Information'**
  String get registration_verifyInfo;

  /// No description provided for @registration_verifyMessage.
  ///
  /// In en, this message translates to:
  /// **'Please review your details before proceeding'**
  String get registration_verifyMessage;

  /// No description provided for @validation_firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get validation_firstNameRequired;

  /// No description provided for @validation_lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get validation_lastNameRequired;

  /// No description provided for @validation_phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get validation_phoneRequired;

  /// No description provided for @validation_phoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get validation_phoneInvalid;

  /// No description provided for @validation_emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get validation_emailRequired;

  /// No description provided for @validation_emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get validation_emailInvalid;

  /// No description provided for @validation_passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get validation_passwordRequired;

  /// No description provided for @validation_passwordShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get validation_passwordShort;

  /// No description provided for @otp_sendFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to send OTP. Try again!'**
  String get otp_sendFailure;

  /// No description provided for @otp_phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get otp_phoneRequired;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @chooseLanguage.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Language'**
  String get chooseLanguage;

  /// No description provided for @chooseArea.
  ///
  /// In en, this message translates to:
  /// **'Where are you looking for estates?'**
  String get chooseArea;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @hebrew.
  ///
  /// In en, this message translates to:
  /// **'Hebrew'**
  String get hebrew;

  /// No description provided for @arabAreas.
  ///
  /// In en, this message translates to:
  /// **'Arab Areas'**
  String get arabAreas;

  /// No description provided for @jewishAreas.
  ///
  /// In en, this message translates to:
  /// **'Jewish Areas'**
  String get jewishAreas;

  /// No description provided for @mixedAreas.
  ///
  /// In en, this message translates to:
  /// **'Mixed Areas'**
  String get mixedAreas;

  /// No description provided for @selectBothOptions.
  ///
  /// In en, this message translates to:
  /// **'Please select both language and area type'**
  String get selectBothOptions;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @choose_language.
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get choose_language;

  /// No description provided for @custom_bottom_nav_bar_profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get custom_bottom_nav_bar_profile;

  /// No description provided for @custom_bottom_nav_bar_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get custom_bottom_nav_bar_home;

  /// No description provided for @custom_bottom_nav_bar_messages.
  ///
  /// In en, this message translates to:
  /// **'Messages'**
  String get custom_bottom_nav_bar_messages;

  /// No description provided for @custom_bottom_nav_bar_favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get custom_bottom_nav_bar_favorites;

  /// No description provided for @custom_bottom_nav_bar_search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get custom_bottom_nav_bar_search;

  /// No description provided for @main_tabs_buy.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get main_tabs_buy;

  /// No description provided for @main_tabs_rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get main_tabs_rent;

  /// No description provided for @promoted_section_title.
  ///
  /// In en, this message translates to:
  /// **'⭐ Promoted Estates'**
  String get promoted_section_title;

  /// No description provided for @most_viewed_section_title.
  ///
  /// In en, this message translates to:
  /// **'Most Viewed Estates 👀'**
  String get most_viewed_section_title;

  /// No description provided for @buy_promoted_section_title.
  ///
  /// In en, this message translates to:
  /// **'⭐ Promoted Properties for Sale'**
  String get buy_promoted_section_title;

  /// No description provided for @buy_promoted_apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get buy_promoted_apartment;

  /// No description provided for @buy_promoted_villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get buy_promoted_villa;

  /// No description provided for @buy_promoted_land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get buy_promoted_land;

  /// No description provided for @buy_promoted_house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get buy_promoted_house;

  /// No description provided for @buy_promoted_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get buy_promoted_price;

  /// No description provided for @buy_promoted_distance.
  ///
  /// In en, this message translates to:
  /// **'Distance: 1.5 km'**
  String get buy_promoted_distance;

  /// No description provided for @buy_promoted_view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get buy_promoted_view_details;

  /// No description provided for @category_boxes_rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get category_boxes_rent;

  /// No description provided for @category_boxes_villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get category_boxes_villa;

  /// No description provided for @category_boxes_apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get category_boxes_apartment;

  /// No description provided for @category_boxes_land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get category_boxes_land;

  /// No description provided for @category_boxes_units.
  ///
  /// In en, this message translates to:
  /// **'units'**
  String get category_boxes_units;

  /// No description provided for @home_appbar_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, Guest'**
  String get home_appbar_welcome;

  /// No description provided for @home_appbar_location_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown, Unknown'**
  String get home_appbar_location_unknown;

  /// No description provided for @home_appbar_notifications.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get home_appbar_notifications;

  /// No description provided for @buy_nearby_title.
  ///
  /// In en, this message translates to:
  /// **'🏠 Properties for Sale Nearby'**
  String get buy_nearby_title;

  /// No description provided for @buy_nearby_tab1.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get buy_nearby_tab1;

  /// No description provided for @buy_nearby_tab2.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get buy_nearby_tab2;

  /// No description provided for @buy_nearby_tab3.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get buy_nearby_tab3;

  /// No description provided for @buy_nearby_tab4.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get buy_nearby_tab4;

  /// No description provided for @buy_nearby_price.
  ///
  /// In en, this message translates to:
  /// **'Price:'**
  String get buy_nearby_price;

  /// No description provided for @buy_nearby_distance.
  ///
  /// In en, this message translates to:
  /// **'Distance: 1.5 km'**
  String get buy_nearby_distance;

  /// No description provided for @buy_nearby_view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get buy_nearby_view_details;

  /// No description provided for @buy_nearby_radius_text.
  ///
  /// In en, this message translates to:
  /// **'Radius'**
  String get buy_nearby_radius_text;

  /// No description provided for @buy_recent_viewed_section_title.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed Properties'**
  String get buy_recent_viewed_section_title;

  /// No description provided for @buy_recent_viewed_tab_apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get buy_recent_viewed_tab_apartment;

  /// No description provided for @buy_recent_viewed_tab_villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get buy_recent_viewed_tab_villa;

  /// No description provided for @buy_recent_viewed_tab_land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get buy_recent_viewed_tab_land;

  /// No description provided for @buy_recent_viewed_tab_house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get buy_recent_viewed_tab_house;

  /// No description provided for @buy_recent_viewed_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get buy_recent_viewed_price;

  /// No description provided for @buy_recent_viewed_viewed_since.
  ///
  /// In en, this message translates to:
  /// **'Viewed 2 days ago'**
  String get buy_recent_viewed_viewed_since;

  /// No description provided for @buy_recent_viewed_view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get buy_recent_viewed_view_details;

  /// No description provided for @rent_nearby_section_title.
  ///
  /// In en, this message translates to:
  /// **'🏡 Properties for Rent Nearby'**
  String get rent_nearby_section_title;

  /// No description provided for @rent_nearby_tab_apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get rent_nearby_tab_apartment;

  /// No description provided for @rent_nearby_tab_villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get rent_nearby_tab_villa;

  /// No description provided for @rent_nearby_tab_land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get rent_nearby_tab_land;

  /// No description provided for @rent_nearby_tab_house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get rent_nearby_tab_house;

  /// No description provided for @rent_nearby_price.
  ///
  /// In en, this message translates to:
  /// **'Price: {price} {currency}'**
  String rent_nearby_price(Object currency, Object price);

  /// No description provided for @rent_nearby_distance.
  ///
  /// In en, this message translates to:
  /// **'Distance: 1.5 km'**
  String get rent_nearby_distance;

  /// No description provided for @rent_nearby_view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get rent_nearby_view_details;

  /// No description provided for @rent_nearby_could_not_find.
  ///
  /// In en, this message translates to:
  /// **'No nearby listings found'**
  String get rent_nearby_could_not_find;

  /// No description provided for @rent_nearby_radius_text.
  ///
  /// In en, this message translates to:
  /// **'Radius'**
  String get rent_nearby_radius_text;

  /// No description provided for @rent_promoted_section_title.
  ///
  /// In en, this message translates to:
  /// **'🏡 Promoted Rental Properties'**
  String get rent_promoted_section_title;

  /// No description provided for @rent_promoted_tab_apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get rent_promoted_tab_apartment;

  /// No description provided for @rent_promoted_tab_villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get rent_promoted_tab_villa;

  /// No description provided for @rent_promoted_tab_land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get rent_promoted_tab_land;

  /// No description provided for @rent_promoted_tab_house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get rent_promoted_tab_house;

  /// No description provided for @rent_promoted_card_title.
  ///
  /// In en, this message translates to:
  /// **'Apartment for Rent'**
  String get rent_promoted_card_title;

  /// No description provided for @rent_promoted_card_price.
  ///
  /// In en, this message translates to:
  /// **'Price: 3,000 Shekels per month'**
  String get rent_promoted_card_price;

  /// No description provided for @rent_promoted_card_area.
  ///
  /// In en, this message translates to:
  /// **'Area: 120 m²'**
  String get rent_promoted_card_area;

  /// No description provided for @rent_promoted_card_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get rent_promoted_card_details;

  /// No description provided for @rent_recent_section_title.
  ///
  /// In en, this message translates to:
  /// **'Recently Viewed Properties'**
  String get rent_recent_section_title;

  /// No description provided for @rent_recent_tab_apartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get rent_recent_tab_apartment;

  /// No description provided for @rent_recent_tab_villa.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get rent_recent_tab_villa;

  /// No description provided for @rent_recent_tab_land.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get rent_recent_tab_land;

  /// No description provided for @rent_recent_tab_house.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get rent_recent_tab_house;

  /// No description provided for @rent_recent_card_title.
  ///
  /// In en, this message translates to:
  /// **'Viewed Property'**
  String get rent_recent_card_title;

  /// No description provided for @rent_recent_card_price.
  ///
  /// In en, this message translates to:
  /// **'Price:'**
  String get rent_recent_card_price;

  /// No description provided for @rent_recent_card_viewed_time.
  ///
  /// In en, this message translates to:
  /// **'Viewed 2 days ago'**
  String get rent_recent_card_viewed_time;

  /// No description provided for @rent_recent_card_details_button.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get rent_recent_card_details_button;

  /// No description provided for @city_search_hint.
  ///
  /// In en, this message translates to:
  /// **'Search for a city...'**
  String get city_search_hint;

  /// No description provided for @city_search_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while fetching data. Please try again.'**
  String get city_search_error;

  /// No description provided for @city_search_select.
  ///
  /// In en, this message translates to:
  /// **'Select a city'**
  String get city_search_select;

  /// No description provided for @customGfSearchBarSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search here...'**
  String get customGfSearchBarSearchHint;

  /// No description provided for @customGfSearchBarNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get customGfSearchBarNoResults;

  /// No description provided for @filterScreenReset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get filterScreenReset;

  /// No description provided for @filterScreenPriceRange.
  ///
  /// In en, this message translates to:
  /// **'Price Range'**
  String get filterScreenPriceRange;

  /// No description provided for @filterScreenBasicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get filterScreenBasicInfo;

  /// No description provided for @filterScreenRooms.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get filterScreenRooms;

  /// No description provided for @filterScreenBathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms'**
  String get filterScreenBathrooms;

  /// No description provided for @filterScreenKitchens.
  ///
  /// In en, this message translates to:
  /// **'Kitchens'**
  String get filterScreenKitchens;

  /// No description provided for @filterScreenFloor.
  ///
  /// In en, this message translates to:
  /// **'Floor'**
  String get filterScreenFloor;

  /// No description provided for @filterScreenArea.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get filterScreenArea;

  /// No description provided for @filterScreenAreaUnit.
  ///
  /// In en, this message translates to:
  /// **'m²'**
  String get filterScreenAreaUnit;

  /// No description provided for @filterScreenDistance.
  ///
  /// In en, this message translates to:
  /// **'Distance from Center'**
  String get filterScreenDistance;

  /// No description provided for @filterScreenDistanceUnit.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get filterScreenDistanceUnit;

  /// No description provided for @filterScreenLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get filterScreenLocation;

  /// No description provided for @filterScreenCity.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get filterScreenCity;

  /// No description provided for @filterScreenCountry.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get filterScreenCountry;

  /// No description provided for @filterScreenAmenities.
  ///
  /// In en, this message translates to:
  /// **'Amenities'**
  String get filterScreenAmenities;

  /// No description provided for @filterScreenApplyFilters.
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get filterScreenApplyFilters;

  /// No description provided for @filterScreenTransport.
  ///
  /// In en, this message translates to:
  /// **'Public Transport'**
  String get filterScreenTransport;

  /// No description provided for @filterScreenFeatures.
  ///
  /// In en, this message translates to:
  /// **'Special Features'**
  String get filterScreenFeatures;

  /// No description provided for @filterScreenBalcony.
  ///
  /// In en, this message translates to:
  /// **'Balcony'**
  String get filterScreenBalcony;

  /// No description provided for @filterScreenParking.
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get filterScreenParking;

  /// No description provided for @filterScreenElevator.
  ///
  /// In en, this message translates to:
  /// **'Elevator'**
  String get filterScreenElevator;

  /// No description provided for @filterScreenStorage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get filterScreenStorage;

  /// No description provided for @filterScreenAirConditioning.
  ///
  /// In en, this message translates to:
  /// **'Air Conditioning'**
  String get filterScreenAirConditioning;

  /// No description provided for @filterScreenPool.
  ///
  /// In en, this message translates to:
  /// **'Pool'**
  String get filterScreenPool;

  /// No description provided for @filterScreenFurnished.
  ///
  /// In en, this message translates to:
  /// **'Furnished'**
  String get filterScreenFurnished;

  /// No description provided for @filterScreenUtilitiesIncluded.
  ///
  /// In en, this message translates to:
  /// **'Utilities Included'**
  String get filterScreenUtilitiesIncluded;

  /// No description provided for @filterScreenEstateType.
  ///
  /// In en, this message translates to:
  /// **'Estate Type'**
  String get filterScreenEstateType;

  /// No description provided for @filterScreenApartment.
  ///
  /// In en, this message translates to:
  /// **'Apartment'**
  String get filterScreenApartment;

  /// No description provided for @filterScreenVilla.
  ///
  /// In en, this message translates to:
  /// **'Villa'**
  String get filterScreenVilla;

  /// No description provided for @filterScreenHouse.
  ///
  /// In en, this message translates to:
  /// **'House'**
  String get filterScreenHouse;

  /// No description provided for @filterScreenLand.
  ///
  /// In en, this message translates to:
  /// **'Land'**
  String get filterScreenLand;

  /// No description provided for @filterScreenMax.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get filterScreenMax;

  /// No description provided for @filterScreenMin.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get filterScreenMin;

  /// No description provided for @filterScreenListingType.
  ///
  /// In en, this message translates to:
  /// **'Rent or Sell'**
  String get filterScreenListingType;

  /// No description provided for @filterScreenAny.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterScreenAny;

  /// No description provided for @filterScreenOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'You can leave fields empty - they will count as \'Any\''**
  String get filterScreenOptionalHint;

  /// No description provided for @filterScreenBuildingDetails.
  ///
  /// In en, this message translates to:
  /// **'Building Specifications'**
  String get filterScreenBuildingDetails;

  /// No description provided for @filterScreenVillaSpecific.
  ///
  /// In en, this message translates to:
  /// **'Villa Features'**
  String get filterScreenVillaSpecific;

  /// No description provided for @filterScreenLandSpecific.
  ///
  /// In en, this message translates to:
  /// **'Land Details'**
  String get filterScreenLandSpecific;

  /// No description provided for @filter_results_title.
  ///
  /// In en, this message translates to:
  /// **'Filter Results'**
  String get filter_results_title;

  /// No description provided for @filter_results_found.
  ///
  /// In en, this message translates to:
  /// **'results found'**
  String get filter_results_found;

  /// No description provided for @filter_results_empty.
  ///
  /// In en, this message translates to:
  /// **'No results found matching your criteria'**
  String get filter_results_empty;

  /// No description provided for @estate_id.
  ///
  /// In en, this message translates to:
  /// **'Estate ID'**
  String get estate_id;

  /// No description provided for @estate_type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get estate_type;

  /// No description provided for @estate_listingType.
  ///
  /// In en, this message translates to:
  /// **'Listing Type'**
  String get estate_listingType;

  /// No description provided for @estate_title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get estate_title;

  /// No description provided for @estate_description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get estate_description;

  /// No description provided for @estate_ownerId.
  ///
  /// In en, this message translates to:
  /// **'Owner ID'**
  String get estate_ownerId;

  /// No description provided for @estate_ownerName.
  ///
  /// In en, this message translates to:
  /// **'Owner Name'**
  String get estate_ownerName;

  /// No description provided for @estate_ownerPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Owner Phone Number'**
  String get estate_ownerPhoneNumber;

  /// No description provided for @estate_price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get estate_price;

  /// No description provided for @estate_currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get estate_currency;

  /// No description provided for @estate_locationDescription.
  ///
  /// In en, this message translates to:
  /// **'Location Description'**
  String get estate_locationDescription;

  /// No description provided for @estate_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get estate_city;

  /// No description provided for @estate_country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get estate_country;

  /// No description provided for @estate_latitude.
  ///
  /// In en, this message translates to:
  /// **'Latitude'**
  String get estate_latitude;

  /// No description provided for @estate_longitude.
  ///
  /// In en, this message translates to:
  /// **'Longitude'**
  String get estate_longitude;

  /// No description provided for @estate_available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get estate_available;

  /// No description provided for @estate_images.
  ///
  /// In en, this message translates to:
  /// **'Images'**
  String get estate_images;

  /// No description provided for @estate_videoTourUrl.
  ///
  /// In en, this message translates to:
  /// **'Video Tour URL'**
  String get estate_videoTourUrl;

  /// No description provided for @estate_isPromoted.
  ///
  /// In en, this message translates to:
  /// **'Is Promoted'**
  String get estate_isPromoted;

  /// No description provided for @estate_promotionReference.
  ///
  /// In en, this message translates to:
  /// **'Promotion Reference'**
  String get estate_promotionReference;

  /// No description provided for @estate_listedAt.
  ///
  /// In en, this message translates to:
  /// **'Listed At'**
  String get estate_listedAt;

  /// No description provided for @estate_updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated At'**
  String get estate_updatedAt;

  /// No description provided for @estate_views.
  ///
  /// In en, this message translates to:
  /// **'Views'**
  String get estate_views;

  /// No description provided for @estate_savedCount.
  ///
  /// In en, this message translates to:
  /// **'Saved Count'**
  String get estate_savedCount;

  /// No description provided for @estate_listingStatus.
  ///
  /// In en, this message translates to:
  /// **'Listing Status'**
  String get estate_listingStatus;

  /// No description provided for @estate_ratingAverage.
  ///
  /// In en, this message translates to:
  /// **'Rating Average'**
  String get estate_ratingAverage;

  /// No description provided for @estate_reviewCount.
  ///
  /// In en, this message translates to:
  /// **'Review Count'**
  String get estate_reviewCount;

  /// No description provided for @add_apartment_appTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Apartment'**
  String get add_apartment_appTitle;

  /// No description provided for @add_apartment_basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get add_apartment_basicInfo;

  /// No description provided for @add_apartment_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get add_apartment_location;

  /// No description provided for @add_apartment_details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get add_apartment_details;

  /// No description provided for @add_apartment_features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get add_apartment_features;

  /// No description provided for @add_apartment_media.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get add_apartment_media;

  /// No description provided for @add_apartment_title.
  ///
  /// In en, this message translates to:
  /// **'Title*'**
  String get add_apartment_title;

  /// No description provided for @add_apartment_description.
  ///
  /// In en, this message translates to:
  /// **'Description*'**
  String get add_apartment_description;

  /// No description provided for @add_apartment_price.
  ///
  /// In en, this message translates to:
  /// **'Price*'**
  String get add_apartment_price;

  /// No description provided for @add_apartment_area.
  ///
  /// In en, this message translates to:
  /// **'Area (m²)*'**
  String get add_apartment_area;

  /// No description provided for @add_apartment_rooms.
  ///
  /// In en, this message translates to:
  /// **'Rooms*'**
  String get add_apartment_rooms;

  /// No description provided for @add_apartment_bathrooms.
  ///
  /// In en, this message translates to:
  /// **'Bathrooms*'**
  String get add_apartment_bathrooms;

  /// No description provided for @add_apartment_kitchens.
  ///
  /// In en, this message translates to:
  /// **'Kitchens*'**
  String get add_apartment_kitchens;

  /// No description provided for @add_apartment_floor.
  ///
  /// In en, this message translates to:
  /// **'Floor*'**
  String get add_apartment_floor;

  /// No description provided for @add_apartment_totalFloors.
  ///
  /// In en, this message translates to:
  /// **'Total Floors*'**
  String get add_apartment_totalFloors;

  /// No description provided for @add_apartment_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone*'**
  String get add_apartment_phone;

  /// No description provided for @add_apartment_videoUrl.
  ///
  /// In en, this message translates to:
  /// **'Video URL (optional)'**
  String get add_apartment_videoUrl;

  /// No description provided for @add_apartment_addressDesc.
  ///
  /// In en, this message translates to:
  /// **'Address Description'**
  String get add_apartment_addressDesc;

  /// No description provided for @add_apartment_selectLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Location on Map'**
  String get add_apartment_selectLocation;

  /// No description provided for @add_apartment_addPhotos.
  ///
  /// In en, this message translates to:
  /// **'Add Photos'**
  String get add_apartment_addPhotos;

  /// No description provided for @add_apartment_photosHint.
  ///
  /// In en, this message translates to:
  /// **'Add apartment photos'**
  String get add_apartment_photosHint;

  /// No description provided for @add_apartment_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get add_apartment_next;

  /// No description provided for @add_apartment_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get add_apartment_back;

  /// No description provided for @add_apartment_submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get add_apartment_submit;

  /// No description provided for @add_apartment_listingType.
  ///
  /// In en, this message translates to:
  /// **'Listing Type*'**
  String get add_apartment_listingType;

  /// No description provided for @add_apartment_rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get add_apartment_rent;

  /// No description provided for @add_apartment_sale.
  ///
  /// In en, this message translates to:
  /// **'Sale'**
  String get add_apartment_sale;

  /// No description provided for @add_apartment_selectFeatures.
  ///
  /// In en, this message translates to:
  /// **'Select Features'**
  String get add_apartment_selectFeatures;

  /// No description provided for @add_apartment_balcony.
  ///
  /// In en, this message translates to:
  /// **'Balcony'**
  String get add_apartment_balcony;

  /// No description provided for @add_apartment_parking.
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get add_apartment_parking;

  /// No description provided for @add_apartment_elevator.
  ///
  /// In en, this message translates to:
  /// **'Elevator'**
  String get add_apartment_elevator;

  /// No description provided for @add_apartment_storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get add_apartment_storage;

  /// No description provided for @add_apartment_ac.
  ///
  /// In en, this message translates to:
  /// **'Air Conditioning'**
  String get add_apartment_ac;

  /// No description provided for @add_apartment_wifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get add_apartment_wifi;

  /// No description provided for @add_apartment_pool.
  ///
  /// In en, this message translates to:
  /// **'Pool'**
  String get add_apartment_pool;

  /// No description provided for @add_apartment_gym.
  ///
  /// In en, this message translates to:
  /// **'Gym Nearby'**
  String get add_apartment_gym;

  /// No description provided for @add_apartment_furnished.
  ///
  /// In en, this message translates to:
  /// **'Furnished'**
  String get add_apartment_furnished;

  /// No description provided for @add_apartment_utilities.
  ///
  /// In en, this message translates to:
  /// **'Utilities Included'**
  String get add_apartment_utilities;

  /// No description provided for @add_apartment_requiredField.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get add_apartment_requiredField;

  /// No description provided for @add_apartment_addSuccess.
  ///
  /// In en, this message translates to:
  /// **'Property added successfully!'**
  String get add_apartment_addSuccess;

  /// No description provided for @add_apartment_addError.
  ///
  /// In en, this message translates to:
  /// **'Error: '**
  String get add_apartment_addError;

  /// No description provided for @add_apartment_photosRequired.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one photo'**
  String get add_apartment_photosRequired;

  /// No description provided for @add_apartment_city.
  ///
  /// In en, this message translates to:
  /// **'City*'**
  String get add_apartment_city;

  /// No description provided for @add_apartment_loading.
  ///
  /// In en, this message translates to:
  /// **'Saving data...'**
  String get add_apartment_loading;

  /// No description provided for @add_apartment_requiredFields.
  ///
  /// In en, this message translates to:
  /// **'Fill all required info'**
  String get add_apartment_requiredFields;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'he'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'he': return AppLocalizationsHe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
