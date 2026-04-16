import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Bike Manager'**
  String get appTitle;

  /// No description provided for @homePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Please add your bike'**
  String get homePlaceholder;

  /// No description provided for @addBike.
  ///
  /// In en, this message translates to:
  /// **'Add bike'**
  String get addBike;

  /// No description provided for @welcomeMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Bike Manager'**
  String get welcomeMessage;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your bikes quickly and effortlessly'**
  String get welcomeSubtitle;

  /// No description provided for @detailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detailsTitle;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirmDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete entry?'**
  String get confirmDeleteTitle;

  /// No description provided for @confirmDeleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete {name}?'**
  String confirmDeleteMessage(Object name);

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Bike name'**
  String get name;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Biketype'**
  String get type;

  /// No description provided for @manufacturer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get manufacturer;

  /// No description provided for @purchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date'**
  String get purchaseDate;

  /// No description provided for @purchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Purchase price'**
  String get purchasePrice;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @requiredName.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get requiredName;

  /// No description provided for @selectType.
  ///
  /// In en, this message translates to:
  /// **'Please select a type'**
  String get selectType;

  /// No description provided for @chooseType.
  ///
  /// In en, this message translates to:
  /// **'Please select'**
  String get chooseType;

  /// No description provided for @optionalManufacturer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer (optional)'**
  String get optionalManufacturer;

  /// No description provided for @optionalPurchaseDate.
  ///
  /// In en, this message translates to:
  /// **'Purchase date (optional)'**
  String get optionalPurchaseDate;

  /// No description provided for @optionalPurchasePrice.
  ///
  /// In en, this message translates to:
  /// **'Purchase price (optional)'**
  String get optionalPurchasePrice;

  /// No description provided for @priceHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1999.99'**
  String get priceHint;

  /// No description provided for @invalidPrice.
  ///
  /// In en, this message translates to:
  /// **'Invalid price'**
  String get invalidPrice;

  /// No description provided for @negativePrice.
  ///
  /// In en, this message translates to:
  /// **'Price must not be negative'**
  String get negativePrice;

  /// No description provided for @deletedSnack.
  ///
  /// In en, this message translates to:
  /// **'{name} '**
  String deletedSnack(Object name);

  /// No description provided for @deletedTitle.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get deletedTitle;

  /// No description provided for @updatedSnack.
  ///
  /// In en, this message translates to:
  /// **'{field} '**
  String updatedSnack(Object field);

  /// No description provided for @updatedTitle.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get updatedTitle;

  /// No description provided for @addedSnack.
  ///
  /// In en, this message translates to:
  /// **'{name} was added.'**
  String addedSnack(Object name);

  /// No description provided for @addedTitle.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get addedTitle;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @bikeTypeMountainbike.
  ///
  /// In en, this message translates to:
  /// **'Mountain bike'**
  String get bikeTypeMountainbike;

  /// No description provided for @bikeTypeCitybike.
  ///
  /// In en, this message translates to:
  /// **'City bike'**
  String get bikeTypeCitybike;

  /// No description provided for @bikeTypeTrekking.
  ///
  /// In en, this message translates to:
  /// **'Trekking bike'**
  String get bikeTypeTrekking;

  /// No description provided for @bikeTypeGravel.
  ///
  /// In en, this message translates to:
  /// **'Gravel bike'**
  String get bikeTypeGravel;

  /// No description provided for @bikeTypeRace.
  ///
  /// In en, this message translates to:
  /// **'Road bike'**
  String get bikeTypeRace;

  /// No description provided for @bikeTypeEBike.
  ///
  /// In en, this message translates to:
  /// **'E-bike'**
  String get bikeTypeEBike;

  /// No description provided for @bikeTypeOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get bikeTypeOther;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
