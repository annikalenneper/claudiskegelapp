import 'package:claudiskegelapp/styles/constants.dart';
import 'package:claudiskegelapp/utils/routes.dart';
import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.events),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.calendar);
              },
              child: Text('Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}