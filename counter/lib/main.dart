import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({ Key? key }) : super(key: key);

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int _counter = 0;

  void _plusOne() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightGreen,
        appBar: AppBar(
          title: const Text('Counter App'),
        ),
        body: Center(
          child: Text(
            '$_counter',
            style: TextStyle(
              fontSize: 60, 
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange[300]
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.add_box_outlined), 
            onPressed: () { 
              _plusOne();
            },
          ),
          onPressed: () {},
        ),

      ),
    );
  }
}
