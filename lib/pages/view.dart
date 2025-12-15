import 'package:flutter/material.dart';
import 'package:push_jar/push_db.dart';
import 'package:push_jar/widgets/full_scaffold.dart';

class MainView extends FullScaffold {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends FullScaffoldState<MainView> {

  @override
  void initState() {
    super.initState();
    loadPushes();
  }

  @override
  Widget buildBody(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blue[50],
              prefixIcon: Icon(Icons.search_rounded),
              hintText: "Search for your next push",
              hintStyle: TextStyle(color: Colors.blue[200]),
              suffixIcon: IconButton(
                onPressed: () async {
                  await PushDatabase.clearPushes();
                  await loadPushes();
                },
                icon: Icon(Icons.filter_list_alt),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              )
            )
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: pushes.length,
            itemBuilder: (context, index) {
              final p = pushes[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                color: Colors.blue[100],
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text("${p.title} — ${p.tags}"),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void handleNavTap(int index) {
    // Your navigation logic here
    print("Tapped nav item: $index");
  }
}