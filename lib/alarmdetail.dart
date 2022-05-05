import 'package:flutter/material.dart';

class AlarmDetail extends StatefulWidget {
  final String alarmData;
  const AlarmDetail(this.alarmData, {Key? key}) : super(key: key);

  @override
  State<AlarmDetail> createState() => _AlarmDetailState();
}

class _AlarmDetailState extends State<AlarmDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text(widget.alarmData),);
  }
}
