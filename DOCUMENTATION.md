# Bike Manager – Projektdokumentation

## 1. Überblick

**Bike Manager** ist eine plattformübergreifende Flutter-Anwendung zur Verwaltung von Fahrrädern. Sie bietet vollständige CRUD-Funktionalität (Erstellen, Lesen, Aktualisieren, Löschen) mit lokaler Persistenz, Mehrsprachigkeit und einem modernen, animierten UI.

### Hauptzweck

- Verwaltung einer persönlichen Fahrradsammlung
- Erfassung von Name, Typ, Hersteller, Kaufdatum und Kaufpreis
- Schneller Zugriff auf Detailansichten mit Inline-Bearbeitung

### Zielgruppe

Privatanwender, die ihre Fahrräder digital katalogisieren möchten – von Gelegenheitsfahrern bis zu Enthusiasten mit mehreren Rädern.

---

## 2. Tech Stack

| Kategorie | Technologie | Version |
|---|---|---|
| Framework | Flutter | SDK ≥ 3.7.2 |
| Sprache | Dart | (im Flutter SDK enthalten) |
| State Management | flutter_riverpod | 2.6.1 |
| Lokale Persistenz | shared_preferences | 2.5.3 |
| Code-Generierung (Model) | freezed / freezed_annotation | 2.5.8 / 2.4.4 |
| JSON-Serialisierung | json_serializable / json_annotation | 6.9.5 / 4.9.0 |
| Internationalisierung | intl + ARB-Dateien | 0.20.2 |
| Icons | font_awesome_flutter | 10.9.1 |
| UUID-Generierung | uuid | 4.5.1 |
| Snackbar-UI | awesome_snackbar_content | 0.1.6 |
| Build-Tooling | build_runner | 2.5.4 |
| Linting | flutter_lints | 5.0.0 |
| App Icon | flutter_launcher_icons | 0.10.0 |

### Externe Services

Keine. Die App arbeitet vollständig offline mit lokaler Datenhaltung über `SharedPreferences`.

---

## 3. Architektur

### Gesamtarchitektur

Die Anwendung implementiert das **MVVM-Pattern** (Model-View-ViewModel) in Kombination mit dem **Repository Pattern**. Dependency Injection erfolgt über Riverpod-Provider.

```
┌─────────────────────────────────────────────────┐
│                     Views                        │
│  (HomeView, AddBikeView, DetailsView)           │
│         ▲ watch/read via Riverpod                │
├─────────┼───────────────────────────────────────┤
│         ▼                                        │
│                  ViewModel                       │
│            (BikeViewModel)                       │
│    StateNotifier<List<Bike>>                     │
│         ▲                                        │
├─────────┼───────────────────────────────────────┤
│         ▼                                        │
│                Repository                        │
│           (BikeRepository)                       │
│    CRUD-Operationen, Business Logic              │
│         ▲                                        │
├─────────┼───────────────────────────────────────┤
│         ▼                                        │
│                 Storage                          │
│     (IBikeStorage → BikeStorage)                 │
│    SharedPreferences (JSON)                      │
└─────────────────────────────────────────────────┘
```

### Verwendete Patterns

| Pattern | Umsetzung |
|---|---|
| **MVVM** | Views beobachten den ViewModel-State via `ref.watch(bikeProvider)` |
| **Repository Pattern** | `BikeRepository` kapselt den Datenzugriff und abstrahiert die Storage-Schicht |
| **Dependency Injection** | Riverpod-Provider (`bikeStorageProvider`, `bikeRepositoryProvider`, `bikeProvider`) |
| **Interface Segregation** | `IBikeStorage`-Interface ermöglicht austauschbare Storage-Implementierungen |
| **Immutable Models** | `freezed`-generierte Datenklassen mit `copyWith`-Support |

### Datenfluss

1. **Lesen:** View → `ref.watch(bikeProvider)` → `BikeViewModel.state` (cached in-memory)
2. **Schreiben:** View → `BikeViewModel.addBike()` → `BikeRepository.addBike()` → `BikeStorage.saveBikes()` → `SharedPreferences`
3. **Aktualisieren:** Nach jeder Mutation ruft der ViewModel `loadBikes()` auf und aktualisiert den State

---

## 4. Projektstruktur

