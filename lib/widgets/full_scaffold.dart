import 'package:flutter/material.dart';
import 'package:push_jar/push.dart';
import 'package:push_jar/push_db.dart';
import 'package:push_jar/widgets/push_scaffold.dart';

/// Base scaffold that includes common functionality like push loading and input dialog
abstract class FullScaffold extends StatefulWidget {
  const FullScaffold({super.key});
}

abstract class FullScaffoldState<T extends FullScaffold> extends State<T> {
  List<Push> pushes = [];

    @override
  void initState() {
    super.initState();
    // REMOVED: loadPushes() - let child pages decide what to load
  }

  Future<void> loadPushes() async {
    final list = await PushDatabase.getAllPushes();
    if (!mounted) return;
    setState(() {
      pushes = list;
    });
  }

  /// Show dialog to input new push details
  Future<void> showInputDialog() async {
    final titleController = TextEditingController();
    final tagsController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.fitness_center),
              SizedBox(width: 8),
              Text("Enter Push Details")
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "e.g., Morning Workout"
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: tagsController,
                decoration: InputDecoration(
                  labelText: "Tags (comma separated)",
                  hintText: "e.g., cardio, strength"
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                if (titleController.text.isNotEmpty) {
                  final tags = tagsController.text
                      .split(',')
                      .map((e) => e.trim())
                      .where((e) => e.isNotEmpty)
                      .toList();

                  final newPush = Push(
                    id: DateTime.now().millisecondsSinceEpoch,
                    title: titleController.text,
                    dateTime: DateTime.now(),
                    tags: tags,
                  );

                  await PushDatabase.insertPush(newPush);
                  await loadPushes();
                  Navigator.pop(context);
                }
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  /// Handle FAB press - shows input dialog and reloads
  Future<void> handleFabPress() async {
    try {
      await showInputDialog();
    } catch (e, stack) {
      print("ERROR OCCURRED:");
      print(e);
      print(stack);
    }
  }

  /// Override this to provide your page body
  Widget buildBody(BuildContext context);

  /// Override this to handle navigation taps (optional)
  void handleNavTap(int index) {
    // Default: do nothing
  }

  @override
  Widget build(BuildContext context) {
    return PushScaffold(
      body: buildBody(context),
      onFabPressed: handleFabPress,
      onNavTap: handleNavTap,
    );
  }
}