import 'package:flutter/material.dart';
import 'package:push_jar/widgets/app_top_bar.dart';
import 'package:push_jar/widgets/bottom_nav_bar.dart';

class PushScaffold extends StatelessWidget {
  final Widget body;
  final VoidCallback? onFabPressed;
  final Function(int)? onNavTap;

  const PushScaffold({
    super.key,
    required this.body,
    this.onFabPressed,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppTopBar(),
      body: body,
      floatingActionButton: onFabPressed != null
          ? FloatingActionButton.large(
              backgroundColor: Colors.blue,
              shape: const CircleBorder(),
              splashColor: Colors.pink[200],
              onPressed: onFabPressed,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: PushBottomBar(onTap: onNavTap),
    );
  }
}