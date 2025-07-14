import 'package:flutter/material.dart';

class SettingSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool)? onChanged;

  const SettingSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
