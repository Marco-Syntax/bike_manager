
# Bike Manager

## Projektbeschreibung

Bike Manager ist eine Flutter-Anwendung zur Verwaltung von Fahrrädern. Sie unterstützt die grundlegenden CRUD-Operationen (Erstellen, Lesen, Aktualisieren, Löschen) für Fahrraddaten. Die Persistenz erfolgt lokal über SharedPreferences. Die App bietet Mehrsprachigkeit mittels ARB-Dateien und nutzt State-Management mit Riverpod.

## Architektur & Struktur

Die Anwendung folgt dem MVVM-Architekturmuster. Die Datenhaltung und der Zugriff auf Persistenz werden durch das Repository Pattern gekapselt, was eine klare Trennung zwischen UI und Datenzugriff ermöglicht. Riverpod übernimmt das State-Management und ermöglicht eine reaktive wie testbare Struktur.

**Projektstruktur:**

- `lib/` – Anwendungscode
  - `main.dart` – Einstiegspunkt
  - `views/` – UI-Screens
  - `widgets/` – Wiederverwendbare Komponenten
  - `core/` – Repository und Storage-Logik
  - `models/` – Datenmodelle
  - `utils/` – Hilfsfunktionen
- `assets/texts/` – ARB-Lokalisierungsdateien
- `test/` – Testfälle

## Technologien & Tools

- Flutter SDK (empfohlen: Version 3.x oder neuer)
- Dart SDK (in Flutter enthalten)
- Riverpod für State-Management
- SharedPreferences für lokale Persistenz
- ARB-Dateien für Lokalisierung
- Build Runner für Code-Generierung (optional)
- Android Studio und/oder Xcode für native Builds

## Besonderheiten

- MVVM-Architektur mit konsequenter Trennung von UI und Datenzugriff
- Repository Pattern für verbesserte Testbarkeit und Wartbarkeit
- Lokalisierung (L10n) mit ARB-Dateien, automatische Generierung der Übersetzungen
- Tests mit Mocking-Unterstützung

## Build & Deployment

1. Abhängigkeiten installieren:

   ```bash
   flutter pub get

   ```
  
2. (Optional) Code-Generierung:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. Lokalisierung:
   Die generierten L10n-Dateien befinden sich in `.dart_tool/flutter_gen/gen_l10n` und werden beim Build automatisch erzeugt.

**Wichtige Kommandos:**

- App starten (Debug):  
  `flutter run`
- Android Release-Build:  
  `flutter build apk --release`
- iOS Release-Build:  
  `flutter build ios --release`
- Dart-Code formatieren:  
  `dart format .`
- Projekt bereinigen:  
  `flutter clean`
- Tests ausführen:  
  `flutter test`

## Zusammenfassung

Bike Manager ist eine modular aufgebaute Flutter-App zur effizienten Verwaltung von Fahrrädern mit Fokus auf Wartbarkeit, Testbarkeit und Mehrsprachigkeit. Die Anwendung nutzt etablierte Patterns und Technologien, um eine robuste Grundlage für Weiterentwicklung und Anpassung zu bieten.
