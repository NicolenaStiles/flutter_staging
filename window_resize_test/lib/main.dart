import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MyMainAppState();

}

class _MyMainAppState extends State<MainApp> {
  String _width = "";
  String _height = "";
  String _padding = "";
  String _safeHeight = "";

  void _updateFields() {
    setState(() {

      //In logical pixels
      var width = MediaQuery.of(context).size.width;
      var height = MediaQuery.of(context).size.height;
      var padding = MediaQuery.of(context).padding;
      var safeHeight = height - padding.top - padding.bottom;

      _width = width.toString();
      _height = height.toString(); 
      _padding = padding.toString(); 
      _safeHeight = safeHeight.toString(); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column( 
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Width : $_width'),
              Text('Height : $_height'),
              Text('Padding : $_padding'),
              Text('Safe Height : $_safeHeight'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: _updateFields, 
        tooltip: 'Update screen metrics',
        child: const Icon(Icons.add),
      ),
      ),
    );
  }
}
