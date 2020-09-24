

import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return _TreavelPageState();
  }

}

class _TreavelPageState extends State<TravelPage>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text('旅拍'),
      ),
    );
  }

}