import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
  String _dWeb = "";
  String _dTarget = "";

  final isWebMobile = kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
       defaultTargetPlatform == TargetPlatform.android);

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
      _dWeb = kIsWeb.toString();
      _dTarget = defaultTargetPlatform.toString();

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
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
              Text('Is web? : $_dWeb'),
              Text('Platform : $_dTarget'),
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