```
lib/
├── main.dart                          # App-Einstiegspunkt, MaterialApp-Konfiguration
├── core/
│   ├── bike_storage.dart              # IBikeStorage-Interface + SharedPreferences-Implementierung
│   └── bike_repository.dart           # Repository mit CRUD-Operationen + Riverpod-Provider
├── models/
│   ├── bike_type.dart                 # Enum: 7 Fahrradtypen
│   ├── bike.dart                      # Freezed-Datenmodell
│   ├── bike.freezed.dart              # Generiert: copyWith, ==, hashCode
│   └── bike.g.dart                    # Generiert: JSON-Serialisierung
├── views/
│   ├── home_view.dart                 # Hauptansicht mit Fahrradliste
│   ├── add_bike_view.dart             # Formular zum Hinzufügen
│   ├── details_view.dart              # Detailansicht mit Inline-Editing
│   └── viewmodels/
│       └── bike_view_model.dart       # StateNotifier mit Business Logic
├── widgets/
│   ├── add_bike_placeholder.dart      # Leerzustand-Widget (Empty State)
│   ├── bike_card.dart                 # Listenelement mit Animation
│   ├── bike_details_card.dart         # Detail-Karte mit editierbaren Feldern
│   ├── bike_type_avatar.dart          # Typ-spezifisches Icon mit Farbe
│   ├── bike_type_dropdown.dart        # Bottom-Sheet-Auswahl für Fahrradtyp
│   ├── info_chip.dart                 # Kompakte Info-Anzeige (Typ, Datum, Preis)
│   └── swipe_to_delete_background.dart # Hintergrund für Swipe-to-Delete
├── utils/
│   ├── app_colors.dart                # Farbpalette + Typ-spezifische Gradienten
│   ├── button_styles.dart             # Wiederverwendbare Button-Styles
│   ├── form_styles.dart               # InputDecoration-Factory
│   ├── formatting.dart                # Datums-, Preis- und Typ-Formatierung
│   └── dialogs.dart                   # Bestätigungs-Dialoge, Snackbars, Edit-Dialog
└── l10n/
    ├── app_localizations.dart         # Generiert: Lokalisierungs-Delegate
    ├── app_localizations_en.dart      # Generiert: Englische Übersetzungen
    └── app_localizations_de.dart      # Generiert: Deutsche Übersetzungen

assets/
├── images/                            # App-Icon, Header-Hintergrundbild
└── texts/
    ├── en.arb                         # Englische Übersetzungs-Quelldatei
    ├── de.arb                         # Deutsche Übersetzungs-Quelldatei
    └── available_languages.txt        # Verfügbare Sprachen

test/
├── widget_test.dart                   # Smoke Test: App startet, Leerzustand
├── formatting_test.dart               # Unit Tests: Datums-/Preisformatierung
├── add_bike_flow_test.dart            # Integrationstest: Hinzufügen-Flow
└── core/
    ├── bike_repository_test.dart      # Unit Tests: Repository CRUD
    └── bike_storage_test.dart         # Unit Tests: Storage Roundtrip
```

### Verantwortlichkeiten pro Layer

| Layer | Verantwortung |
|---|---|
| **Models** | Datenstrukturen, Serialisierung, Immutabilität |
| **Core** | Datenzugriff (Storage), Geschäftslogik (Repository) |
| **ViewModels** | State-Verwaltung, Formular-Validierung, Koordination zwischen View und Repository |
| **Views** | UI-Rendering, Navigation, User-Interaktion |
| **Widgets** | Wiederverwendbare, zustandslose UI-Bausteine |
| **Utils** | Querschnittsfunktionalität (Farben, Styles, Formatierung, Dialoge) |
| **l10n** | Generierte Lokalisierungsklassen |

---

## 5. Setup & Installation

### Voraussetzungen

