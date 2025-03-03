import 'package:aguilera_gate_control/automatic_gate_operation.dart';
import 'package:aguilera_gate_control/control_commands.dart';
import 'package:flutter/material.dart';

class GateResponseTranslation extends StatefulWidget {
  @override
  _GateResponseTranslationState createState() => _GateResponseTranslationState();
}

class _GateResponseTranslationState extends State<GateResponseTranslation> {
  double stdFontSize = 18.0;
 // String globalLongLevelName = "";
  String gateResponse = "";
  String gateResponseTranslation = "";


  // Individual styles for each line
  List<TextStyle> textStyles = [];

  @override
  void initState() {
    super.initState();
    _initializeTextStyles();
    _updateGateResponse();
  }

  void _initializeTextStyles() {
    textStyles = [
      TextStyle(fontSize: stdFontSize + 5, fontWeight: FontWeight.bold, color: Colors.black, height: 2), // 0
      TextStyle(fontSize: stdFontSize+4, fontWeight: FontWeight.bold, color: Colors.blue, height: 1.3),  // 1
      TextStyle(fontSize: stdFontSize + 5, fontWeight: FontWeight.bold, color: Colors.black, height: 2),  // 2
      TextStyle(fontSize: stdFontSize + 5, fontWeight: FontWeight.bold, color: Colors.black, height: 2),  // 3
      TextStyle(fontSize: stdFontSize+4, fontWeight: FontWeight.bold, color: Colors.green, height: 1.3),  // 4
      TextStyle(fontSize: stdFontSize + 5, fontWeight: FontWeight.bold, color: Colors.black, height: 2),  // 5
      TextStyle(fontSize: stdFontSize + 5, fontWeight: FontWeight.bold, color: Colors.black, height: 2),  // 6
      TextStyle(fontSize: stdFontSize+4, fontWeight: FontWeight.bold, color: Colors.red, height: 1.3),  // 7
    ];
  }

  void _updateGateResponse() {
    switch (globalLongLevelName) {
      case 'Open Gate 30 seconds':
        gateResponse = 'Output 1 Opened';
        gateResponseTranslation = 'Opened for 30 seconds';
        break;
      case 'Hold Gate Open':
        gateResponse = 'Output 1 Held Open';
        gateResponseTranslation = 'Held Open';
        break;
      case 'Close Gate':
        gateResponse = 'Output 1 Closed';
        gateResponseTranslation = 'Closed';
        break;
      case 'Gate Status':
        gateResponse = 'Open Relay 1 = 0ff Relay 2 = off\nOpen Relay 1 = on Relay 2 = off';
        gateResponseTranslation = 'Closed\nOpen';
        break;
      case 'Automatically Open Gate':
        gateResponse = '1234#2#mon#1200#\nOK';
        gateResponseTranslation = 'Opened Monday at 12:00pm';
        break;
      case 'Automatically Close Gate':
        gateResponse = '1234#3#mon#1200#\nOK';
        gateResponseTranslation = 'Closed Monday at 12:00pm';
        break;
      case 'Show Automatic Gate \nOperation Requests':
        gateResponse = 'Automatic Relay Times F2 R1 Mon 1200';
        gateResponseTranslation = 'Open Monday at 12:00pm';
        break;
      case 'Delete All Automatic \nGate Operation Requests':
        gateResponse = '1234*#\nOK';
        gateResponseTranslation = 'All Automatic Gate \nRequests Deleted';
        break;
        default:
        gateResponse = 'Unknown Command';
        gateResponseTranslation = 'Unknown Response';
        print('Unknown Gate Command');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('gateResponseTranslation globalLongLevelName: $globalLongLevelName');
    print('gateResponseTranslation globalReturn $globalReturn');
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        // brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              // if from LevelsInfo return there
              if (globalReturn == 'AutomaticGateOperation')
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AutomaticGateOperation()),
                ); // Navigator.push

              else Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ControlCommands()),
              ); // Navigator.push

            } // onPressed
        ),
        title: Text('Gate Response',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: stdFontSize+7,
            )
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildText('Command', 0),
              _buildText(globalLongLevelName, 1),
              _buildText('', 2),
              _buildText('Gate Response', 3),
              _buildText(gateResponse, 4),
              _buildText('', 5),
              _buildText('Gate will be:', 6),
              _buildText(gateResponseTranslation, 7),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ControlCommands()),
                  ); // Navigator.push
                },
                child: Text('Back to Aguilera Gate Control',
                    style: TextStyle(fontSize: stdFontSize, fontWeight: FontWeight.bold,
                      color: Colors.black, height: 2),
                ),
              ),
            ],  // children
          ),
        ),
      ),
    );
  }  // build

  Widget _buildText(String text, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: textStyles[index],
        textAlign: TextAlign.center,
      ),
    );
  }  // _buildText
}  // _GateResponseTranslationState
