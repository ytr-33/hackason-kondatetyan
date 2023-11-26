// custom_speed_dial.dart
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CustomSpeedDial extends StatelessWidget {
  final VoidCallback onGetMenuTap;
  final VoidCallback onSelectedTap;
  final VoidCallback onAddTap;
  final VoidCallback onClearCheckTap;

  const CustomSpeedDial({
    Key? key,
    required this.onGetMenuTap,
    required this.onSelectedTap,
    required this.onAddTap,
    required this.onClearCheckTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.check),
          label: 'Get Menu',
          onTap: onGetMenuTap,
        ),
        SpeedDialChild(
          child: const Icon(Icons.list),
          label: 'Selected',
          onTap: onSelectedTap,
        ),
        SpeedDialChild(
          child: const Icon(Icons.add),
          label: 'Add Ingredient',
          onTap: onAddTap,
        ),
        SpeedDialChild(
          child: const Icon(Icons.clear),
          label: 'Clear Check',
          onTap: onClearCheckTap,
        ),
      ],
    );
  }
}
