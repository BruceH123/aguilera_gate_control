import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

var smsText = '';
var longLevelName = '';

var imageHeight = 0.0;
var levelsImageHeight = 0.0;
var deviceHeight = 0.0;
var stdFontSize = 0.0;
var deviceWidth = 0.0;

/*void main() {
  DateTime now = DateTime.now();

  // Get the lowercase abbreviated day of the week
  Map<int, String> days = {
    DateTime.monday: "mon",
    DateTime.tuesday: "tue",
    DateTime.wednesday: "wed",
    DateTime.thursday: "thur",
    DateTime.friday: "fri",
    DateTime.saturday: "sat",
    DateTime.sunday: "sun",
  };

  String dayAbbr = days[now.weekday] ?? "unknown";

  // Format the current time as HHMM
  String currentTime = "${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}";

  print("Day Abbreviation: $dayAbbr");
  print("Current Time (HHMM): $currentTime");
}*/

class control_commands extends StatelessWidget {
  const control_commands({super.key});

  @override
  Widget build(BuildContext context) {
    // Set Global Variables for display parameters
    deviceWidth = MediaQuery.of(context).size.width;
    deviceHeight = MediaQuery.of(context).size.height;
    Orientation deviceOrientation = MediaQuery.of(context).orientation;

    // Set imageHeight Phone
    if (deviceOrientation == Orientation.portrait) {
      imageHeight = MediaQuery.of(context).size.height * 0.4;
    }

    // Orientation Landscape
    if (deviceOrientation == Orientation.landscape) {
      imageHeight = MediaQuery.of(context).size.height * 0.8;
    }

    // Set levelsImageHeight for both orientations for the Levels top image.

    if (deviceOrientation == Orientation.portrait) {
      levelsImageHeight = MediaQuery.of(context).size.height * 0.22;
    }

    // Orientation Landscape
    if (deviceOrientation == Orientation.landscape) {
      levelsImageHeight = MediaQuery.of(context).size.height * 0.6;
    }

    // Set stdFontSize
    if (deviceOrientation == Orientation.portrait) {
      stdFontSize = MediaQuery.of(context).size.height * 0.032;
    }

    // For tall narrow phones
    if (deviceHeight > 810 && deviceOrientation == Orientation.portrait) {
      stdFontSize = 22;
    }

    // Orientation Landscape
    if (deviceOrientation == Orientation.landscape) {
      stdFontSize = MediaQuery.of(context).size.height * 0.06;
    }

    //  print('deviceOrientation = $deviceOrientation');
    //  print('deviceHeight = $deviceHeight');
    //  print('deviceWidth = ${MediaQuery.of(context).size.width}');
    //  print('stdFontSize = $stdFontSize');

    var dayAbbr;
    var currentTime;
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(85.00),
          child: Column(
            children: [
              Text(''), // for spacing from top of screen
              AppBar(
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text(
                    'Agilera Gate Control',
                    style: TextStyle(
                        fontSize: stdFontSize,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  ))
            ], // children
          )),

      // Set up the screen in the proper order and permit scrolling
      body: ListView(
        children: <Widget>[
          // WDAA Logo image
          Image.asset(
            'assets/images/Gate1.png',
            fit: BoxFit.contain,
            height: levelsImageHeight,
          ),
          SizedBox(height: 5),

          // Start the rows of TextButtons
          SMSTextButton(
              smsText: '1234#1#', longLevelName: 'Open Gate 30 seconds'),

          SMSTextButton(smsText: '1234#2#', longLevelName: 'Hold Gate Open'),

          SMSTextButton(
              smsText: '1234#3#$dayAbbr#$currentTime#',
                    longLevelName: 'Automaticly Open Gate'),

          SMSTextButton(smsText: '1234#3#', longLevelName: 'Close Gate'),

          SMSTextButton(smsText: '1234#3#',
                    longLevelName: 'Automatically Close Gate'),

          SMSTextButton(smsText: '*22#', longLevelName: 'Gate Status'),

          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0,
                      MediaQuery.of(context).size.height * 0.01, 10.0, 10.0),
                  child: Text(
                    '©2024 Legend Enterprises. Flutter V1.0.1+1',
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ), // Text
                ), // Container
              ),
            ], // children
          ),
        ],
      ),
    );
  } // widget build
} // class control_commands

class SMSTextButton extends StatelessWidget {
  const SMSTextButton({
    super.key,
    required this.smsText,
    required this.longLevelName,
  });

  // Function to send SMS
  void _sendSMS(String message, List<String> recipients) async {
    try {
      String result = await sendSMS(message: message, recipients: recipients);
      print(result); // Log the result
    } catch (error) {
      print("Error: $error"); // Log the error
    }
  }

  final String smsText;
  final String longLevelName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          // alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.fromLTRB(
                //padding between button lines
                0.0,
                MediaQuery.of(context).size.height * 0.03,
                0.0,
                0.0),
            child: MaterialButton(
              onPressed: () {
                // Phone number and message to send
                String phoneNumber =
                    "19714897051"; // Replace with actual number
                String message = "$smsText";
                _sendSMS(message, [phoneNumber]);
              },
              child: Text(
                '$longLevelName', // Introductory Level button text
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: stdFontSize,
                ),
              ),
            ),
          ),
        )
      ], // children
    );
  } // Widget
} // class SMSTextButton
