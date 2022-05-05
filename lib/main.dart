import 'package:flutter/material.dart';
import 'package:lfkooe_einsaetze_detailed/dashboard.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          color: Colors.white,
          home: Dashboard(),
        );
      },
    );
  }
}
