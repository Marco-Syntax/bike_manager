import 'package:bike_manager/models/bike_type.dart';
import 'package:bike_manager/utils/formatting.dart';
import 'package:bike_manager/views/viewmodels/bike_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bike_manager/utils/form_styles.dart';
import 'package:bike_manager/utils/button_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddBikeView extends ConsumerStatefulWidget {
  const AddBikeView({super.key});

  @override
  ConsumerState<AddBikeView> createState() => _AddBikeView();
}

class _AddBikeView extends ConsumerState<AddBikeView> {
  late final BikeViewModel _bikeViewModel;
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _manufacturerCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  DateTime? _purchaseDate;
  BikeType? _type;

  bool get _isFormValid {
    if (_nameCtrl.text.trim().isEmpty) return false;
    if (_type == null) return false;
    final priceText = _priceCtrl.text.trim();
    if (priceText.isEmpty) return true;
    final parsed = _bikeViewModel.tryParsePrice(priceText);
    if (parsed == null) return false;
    if (parsed < 0) return false;
    return true;
  }

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
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.addBike)),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: () => setState(() {}),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: FormStyles.filled(context, label: l10n.name),
              style: FormStyles.input(context),
              validator:
                  (v) =>
                      (v == null || v.trim().isEmpty)
                          ? l10n.requiredName
                          : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<BikeType>(
              value: _type,
              decoration: FormStyles.filled(context, label: l10n.type),
              style: FormStyles.input(context),
              dropdownColor: theme.colorScheme.surface,
              menuMaxHeight: 300,
              items:
                  BikeType.values
                      .map(
                        (t) => DropdownMenuItem(
                          value: t,
                          child: Text(formatBikeType(context, t)),
                        ),
                      )
                      .toList(),
              onChanged: (v) => setState(() => _type = v),
              validator: (v) => v == null ? l10n.selectType : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _manufacturerCtrl,
              decoration: FormStyles.filled(
                context,
                label: l10n.optionalManufacturer,
              ),
              style: FormStyles.input(context),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: _pickDate,
              child: InputDecorator(
                decoration: FormStyles.filled(
                  context,
                  label: l10n.optionalPurchaseDate,
                ),
                child: Text(
                  _purchaseDate == null
                      ? l10n.notSet
                      : formatDate(_purchaseDate!),
                  style: FormStyles.input(context),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _priceCtrl,
              keyboardType: const TextInputType.numberWithOptions(
                signed: false,
                decimal: true,
              ),
              decoration: FormStyles.filled(
                context,
                label: l10n.optionalPurchasePrice,
                hint: l10n.priceHint,
              ),
              style: FormStyles.input(context),
              validator: (v) {
                if (v == null || v.trim().isEmpty) return null;
                final parsed = _bikeViewModel.tryParsePrice(v.trim());
                if (parsed == null) return l10n.invalidPrice;
                if (parsed < 0) return l10n.negativePrice;
                return null;
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                style: ButtonStyles.primaryFilled(radius: 12),
                onPressed: _isFormValid ? _onSave : null,
                icon: const Icon(Icons.save),
                label: Text(l10n.save),
              ),
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
    final manufacturer =
        _manufacturerCtrl.text.trim().isEmpty
            ? null
            : _manufacturerCtrl.text.trim();
    final priceInput = _priceCtrl.text;

    _bikeViewModel.addBikeFromForm(
      name: name,
      type: type,
      manufacturer: manufacturer,
      purchaseDate: _purchaseDate,
      priceInput: priceInput,
    );
    Navigator.of(context).pop();
  }
}
