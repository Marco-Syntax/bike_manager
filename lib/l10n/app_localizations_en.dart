// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Bike Manager';

  @override
  String get homePlaceholder => 'Please add your bike';

  @override
  String get addBike => 'Add bike';

  @override
  String get welcomeMessage => 'Welcome to Bike Manager';

  @override
  String get welcomeSubtitle => 'Manage your bikes quickly and effortlessly';

  @override
  String get detailsTitle => 'Details';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirmDeleteTitle => 'Delete entry?';

  @override
  String confirmDeleteMessage(Object name) {
    return 'Do you really want to delete $name?';
  }

  @override
  String get name => 'Bike name';

  @override
  String get type => 'Biketype';

  @override
  String get manufacturer => 'Manufacturer';

  @override
  String get purchaseDate => 'Purchase date';

  @override
  String get purchasePrice => 'Purchase price';

  @override
  String get notSet => 'Not set';

  @override
  String get requiredName => 'Name is required';

  @override
  String get selectType => 'Please select a type';

  @override
  String get chooseType => 'Please select';

  @override
  String get optionalManufacturer => 'Manufacturer (optional)';

  @override
  String get optionalPurchaseDate => 'Purchase date (optional)';

  @override
  String get optionalPurchasePrice => 'Purchase price (optional)';

  @override
  String get priceHint => 'e.g. 1999.99';

  @override
  String get invalidPrice => 'Invalid price';

  @override
  String get negativePrice => 'Price must not be negative';

  @override
  String deletedSnack(Object name) {
    return '$name ';
  }

  @override
  String get deletedTitle => 'Deleted';

  @override
  String updatedSnack(Object field) {
    return '$field ';
  }

  @override
  String get updatedTitle => 'Updated';

  @override
  String addedSnack(Object name) {
    return '$name was added.';
  }

  @override
  String get addedTitle => 'Success';

  @override
  String get save => 'Save';

  @override
  String get bikeTypeMountainbike => 'Mountain bike';

  @override
  String get bikeTypeCitybike => 'City bike';

  @override
  String get bikeTypeTrekking => 'Trekking bike';

  @override
  String get bikeTypeGravel => 'Gravel bike';

  @override
  String get bikeTypeRace => 'Road bike';

  @override
  String get bikeTypeEBike => 'E-bike';

  @override
  String get bikeTypeOther => 'Other';

  @override
  String get unknown => 'Unknown';
}
