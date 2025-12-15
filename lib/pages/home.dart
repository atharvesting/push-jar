import 'package:flutter/material.dart';
import 'package:push_jar/push.dart';
import 'package:push_jar/push_db.dart';
import 'package:push_jar/quote.dart';
import 'package:push_jar/services/quote_service.dart';
import 'package:push_jar/widgets/full_scaffold.dart';

class HomePage extends FullScaffold {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends FullScaffoldState<HomePage> {

  Future<void> fetchPush() async {
    List<Push> listi = await PushDatabase.fetchNPushes(3);
    if (!mounted) return;
    setState(() {
      pushes = listi;
    });
  }

  late Future<Quote> futureQuote;

  @override
  void initState() {
    super.initState();
    fetchPush();
    futureQuote = fetchQuote();
  }

  @override
  Widget buildBody(BuildContext context) {

    Widget _buildCard(Push p) {
      return SizedBox(
        width: double.infinity,
        height: 120,
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.blue[100],
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text("${p.title} cc— ${p.tags}"),
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Text(
            "  Hello there!",
            style: TextStyle(
              fontSize: 20, 
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        // Use FutureBuilder to handle async data
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Container(
            height: 120,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: FutureBuilder<Quote>(
              future: futureQuote,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '"${snapshot.data!.quote}"',
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      Text(
                        '— ${snapshot.data!.author}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: Text('No quote available'));
                }
              },
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          color: Colors.blue.shade300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (pushes.isNotEmpty) _buildCard(pushes[0]),
              if (pushes.length > 1) _buildCard(pushes[1]),
              if (pushes.length > 2) _buildCard(pushes[2]),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void handleNavTap(int index) {
    print("Home page nav tap: $index");
  }
}