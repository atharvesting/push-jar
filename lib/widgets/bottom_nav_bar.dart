import 'package:flutter/material.dart';
import 'package:push_jar/pages/home.dart';
import 'package:push_jar/pages/view.dart';
import 'package:push_jar/widgets/full_scaffold.dart';

// Reusable BottomAppBar with FAB notch
class PushBottomBar extends StatelessWidget {
  final void Function(int index)? onTap;
  const PushBottomBar({super.key, this.onTap});

  dynamic gavination (BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.pink[50],
          borderRadius: BorderRadius.circular(20)
        ),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(icon: const Icon(Icons.home), onPressed: () => gavination(context, HomePage())),
              IconButton(icon: const Icon(Icons.search), onPressed: () => gavination(context, MainView())),
              SizedBox(width: 60), // space for FAB
              IconButton(icon: const Icon(Icons.person_2), onPressed: () => onTap?.call(2)),
              IconButton(icon: const Icon(Icons.settings), onPressed: () => onTap?.call(3)),
            ],
          ),
        ),
      ),
    );
  }
}