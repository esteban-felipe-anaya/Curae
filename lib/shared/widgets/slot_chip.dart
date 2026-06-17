import 'package:flutter/material.dart';

import '../../core/utils/formatters.dart';

/// Selectable availability slot chip (M3 ChoiceChip).
class SlotChip extends StatelessWidget {
  const SlotChip({
    super.key,
    required this.time,
    required this.selected,
    required this.onSelected,
  });

  final String time;
  final bool selected;
  final ValueChanged<bool> onSelected;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(Fmt.time(time)),
      selected: selected,
      onSelected: onSelected,
      showCheckmark: false,
    );
  }
}
