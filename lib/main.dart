import 'package:clutch/src/pages/Dashboard.dart';
import 'package:flutter/cupertino.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'Cupertino App',
      home: DashBoard(),
      debugShowCheckedModeBanner: false,
    );
  }
}