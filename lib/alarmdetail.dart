import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';

class AlarmDetail extends StatefulWidget {
  final String alarmData;

  const AlarmDetail(this.alarmData, {Key? key}) : super(key: key);

  @override
  State<AlarmDetail> createState() => _AlarmDetailState();
}

class _AlarmDetailState extends State<AlarmDetail> {
  dynamic alarm;

  @override
  void initState() {
    alarm = jsonDecode(widget.alarmData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => {Navigator.pop(context)},
        ),
        title: const Text(
          "Feuerwehreinsatzinfos OÖ",
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: const Color(0xffb32b19),
      ),
      body: Stack(
        children: [
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(alarm['wgs84']['lat'], alarm['wgs84']['lng']),
                zoom: 15.5,
              ),
              layers: [
                TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']),
                MarkerLayerOptions(
                  markers: [
                    Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(
                            alarm['wgs84']['lat'], alarm['wgs84']['lng']),
                        builder: (ctx) => const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                            )),
                  ],
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () => {print("Alarmdetail clicked!!!")},
                child: Container(
                  child: Card(
                    margin: EdgeInsets.all(5.h),
                    elevation: 6,
                    shadowColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        alarm['adresse']['ecompl'] != null
                            ? "Einsatz: " +
                                alarm['num1'] +
                                "\nEinsatzart: " +
                                alarm['einsatzsubtyp']['text'] +
                                "\nBezirk: " +
                                alarm['bezirk']['text'] +
                                "\nDauer: " +
                                alarm['startzeit'] +
                                "\nAlarmstufe: " +
                                alarm['alarmstufe'].toString() +
                                "\n\nZusatz: " +
                                alarm['adresse']['ecompl']
                            : "Einsatz: " +
                                alarm['num1'] +
                                "\nEinsatzart: " +
                                alarm['einsatzsubtyp']['text'] +
                                "\nBezirk: " +
                                alarm['bezirk']['text'] +
                                "\nDauer: " +
                                alarm['startzeit'] +
                                "\nAlarmstufe: " +
                                alarm['alarmstufe'].toString(),
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
