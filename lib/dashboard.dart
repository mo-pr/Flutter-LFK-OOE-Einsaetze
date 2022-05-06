import 'package:flutter/material.dart';
import 'package:lfkooe_einsaetze_detailed/api.dart';

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => {},
        ),
        title: const Text(
          "Feuerwehreinsatzinfos OÖ",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: const Color(0xffb32b19),
      ),
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
    var api = Api(context);
    await api.getWidgetFromAlarm().then((value) => temp=value);
    setState(() {
      _alarms = temp;
    });
  }
}
