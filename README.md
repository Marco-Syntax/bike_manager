# bike_manager

Bike Manager ist eine Flutter-App zur Verwaltung von Fahrrädern (CRUD). Persistenz erfolgt über SharedPreferences, State-Management mit Riverpod und Lokalisierung mittels ARB-Dateien (L10n).

## Features

- Vollständige CRUD-Funktionalität zur Verwaltung von Fahrrädern  
- Persistente Speicherung der Daten mit SharedPreferences  
- Lokalisierung der App-Texte über ARB-Dateien  
- State-Management mit Riverpod  
- Umfangreiche Tests mit Mocking-Unterstützung  

## Voraussetzungen

- Flutter SDK (stabile Version empfohlen, z. B. 3.x oder neuer)  
- Dart SDK (wird mit Flutter mitgeliefert)  
- Optional: Android Studio und/oder Xcode für native Builds und Emulatoren  

## Installation & Setup

1. Abhängigkeiten installieren

```bash
flutter pub get
```

2.(Optional) Code-Generatoren ausführen

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

3.Lokalisierung

Die generierten L10n-Dateien werden unter `.dart_tool/flutter_gen/gen_l10n` erzeugt. Flutter generiert diese normalerweise automatisch beim Build oder Start der App.

## Nützliche Befehle

- App starten (Debug)

```bash
flutter run
```

- Android Release-Build

```bash
flutter build apk --release
```

- iOS Release-Build (Xcode benötigt)

```bash
flutter build ios --release
```

- Alle Dart-Dateien formatieren

```bash
dart format .
```

- Projekt bereinigen (Build-Ordner löschen)

```bash
flutter clean
```

- Build-Runner ausführen

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

- Tests ausführen

```bash
flutter test
```

- Einzelne Testdatei ausführen

```bash
flutter test test/add_bike_flow_test.dart
```

- Tests mit ausführlichem Output

```bash
flutter test -r expanded
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

## Tests & Entwicklungshinweise

- **SharedPreferences in Tests:**  
  Vor dem Aufruf von `pumpWidget` sollte `SharedPreferences.setMockInitialValues({});` gesetzt werden, damit Repository-Operationen in Tests funktionieren.

  Beispiel:

  ```dart
  SharedPreferences.setMockInitialValues({});
  await tester.pumpWidget(const ProviderScope(child: BikeManagerApp()));
  ```

- **Lokalisierung in Tests:**  
  Um `AppLocalizations` zu verwenden, hole den Kontext nach `pumpWidget`:

  ```dart
  final ctx = tester.element(find.byType(Scaffold));
  final l10n = AppLocalizations.of(ctx);
  ```

- **Widget-Typen beachten:**  
  UI-Elemente können sich ändern (z. B. `BikeCard` statt `ListTile`). Prüfen Sie die tatsächliche Implementierung, bevor Assertions geschrieben werden.

- **Debugging:**  
  Wenn Tests Widgets nicht finden, prüfen Sie, ob Widget-Typ und Text wie erwartet gerendert werden. Bei Problemen mit `build_runner` empfiehlt sich die Verwendung von `--delete-conflicting-outputs` und die Überprüfung der Generator-Abhängigkeiten.

## Architekturprinzipien

Die App folgt dem MVVM-Pattern mit Riverpod als State-Management. Zusätzlich wird das Repository Pattern angewendet, um eine saubere Trennung zwischen Datenzugriff und State-Management zu gewährleisten. Dadurch wird die Wartbarkeit und Testbarkeit der Anwendung verbessert und eine klare Struktur zwischen Datenquelle und UI-Logik sichergestellt.

## Lizenz

Dieses Projekt steht unter der MIT-Lizenz.
