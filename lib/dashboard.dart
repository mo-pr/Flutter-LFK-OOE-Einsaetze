import 'package:flutter/material.dart';
import 'api.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<GestureDetector> _alarms = <GestureDetector>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: Center(
          child: ListView(
            children: _alarms,
          )
      ),
    );
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData()async{
    List<GestureDetector> temp = <GestureDetector>[];
    await Api.getWidgetFromAlarm().then((value) => temp=value);
    setState(() {
      _alarms = temp;
    });
  }
}
