// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Bike Manager';

  @override
  String get homePlaceholder => 'Bitte fügen Sie ein Fahrrad hinzu';

  @override
  String get addBike => 'Fahrrad hinzufügen';

  @override
  String get welcomeMessage => 'Willkommen beim Bike Manager';

  @override
  String get welcomeSubtitle =>
      'Verwalte deine Fahrräder schnell und unkompliziert';

  @override
  String get detailsTitle => 'Details';

  @override
  String get delete => 'Löschen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get confirmDeleteTitle => 'Eintrag löschen?';

  @override
  String confirmDeleteMessage(Object name) {
    return 'Möchten Sie $name wirklich löschen?';
  }

  @override
  String get name => 'Fahrradname';

  @override
  String get type => 'Fahrradtyp';

  @override
  String get manufacturer => 'Hersteller';

  @override
  String get purchaseDate => 'Kaufdatum';

  @override
  String get purchasePrice => 'Kaufpreis';

  @override
  String get notSet => 'Nicht gesetzt';

  @override
  String get requiredName => 'Name ist erforderlich';

  @override
  String get selectType => 'Bitte wählen Sie einen Typ';

  @override
  String get chooseType => 'Bitte auswählen';

  @override
  String get optionalManufacturer => 'Hersteller (optional)';

  @override
  String get optionalPurchaseDate => 'Kaufdatum (optional)';

  @override
  String get optionalPurchasePrice => 'Kaufpreis (optional)';

  @override
  String get priceHint => 'z. B. 1999,99';

  @override
  String get invalidPrice => 'Ungültiger Preis';

  @override
  String get negativePrice => 'Preis darf nicht negativ sein';

  @override
  String deletedSnack(Object name) {
    return '$name ';
  }

  @override
  String get deletedTitle => 'Gelöscht';

  @override
  String updatedSnack(Object field) {
    return '$field ';
  }

  @override
  String get updatedTitle => 'Aktualisiert';

  @override
  String addedSnack(Object name) {
    return '$name wurde erfolgreich hinzugefügt.';
  }

  @override
  String get addedTitle => 'Fahrrad';

  @override
  String get save => 'Speichern';

  @override
  String get bikeTypeMountainbike => 'Mountainbike';

  @override
  String get bikeTypeCitybike => 'Citybike';

  @override
  String get bikeTypeTrekking => 'Trekkingrad';

  @override
  String get bikeTypeGravel => 'Gravelbike';

  @override
  String get bikeTypeRace => 'Rennrad';

  @override
  String get bikeTypeEBike => 'E-Bike';

  @override
  String get bikeTypeOther => 'Sonstiges';

  @override
  String get unknown => 'Unbekannt';
}
