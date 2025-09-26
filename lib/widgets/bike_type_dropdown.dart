import 'package:bike_manager/models/bike_type.dart';
import 'package:bike_manager/widgets/bike_type_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:bike_manager/utils/formatting.dart';

class BikeTypeDropdown extends FormField<BikeType> {
  BikeTypeDropdown({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
    required ValueChanged<BikeType?> onChanged,
    String? label,
  }) : super(
         builder: (state) {
           final context = state.context;
           final theme = Theme.of(context);

           Widget displayChild;
           if (state.value == null) {
             displayChild = Text(
               AppLocalizations.of(context).chooseType,
               style: theme.textTheme.bodyMedium?.copyWith(
                 color: theme.hintColor,
               ),
             );
           } else {
             displayChild = Row(
               children: [
                 BikeTypeAvatar(type: state.value!, radius: 16, iconSize: 14),
                 const SizedBox(width: 12),
                 Expanded(child: Text(formatBikeType(context, state.value!))),
               ],
             );
           }

           return GestureDetector(
             onTap: () async {
               final selected = await showModalBottomSheet<BikeType>(
                 context: context,
                 shape: const RoundedRectangleBorder(
                   borderRadius: BorderRadius.vertical(
                     top: Radius.circular(16),
                   ),
                 ),
                 builder: (ctx) {
                   return SafeArea(
                     child: ListView.separated(
                       shrinkWrap: true,
                       padding: const EdgeInsets.symmetric(vertical: 8),
                       itemBuilder: (c, i) {
                         final t = BikeType.values[i];
                         return ListTile(
                           leading: BikeTypeAvatar(
                             type: t,
                             radius: 20,
                             iconSize: 18,
                           ),
                           title: Text(formatBikeType(ctx, t)),
                           onTap: () => Navigator.of(ctx).pop(t),
                         );
                       },
                       separatorBuilder: (_, __) => const Divider(height: 1),
                       itemCount: BikeType.values.length,
                     ),
                   );
                 },
               );
               if (selected != null) {
                 state.didChange(selected);
                 onChanged(selected);
               }
             },
             child: InputDecorator(
               decoration: InputDecoration(
                 labelText: label,
                 filled: true,
                 border: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(8),
                 ),
               ),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Expanded(child: displayChild),
                   const SizedBox(width: 8),
                   Icon(
                     Icons.keyboard_arrow_down,
                     color: theme.iconTheme.color,
                   ),
                 ],
               ),
             ),
           );
         },
       );
}
