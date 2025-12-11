import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:push_jar/push.dart';
import 'package:push_jar/push_db.dart';
import 'package:push_jar/widgets/app_top_bar.dart';
import 'package:push_jar/widgets/bottom_nav_bar.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  List<Push> pushes = [];

  @override
  Widget build(BuildContext context) {
    print("MainView build()");
    return Scaffold(
      appBar: buildAppTopBar(),
      body: bodyPart(),
      // floatingActionButton: FloatingActionButton(
      //   shape: const CircleBorder(),
      //   backgroundColor: Colors.blue,
      //   splashColor: Colors.pink[200],
      //   onPressed: () async {
      //     print("FAB Pressed");
      //     final push = Push(
      //       id: DateTime.now().millisecondsSinceEpoch,
      //       title: "DB Test push",
      //       dateTime: DateTime.now(),
      //       tags: ["tag1", "tag2"]
      //     );

      //     await push.insertPush(push);

      //     final result = await Push(
      //       id: 0,
      //       title: "",
      //       dateTime: DateTime.now(),
      //       tags: [],
      //     ).getAllPushes();

      //     setState(() {
      //       pushes = result;
      //     });
      //   },
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            final testPush = Push(
              id: DateTime.now().millisecondsSinceEpoch,
              title: "Test",
              dateTime: DateTime.now(),
              tags: ["a", "b"],
            );

            await PushDatabase.insertPush(testPush);
            final list = await PushDatabase.getAllPushes();
            setState(() {
              pushes = list;
            });

          } catch (e, stack) {
            print("ERROR OCCURRED:");
            print(e);
            print(stack);
          }
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: PushBottomBar(
        onTap: (i) {
          // handle nav taps
        },
      ),
    );
  }

  Column bodyPart() {
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
                onPressed: () {},
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
}