- **Flutter SDK** ≥ 3.7.2 ([Installationsanleitung](https://docs.flutter.dev/get-started/install))
- **Dart SDK** (im Flutter SDK enthalten)
- **Android Studio** oder **Xcode** für native Builds
- **Git** für die Versionsverwaltung

### Schritt-für-Schritt-Anleitung

```bash
# 1. Repository klonen
git clone https://github.com/Marco-Syntax/bike_manager.git
cd bike_manager

# 2. Abhängigkeiten installieren
flutter pub get

# 3. (Optional) Code-Generierung ausführen
#    Nur notwendig, wenn bike.freezed.dart oder bike.g.dart fehlen/veraltet sind
flutter pub run build_runner build --delete-conflicting-outputs

# 4. (Optional) Lokalisierung regenerieren
#    Wird automatisch beim Build ausgeführt
flutter gen-l10n
```

### Umgebungsvariablen

Keine erforderlich. Die App benötigt keine API-Keys oder externe Konfiguration.

---

## 6. Projekt starten

### Entwicklungsmodus

```bash
# Alle verbundenen Geräte anzeigen
flutter devices

# App im Debug-Modus starten
flutter run

# App auf spezifischem Gerät starten
flutter run -d <device-id>

# Hot Reload: r drücken im Terminal
# Hot Restart: R drücken im Terminal
```

### Build & Produktion

```bash
# Android APK (Release)
flutter build apk --release

# Android App Bundle (für Google Play)
flutter build appbundle --release

# iOS (Release) – erfordert macOS + Xcode
flutter build ios --release

# macOS (Release)
flutter build macos --release

# Web
flutter build web --release
```

### Weitere Kommandos

```bash
# Code formatieren
dart format .

# Statische Analyse
flutter analyze

# Projekt bereinigen
flutter clean && flutter pub get
```

---

## 7. Kernfunktionen

### 7.1 Fahrrad hinzufügen

- Formular mit Validierung (Name und Typ sind Pflichtfelder)
- Optionale Felder: Hersteller, Kaufdatum (DatePicker), Kaufpreis
- Preis-Validierung: Akzeptiert Komma und Punkt als Dezimaltrenner, keine negativen Werte
- UUID-Generierung für eindeutige IDs
- Erfolgs-Snackbar nach dem Speichern

### 7.2 Fahrradliste (Home View)

- Animierte Listeneinträge mit Typ-spezifischen Farbgradienten
- Tap-Animation (Scale-Effekt) auf Karten
- **Empty State:** Willkommensnachricht mit zentralem Add-Button
- **FAB** (Floating Action Button) zum Hinzufügen, wenn Einträge vorhanden
- Header-Bild mit abgerundeten Ecken

### 7.3 Detailansicht

- Vollständige Anzeige aller Bike-Attribute
- **Inline-Editing:** Hersteller, Kaufdatum und Kaufpreis direkt bearbeitbar
  - Text-Felder über Edit-Dialog
  - Datum über nativen DatePicker
  - Preis mit Validierung
- Info-Chips für kompakte Übersicht
- Löschen über AppBar-Action mit Bestätigungsdialog

### 7.4 Swipe-to-Delete

- Fahrräder in der Liste per Swipe nach links löschen
- Bestätigungsdialog vor dem Löschen
- Erfolgs-Snackbar nach dem Löschen

### 7.5 Fahrradtypen

7 unterstützte Typen mit individuellen Icons und Farbschemata:

| Typ | Icon | Farbschema |
|---|---|---|
| Mountainbike | Mountain | Grün |
| Citybike | Bicycle | Türkis |
| Trekking | Route | Gelb/Warm |
| Gravel | Road | Grau/Beige |
| Rennrad | Person Biking | Orange/Rot |
| E-Bike | Bicycle + Blitz | Blau |
| Sonstiges | Bicycle | Lila |

### 7.6 Mehrsprachigkeit

- Deutsch und Englisch vollständig unterstützt
- Automatische Spracherkennung basierend auf Geräteeinstellungen
- ARB-Dateien als Übersetzungsquelle mit generierten Dart-Klassen

---

## 8. API-Dokumentation

Nicht zutreffend. Die App arbeitet vollständig offline ohne Backend-Anbindung.

---

## 9. State Management

### Riverpod-Architektur

Die App nutzt **Riverpod** (v2) als State-Management-Lösung und für Dependency Injection.

### Provider-Hierarchie

```dart
// 1. Storage-Provider (Singleton)
final bikeStorageProvider = Provider<IBikeStorage>((ref) => BikeStorage());

// 2. Repository-Provider (Singleton, abhängig von Storage)
final bikeRepositoryProvider = Provider<BikeRepository>(
  (ref) => BikeRepository(ref.read(bikeStorageProvider)),
);

// 3. ViewModel-Provider (StateNotifier, abhängig von Repository)
final bikeProvider = StateNotifierProvider<BikeViewModel, List<Bike>>(
  (ref) => BikeViewModel(repository: ref.read(bikeRepositoryProvider))..loadBikes(),
);
```

### Zustandsfluss

- **`bikeProvider`** hält die gesamte Fahrradliste als `List<Bike>` im Speicher
- Views nutzen `ref.watch(bikeProvider)` für reaktive UI-Updates
- Mutations-Methoden (`addBike`, `removeBike`, `updateBike`) aktualisieren zuerst die Persistenz, dann den In-Memory-State
- Der ViewModel lädt beim Start automatisch alle gespeicherten Daten (`..loadBikes()`)

### Konsistenzmodell

Nach jeder Schreiboperation wird `loadBikes()` erneut aufgerufen, um Konsistenz zwischen Persistenz und In-Memory-State sicherzustellen (Single Source of Truth: Storage).

---

## 10. Testing

### Teststrategie

Die App verfolgt einen mehrschichtigen Testansatz:

| Ebene | Dateien | Fokus |
|---|---|---|
| **Unit Tests** | `formatting_test.dart` | Reine Logik (Formatierung) |
| **Unit Tests** | `core/bike_storage_test.dart` | Storage-Roundtrip, Legacy-Kompatibilität |
| **Unit Tests** | `core/bike_repository_test.dart` | Repository CRUD-Operationen |
| **Widget Tests** | `widget_test.dart` | Smoke Test, App startet korrekt |
| **Integrationstests** | `add_bike_flow_test.dart` | Kompletter Hinzufügen-Flow (E2E im Widget-Test) |

### Tests ausführen

```bash
# Alle Tests
flutter test

# Einzelne Testdatei
flutter test test/core/bike_repository_test.dart

# Mit Coverage
flutter test --coverage

# Coverage-Report generieren (erfordert lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Mocking

- `SharedPreferences.setMockInitialValues({})` für Storage-Tests
- `IBikeStorage`-Interface ermöglicht künftige Mock-Implementierungen für isolierte Repository-Tests

---

## 11. Deployment

### CI/CD

Aktuell ist kein CI/CD-Pipeline konfiguriert.

**Empfehlung:** GitHub Actions mit folgenden Schritten:
```yaml
# .github/workflows/ci.yml (Vorschlag)
- flutter pub get
- flutter analyze
- flutter test
- flutter build apk --release  # oder ios/web
```

### Plattformen

Die App unterstützt folgende Zielplattformen (Konfigurationen vorhanden):

| Plattform | Status | Build-Verzeichnis |
|---|---|---|
| Android | ✅ Konfiguriert | `android/` |
| iOS | ✅ Konfiguriert | `ios/` |
| macOS | ✅ Konfiguriert | `macos/` |
| Web | ✅ Konfiguriert | `web/` |

### App Icon

Konfiguriert über `flutter_launcher_icons` in `pubspec.yaml`:
- Quellbild: `assets/images/app_icon.png`
- Generierung: `flutter pub run flutter_launcher_icons`

---

## 12. Bekannte Probleme / Einschränkungen

1. **Keine Undo-Funktion:** Gelöschte Fahrräder können nicht wiederhergestellt werden
2. **Keine Sortierung/Filterung:** Die Liste zeigt Fahrräder in Einfüge-Reihenfolge
3. **Keine Bildanhänge:** Fotos der Fahrräder können nicht gespeichert werden
4. **SharedPreferences-Limitierung:** Nicht für große Datenmengen geeignet; bei vielen Einträgen könnte die Performance leiden
5. **Kein Cloud-Sync:** Daten sind gerätelokal und gehen bei Deinstallation verloren
6. **Kein Dark Mode:** Nur ein helles Farbschema ist implementiert
7. **Add-Bike-Flow-Test:** Der Test in `add_bike_flow_test.dart` verwendet `DropdownButtonFormField`, die tatsächliche UI nutzt aber ein Custom-`BikeTypeDropdown` mit Bottom-Sheet – der Test könnte fehlschlagen

---

## 13. Zukünftige Verbesserungen

| Priorität | Verbesserung | Beschreibung |
|---|---|---|
| Hoch | **Alternative Persistenz** | Migration zu Hive, Drift oder SQLite für bessere Performance und Typsicherheit |
| Hoch | **Suchfunktion** | Filterung und Suche in der Fahrradliste |
| Mittel | **Dark Mode** | Unterstützung für dunkles Farbschema |
| Mittel | **Bilder** | Foto-Upload für Fahrräder (Kamera/Galerie) |
| Mittel | **Cloud-Sync** | Firebase oder REST-API für geräteübergreifende Synchronisation |
| Mittel | **Sortierung** | Sortierung nach Name, Typ, Kaufdatum, Preis |
| Niedrig | **Export/Import** | CSV- oder JSON-Export der Fahrradliste |
| Niedrig | **Wartungstracker** | Dokumentation von Inspektionen, Reparaturen und Kilometerständen |
| Niedrig | **CI/CD** | GitHub Actions Pipeline für automatisierte Tests und Builds |
| Niedrig | **Barrierefreiheit** | Semantics-Labels und Screen-Reader-Optimierung |
