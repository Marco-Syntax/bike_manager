# Bike Manager

## Projektbeschreibung

Bike Manager ist eine moderne Flutter-Anwendung zur effizienten Verwaltung von Fahrrädern. Die App bietet umfassende CRUD-Funktionalitäten (Create, Read, Update, Delete) mit lokaler Persistenz über SharedPreferences. Durch die Unterstützung von Mehrsprachigkeit mittels ARB-Dateien und die Nutzung von Riverpod für das State-Management sowie Dependency Injection gewährleisten Bike Manager eine benutzerfreundliche und flexible Bedienung.

## Architektur & Struktur

Die Anwendung basiert auf dem MVVM-Architekturmuster (Model-View-ViewModel) und setzt konsequent auf das Repository Pattern, um eine klare Trennung zwischen UI, Geschäftslogik und Datenzugriff zu gewährleisten. Dies fördert Wartbarkeit, Testbarkeit und Erweiterbarkeit. Die Dependency Injection erfolgt über Riverpod-Provider, was die modulare Integration und Wiederverwendbarkeit von Komponenten unterstützt. Clean-Code-Prinzipien und SOLID-Designrichtlinien bilden die Grundlage für eine saubere und verständliche Codebasis.

**Projektstruktur:**

- `lib/` – Hauptanwendungscode
  - `main.dart` – Einstiegspunkt
  - `views/` – UI-Komponenten und Screens
  - `widgets/` – Wiederverwendbare UI-Elemente
  - `core/` – Repository- und Storage-Implementierungen
  - `models/` – Datenmodelle
  - `utils/` – Hilfsfunktionen und Utilities
- `assets/texts/` – Lokalisierungsdateien im ARB-Format
- `test/` – Unit- und Integrationstests

## Technologien & Tools

- Flutter SDK (empfohlen Version 3.x oder höher)
- Dart SDK (in Flutter enthalten)
- Riverpod für State-Management und Dependency Injection
- SharedPreferences für lokale Datenpersistenz
- ARB-Dateien für mehrsprachige Lokalisierung
- Build Runner für optionale Code-Generierung
- Android Studio und Xcode für native Builds

## Besonderheiten

- Strikte MVVM-Architektur mit klarer Trennung von UI und Datenzugriff
- Repository Pattern zur Verbesserung von Testbarkeit und Wartbarkeit
- In-Memory Caching zur Performance-Optimierung
- Dependency Injection über Riverpod für flexible Komponentenintegration
- Saubere Projektstruktur nach Best Practices und Clean-Code-Richtlinien
- Automatisierte Lokalisierung mit ARB-Dateien und generierten Übersetzungen
- Umfangreiche Tests mit Mocking zur Sicherstellung der Codequalität
- Erweiterbarkeit für alternative Persistenzlösungen wie Hive, Drift oder REST-APIs

## Build & Deployment

1. Abhängigkeiten installieren:

   ```bash
   flutter pub get
   ```

2. (Optional) Code-Generierung ausführen:

   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. Lokalisierung:  
   Die generierten L10n-Dateien befinden sich im Verzeichnis `.dart_tool/flutter_gen/gen_l10n` und werden automatisch beim Build erstellt.

**Wichtige Kommandos:**

- App starten (Debug):

  ```bash
  flutter run
  ```

- Android Release-Build:

  ```bash
  flutter build apk --release
  ```

- iOS Release-Build:

  ```bash
  flutter build ios --release
  ```

- Dart-Code formatieren:

  ```bash
  dart format .
  ```

- Projekt bereinigen:

  ```bash
  flutter clean
  ```

- Tests ausführen:

  ```bash
  flutter test
  ```

## Zusammenfassung

Bike Manager ist eine modular aufgebaute Flutter-Anwendung zur nachhaltigen und effizienten Verwaltung von Fahrrädern. Durch die konsequente Umsetzung von MVVM, Repository Pattern, Dependency Injection via Riverpod sowie Clean-Code-Prinzipien bietet die App eine robuste, wartbare und erweiterbare Basis. Die Integration von Mehrsprachigkeit und umfangreichen Tests unterstützt eine hohe Qualität und Benutzerfreundlichkeit. Das Projekt ist so konzipiert, dass zukünftige Erweiterungen, etwa durch alternative Persistenzmethoden oder API-Anbindungen, problemlos möglich sind.
