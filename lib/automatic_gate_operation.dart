import 'package:aguilera_gate_control/automatically_open_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';

var smsText = '';
var longLevelName = '';

var imageHeight = 0.0;
var levelsImageHeight = 0.0;
var deviceHeight = 0.0;
var stdFontSize = 0.0;
var deviceWidth = 0.0;
var deviceOrientation;

class AutomaticGateOperation extends StatelessWidget {
  const AutomaticGateOperation({super.key});

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
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
                    onPressed: () => Navigator.pop(context),
                  ),
                  elevation: 0,
                  title: Text(
                    'Automatic Gate Operation',
                    style: TextStyle(
                        fontSize: stdFontSize,
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
            'assets/images/Gate2.png',
            fit: BoxFit.contain,
            height: levelsImageHeight,
          ),
          SizedBox(height: 5),

          // Start the rows of TextButtons
          SMSTextButton(smsText: 'aog', longLevelName: 'Automatically Open Gate'),

          SMSTextButton(smsText: '', longLevelName: 'Automatically Close Gate'),

          SMSTextButton(smsText: '*24#', longLevelName: 'Automatic Gate \nOperation Requests'),

          SMSTextButton(smsText: '1234*#', longLevelName: 'Delete All Automatic \nGate Operation Requests'),

          SMSTextButton(smsText: '*24#', longLevelName: 'Gate Status'),
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
                stdFontSize = stdFontSize;
                imageHeight = imageHeight;
                deviceHeight = deviceHeight;
                levelsImageHeight = levelsImageHeight;
                deviceOrientation == Orientation.portrait;

                // go to Automatic Gate Opening to set opening parameters
                if (smsText == 'aog'){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AutomaticGateOpening()),
                  ); // Navigator.push
                } //

                else {
                  // Phone number and message to send
                  String phoneNumber = "19714897051"; // Replace with actual number
                  String message = "$smsText";
                  _sendSMS(message, [phoneNumber]);}

              }, // onPressed

              child: Text(
                longLevelName, // Introductory Level button text
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: stdFontSize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        )
      ], // children
    );
  } // Widget
} // class SMSTextButton
