import 'package:bike_manager/models/bike.dart';
import 'package:bike_manager/models/bike_type.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddBikeView extends ConsumerStatefulWidget {
  const AddBikeView({super.key});

  @override
  ConsumerState<AddBikeView> createState() => _AddBikeViewState();
}

class _AddBikeViewState extends ConsumerState<AddBikeView> {
  late final BikeViewModel _bikeViewModel;
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _manufacturerCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  DateTime? _purchaseDate;
  BikeType? _type;

  @override
  void initState() {
    super.initState();
    _bikeViewModel = ref.read(bikeProvider.notifier);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _manufacturerCtrl.dispose();
    _priceCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fahrrad hinzufügen'),
        actions: [
          TextButton.icon(
            onPressed: _onSave,
            icon: const Icon(Icons.save),
            label: const Text('Speichern'),
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Name ist erforderlich'
                  : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<BikeType>(
              value: _type,
              decoration: const InputDecoration(
                labelText: 'Typ',
                border: OutlineInputBorder(),
              ),
              items: BikeType.values
                  .map((t) => DropdownMenuItem(
                        value: t,
                        child: Text(formatBikeType(t)),
                      ))
                  .toList(),
              onChanged: (v) => setState(() => _type = v),
              validator: (v) => v == null ? 'Bitte Typ wählen' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _manufacturerCtrl,
              decoration: const InputDecoration(
                labelText: 'Hersteller (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Kaufdatum (optional)',
                  border: OutlineInputBorder(),
                ),
        child: Text(_purchaseDate == null
          ? 'Nicht gesetzt'
          : formatDate(_purchaseDate!)),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _priceCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Kaufpreis (optional)',
                hintText: 'z. B. 1999.99',
                border: OutlineInputBorder(),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                final parsed = _tryParsePrice(v.trim());
                if (parsed == null) return 'Ungültiger Preis';
                if (parsed < 0) return 'Preis darf nicht negativ sein';
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final initial = _purchaseDate ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1970),
      lastDate: DateTime(now.year + 5),
    );
    if (!mounted) return;
    if (picked != null) {
      setState(() => _purchaseDate = picked);
    }
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameCtrl.text.trim();
    final type = _type!;
    final manufacturer = _manufacturerCtrl.text.trim().isEmpty
        ? null
        : _manufacturerCtrl.text.trim();
    final price = _priceCtrl.text.trim().isEmpty
        ? null
        : _tryParsePrice(_priceCtrl.text.trim());

    final bike = Bike(
      name: name,
      type: type,
      manufacturer: manufacturer,
      purchaseDate: _purchaseDate,
      purchasePrice: price,
    );

    _bikeViewModel.addBike(bike);
    Navigator.of(context).pop();
  }

  // formatting moved to utils/formatting.dart

  double? _tryParsePrice(String v) {
    // Accept comma or dot
    final norm = v.replaceAll(',', '.');
    return double.tryParse(norm);
  }
}
