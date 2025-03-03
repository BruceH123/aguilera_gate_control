import 'package:aguilera_gate_control/automatic_gate_operation.dart';
import 'package:aguilera_gate_control/gate_response_translation.dart';
//import 'package:aguilera_gate_control/message_translation_old.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';

var smsText = '';
var longLevelName = '';
var globalLongLevelName = '';
var deviceType = '';
var levelsImageHeight = 0.0;
var stdFontSize = 0.0;
var deviceHeight = 0.0;
var imageHeight = 0.0;
var deviceOrientation;
var globalReturn = '';

class ControlCommands extends StatelessWidget {
  const ControlCommands({super.key});

  @override
  Widget build(BuildContext context) {
    // Set Global Variables for display parameters
    Orientation deviceOrientation = MediaQuery.of(context).orientation;
    deviceHeight = MediaQuery.of(context).size.height;
    deviceHeight > 950 ? deviceType = 'Tablet' : deviceType = 'Phone';

        // device = Phone
    if (deviceType == 'Phone' && deviceOrientation == Orientation.portrait)
      imageHeight = MediaQuery.of(context).size.height * 0.4;

    // Orientation Landscape
    if (deviceType == 'Phone' && deviceOrientation == Orientation.landscape)
      imageHeight = MediaQuery.of(context).size.height * 0.8;

    // device = Phone
    if (deviceType == 'Phone' && deviceOrientation == Orientation.portrait)
      levelsImageHeight = MediaQuery.of(context).size.height * 0.22;

    // Orientation Landscape
    if (deviceType == 'Phone' && deviceOrientation == Orientation.landscape)
      levelsImageHeight = MediaQuery.of(context).size.height * 0.6;

    if (deviceType == 'Phone' && deviceOrientation == Orientation.portrait)
      stdFontSize = MediaQuery.of(context).size.height * 0.032;

    // For tall narrow phones
    if (deviceHeight > 810 && deviceOrientation == Orientation.portrait)
      stdFontSize = 22;

    // Orientation Landscape
    if (deviceType == 'Phone' && deviceOrientation == Orientation.landscape)
      stdFontSize = MediaQuery.of(context).size.height * 0.06;

    // deviceType = Tablet
    if (deviceType == 'Tablet' && deviceOrientation == Orientation.portrait)
      stdFontSize = MediaQuery.of(context).size.height * 0.03;

    // Orientation Landscape
    if (deviceType == 'Tablet' && deviceOrientation == Orientation.landscape)
      stdFontSize = MediaQuery.of(context).size.width * 0.03;


    return Scaffold(
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
                        fontSize: stdFontSize+5,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    textAlign: TextAlign.center,
                  )
              )
            ], // children
          )
      ),

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
          SMSTextButton(smsText: '1234#1#', longLevelName: 'Open Gate 30 seconds'),

          SMSTextButton(smsText: '1234#2#', longLevelName: 'Hold Gate Open'),

          SMSTextButton(smsText: '1234#3#', longLevelName: 'Close Gate'),

          SMSTextButton(smsText: 'ago', longLevelName: 'Automatic Gate Operation'),

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
                // set the Level global variables
                deviceOrientation == Orientation.portrait;
                stdFontSize = stdFontSize;
                imageHeight = imageHeight;
                deviceHeight = deviceHeight;
                levelsImageHeight = levelsImageHeight;
                globalLongLevelName = longLevelName;

               // go to Automatic Gate Opening to set opening parameters
                if (smsText == 'ago'){
                  globalReturn = 'ControlCommands';
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AutomaticGateOperation()),
                  ); // Navigator.push
                } //

                 else {
                  // Phone number and message to send
                 String phoneNumber = "19714897051"; // Replace with actual number
                String message = "$smsText";
                _sendSMS(message, [phoneNumber]);
                globalReturn = 'ControlCommands';
                Navigator.push(

                   context,
                   MaterialPageRoute(builder: (context) => GateResponseTranslation()),
                 ); // Navigator.push
                 }  // else
              }, // onPressed

              child: Text(
                longLevelName, // Introductory Level button text
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
