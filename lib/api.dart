import 'dart:convert';
import 'dart:core';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lfkooe_einsaetze_detailed/alarmdetail.dart';
import 'package:sizer/sizer.dart';

class Api {
  BuildContext context;

  Api(this.context);

  static const String currentURL =
      "https://cf-intranet.ooelfv.at/webext2/rss/json_laufend.txt";
  static const String dailyURL =
      "https://cf-intranet.ooelfv.at/webext2/rss/json_taeglich.txt";
  static const String twoDayURL =
      "https://cf-intranet.ooelfv.at/webext2/rss/json_2tage.txt";

  Future<String> _getDataFromAPI() async {
    String body = "";
    http.Response response = await http.get(Uri.parse(currentURL));
    if (response.statusCode == 200) {
      body = response.body.toString();
    }
    return body;
  }

  Future<List<GestureDetector>> getWidgetFromAlarm() async {
    String data = "";
    List<String> alarmStrings = <String>[];
    List<GestureDetector> alarmContainers = <GestureDetector>[];
    await _getDataFromAPI().then((value) => data = value);
    final alarms = jsonDecode(data);
    int alarmCnt = alarms['cnt_einsaetze'] as int;
    for (int i = 0; i < alarmCnt; i++) {
      alarmStrings
          .add(jsonEncode(alarms['einsaetze'][i.toString()]['einsatz']));
    }
    for (String item in alarmStrings) {
      Color alarmColor; //= Color(0xFFffffff);
      final alarm = jsonDecode(item);
      if (alarm['einsatzart'] == "BRAND") {
        alarmColor = const Color(0xFFcc0000);
      } else if (alarm['einsatzart'] == "PERSON") {
        alarmColor = const Color(0xFFffff00);
      } else if (alarm['einsatzart'] == "TEE") {
        alarmColor = const Color(0xFF0000ff);
      } else if (alarm['einsatzart'] == "UNWETTER") {
        alarmColor = const Color(0xFF009933);
      } else /*else if (alarm['einsatzart'] == "SONSTIGE")*/ {
        alarmColor = const Color(0xFF000000);
      }
      alarmContainers.add(GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AlarmDetail(jsonEncode(alarm))),
          )
        },
        child: Card(
          child: Row(
            children: [
              Container(
                height: 15.h,
                width: 8.w,
                color: alarmColor,
              ),
              Container(
                height: 15.h,
                padding: EdgeInsets.all(5.w),
                child: Text(
                  alarm['bezirk']['text'] +
                      "\n" +
                      alarm['adresse']['emun'] +
                      "\n" +
                      alarm['einsatzsubtyp']['text'] +
                      "\n" +
                      alarm['startzeit'] +
                      "\n" +
                      "Anzahl der Feuerwehren: " +
                      alarm['cntfeuerwehren'].toString(),
                ),
              ),
            ],
          ),
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(4.w, 0.5.h, 4.w, 0.5.h),
        ),
      ));
    }
    return alarmContainers;
  }
}
