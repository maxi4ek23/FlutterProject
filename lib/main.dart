import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const MyHomePage(title: 'Flutter Demo App Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title, super.key});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int letterCounter = 0;
  late String text;
  String magic = 'Wingardium Leviosa';

  void _incrementCounter() {
    setState(() {
      if (text != 'Avada Kedavra') {
        letterCounter = text.replaceAll(' ', '').length;
        magic = 'Wingardium Leviosa';
      } else {
        letterCounter = 0;
        magic = 'You are going to die. Avada Kedavra';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'The number of symbols that u pressed:',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '$letterCounter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Phrase',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    text = value;
                  },),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                magic,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Text('Count'),
      ),
    );
  }
}
