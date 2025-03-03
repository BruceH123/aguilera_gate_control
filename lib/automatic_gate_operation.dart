import 'package:aguilera_gate_control/automatically_close_gate.dart';
import 'package:aguilera_gate_control/automatically_open_gate.dart';
import 'package:aguilera_gate_control/gate_response_translation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'control_commands.dart';
import 'package:aguilera_gate_control/automatic_gate_operation.dart';

var smsText1 = '';

class AutomaticGateOperation extends StatelessWidget {
  const AutomaticGateOperation({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ControlCommands()),
                      ); // Navigator.push
                    }
                  ),
                  elevation: 0,
                  title: Text(
                    'Automatic Gate Operation',
                    style: TextStyle(
                        fontSize: stdFontSize+3,
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
          SMSTextButton(smsText1: 'aog', longLevelName: 'Automatically Open Gate'),

          SMSTextButton(smsText1: 'acg', longLevelName: 'Automatically Close Gate'),

          SMSTextButton(smsText1: '*24#', longLevelName: 'Show Automatic Gate \nOperation Requests'),

          SMSTextButton(smsText1: '1234*#', longLevelName: 'Delete All Automatic \nGate Operation Requests'),

          SMSTextButton(smsText1: '*22#', longLevelName: 'Gate Status'),
        ],
      ),
    );
  } // widget build
} // class control_commands

class SMSTextButton extends StatelessWidget {
   SMSTextButton({
    super.key,
    required this.smsText1,
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

  final String smsText1;
  String longLevelName;

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
               /* stdFontSize = stdFontSize;
                imageHeight = imageHeight;
                deviceHeight = deviceHeight;
                levelsImageHeight = levelsImageHeight;
                deviceOrientation == Orientation.portrait;*/
              //  longLevelName = longLevelName;

                // go to Automatic Gate Opening to set opening parameters
                if (smsText1 == 'aog'){
                  globalLongLevelName ='Automatically Open Gate';
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AutomaticGateOpening()),
                  ); // Navigator.push
                } //

                else if (smsText1 == 'acg'){
                  globalLongLevelName ='Automatically Close Gate';
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AutomaticGateClosing()),
                  ); // Navigator.push
                } //

                else {
                  // Phone number and message to send
                  String phoneNumber = "19714897051"; // Replace with actual number
                  String message = "$smsText1";
                  _sendSMS(message, [phoneNumber]);
                  globalLongLevelName = longLevelName;
                  globalReturn = 'AutomaticGateOperation';
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GateResponseTranslation()), // Navigator.push
                  );  // Navigator.push
                }  // else
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
