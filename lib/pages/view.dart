import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: bodyPart(),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.blue,
        splashColor: Colors.pink[200],
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(icon: Icon(Icons.home), onPressed: () {}),
            IconButton(icon: Icon(Icons.search), onPressed: () {}),
            SizedBox(width: 32), // space for the FAB notch
            IconButton(icon: Icon(Icons.person_2), onPressed: () {}),
            IconButton(icon: Icon(Icons.settings), onPressed: () {}),
          ],
        )
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
                onPressed:() {},
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
          child: ListView(
            padding: EdgeInsets.all(0),
            children: [
            for (int i = 1; i <= 40; i++)
              Card(
                margin: EdgeInsets.symmetric(
                  vertical: 8, 
                  horizontal: 20
                ),
                color: Colors.blue[100],
                elevation: 2,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("Push x $i"),
                )
              )
            ],
          ),
        ),
      ],
    );
  }
}

AppBar appBar() {
  return AppBar(
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 32,
          width: 32,
          child: SvgPicture.asset(
            'assets/icons/3LC.svg',
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(width: 6),
        Text(
          "Push Jar!", 
          style: GoogleFonts.playfairDisplay(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            )
        ),
      ],
    ),
    actions: [
      Text(
        "V0.1\nAll rights reserved",
        textAlign: TextAlign.right,
        style: GoogleFonts.playfairDisplay(
          fontSize: 11,
        ),
        ),
      SizedBox(width: 20),
    ],
  );
}