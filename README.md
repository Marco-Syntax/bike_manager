# bike_manager

Bike Manager ist eine Flutter-App zur Verwaltung von Fahrrädern (CRUD). Persistenz erfolgt über SharedPreferences, State-Management mit Riverpod und Lokalisierung mittels ARB-Dateien (L10n).

## Features

- CRUD-Funktionalität zur Verwaltung von Fahrrädern  
- Persistente Speicherung mit SharedPreferences  
- Lokalisierung über ARB-Dateien  
- State-Management mit Riverpod  
- Umfangreiche Tests mit Mocking-Unterstützung  

## Voraussetzungen

- Flutter SDK (stabile Version, z. B. 3.x oder neuer)  
- Dart SDK (in Flutter enthalten)  
- Optional: Android Studio und/oder Xcode für native Builds und Emulatoren  

## Installation & Setup

1. Abhängigkeiten installieren

```bash
flutter pub get
```

2. (Optional) Code-Generatoren ausführen

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3. Lokalisierung

Die generierten L10n-Dateien liegen unter `.dart_tool/flutter_gen/gen_l10n` und werden normalerweise automatisch beim Build erzeugt.

## Nützliche Befehle

- App starten (Debug)

```bash
flutter run
```

- Android Release-Build

```bash
flutter build apk --release
```

- iOS Release-Build

```bash
flutter build ios --release
```

- Dart-Code formatieren

```bash
dart format .
```

- Projekt bereinigen

```bash
flutter clean
```

- Tests ausführen

```bash
flutter test
```

## Projektstruktur

- `lib/` – App-Code  
  - `main.dart`  
  - `views/` – Screens  
  - `widgets/` – Wiederverwendbare Widgets  
  - `core/` – Repository & Storage  
  - `models/` – Datenmodelle  
  - `utils/` – Hilfsfunktionen  
- `assets/texts/` – ARB-Lokalisierungen  
- `test/` – Tests  

## Architekturprinzipien

Die App folgt dem MVVM-Pattern mit Riverpod als State-Management. Das Repository Pattern sorgt für eine klare Trennung zwischen Datenzugriff und UI-Logik, was Wartbarkeit und Testbarkeit verbessert.
