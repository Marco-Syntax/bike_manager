# Bike Manager

Eine Flutter-App zur Verwaltung deiner persönlichen Fahrradsammlung. Vollständige CRUD-Funktionalität mit lokaler Persistenz, Mehrsprachigkeit (DE/EN) und modernem UI.

## Features

- Fahrräder hinzufügen, bearbeiten und löschen
- 7 Fahrradtypen mit individuellen Icons und Farbschemata
- Inline-Editing in der Detailansicht
- Swipe-to-Delete mit Bestätigungsdialog
- Animierte Listeneinträge und Tap-Effekte
- Deutsch und Englisch (automatische Erkennung)
- Offline-First: Alle Daten lokal gespeichert

## Tech Stack

- **Flutter** ≥ 3.7.2 / **Dart**
- **Riverpod** – State Management & Dependency Injection
- **SharedPreferences** – Lokale Persistenz
- **Freezed** – Immutable Datenmodelle mit Code-Generierung
- **intl + ARB** – Internationalisierung

## Architektur

MVVM + Repository Pattern mit klarer Schichtentrennung:

```
Views → ViewModel (StateNotifier) → Repository → Storage (SharedPreferences)
```

Ausführliche Architektur-Dokumentation: [DOCUMENTATION.md](DOCUMENTATION.md)

## Projektstruktur

```
lib/
├── main.dart              # Einstiegspunkt
├── core/                  # Repository + Storage
├── models/                # Freezed-Datenmodelle
├── views/                 # Screens + ViewModels
├── widgets/               # Wiederverwendbare UI-Komponenten
├── utils/                 # Farben, Styles, Formatierung, Dialoge
└── l10n/                  # Generierte Lokalisierung
```

## Quickstart

```bash
# Repository klonen
git clone https://github.com/Marco-Syntax/bike_manager.git
cd bike_manager

# Abhängigkeiten installieren
flutter pub get

# App starten
flutter run

# (Optional) Code-Generierung
flutter pub run build_runner build --delete-conflicting-outputs
```

## Wichtige Kommandos

| Kommando | Beschreibung |
|---|---|
| `flutter run` | App im Debug-Modus starten |
| `flutter test` | Alle Tests ausführen |
| `flutter build apk --release` | Android Release-Build |
| `flutter build ios --release` | iOS Release-Build |
| `flutter analyze` | Statische Analyse |
| `dart format .` | Code formatieren |
| `flutter clean` | Projekt bereinigen |

## Tests

```bash
flutter test
```

Testabdeckung: Unit Tests (Storage, Repository, Formatierung), Widget Tests, Integrationstest (Add-Bike-Flow).

## Dokumentation

Die vollständige technische Dokumentation befindet sich in [DOCUMENTATION.md](DOCUMENTATION.md).

Bike Manager ist eine modular aufgebaute Flutter-Anwendung zur nachhaltigen und effizienten Verwaltung von Fahrrädern. Durch die konsequente Umsetzung von MVVM, Repository Pattern, Dependency Injection via Riverpod sowie Clean-Code-Prinzipien bietet die App eine robuste, wartbare und erweiterbare Basis. Die Integration von Mehrsprachigkeit und umfangreichen Tests unterstützt eine hohe Qualität und Benutzerfreundlichkeit. Das Projekt ist so konzipiert, dass zukünftige Erweiterungen, etwa durch alternative Persistenzmethoden oder API-Anbindungen, problemlos möglich sind.
