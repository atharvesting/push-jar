import 'package:flutter/material.dart';

// Reusable BottomAppBar with FAB notch
class PushBottomBar extends StatelessWidget {
  final void Function(int index)? onTap;
  const PushBottomBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(icon: const Icon(Icons.home), onPressed: () => onTap?.call(0)),
          IconButton(icon: const Icon(Icons.search), onPressed: () => onTap?.call(1)),
          const SizedBox(width: 48),
          IconButton(icon: const Icon(Icons.person_2), onPressed: () => onTap?.call(2)),
          IconButton(icon: const Icon(Icons.settings), onPressed: () => onTap?.call(3)),
        ],
      ),
    );
  }
}