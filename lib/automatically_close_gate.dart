import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sms/flutter_sms.dart';

class AutomaticGateOpening extends StatefulWidget {
  @override
  _AutomaticGateOpeningState createState() => _AutomaticGateOpeningState();
}

class _AutomaticGateOpeningState extends State<AutomaticGateOpening> {
  String? gateDay;
  String? gateTime;
  TextEditingController timeController = TextEditingController();
  FocusNode timeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    timeController.dispose();
    timeFocusNode.dispose();
    super.dispose();
  }

  void selectDay(String day) {
    setState(() {
      gateDay = day;
    });
  }

  void updateTime(String value) {
    if (value.length == 4) {
      setState(() {
        gateTime = value;
      });
      FocusScope.of(context).unfocus(); // Close the keyboard
    }
  }

  void dismissKeyboard() {
    if (timeFocusNode.hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  void sendGateSMS() async {
    if (gateDay != null && gateTime != null) {
      String smsText = "1234#3#$gateDay#$gateTime#";
      List<String> recipients = ["19714897051"]; // Replace with actual gate controller number

      try {
        await sendSMS(message: smsText, recipients: recipients);
        print("SMS sent: $smsText to ${recipients[0]}");
      } catch (error) {
        print("Failed to send SMS: $error");
      }
    } else {
      print("Please select a day and enter a valid time.");
    }
  }

  @override
  Widget build(BuildContext context) {
    double stdFontSize = 16.0;
    double deviceWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: dismissKeyboard,
      child: Scaffold(
        resizeToAvoidBottomInset: false, // Prevent shifting content when keyboard appears
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Automated Gate Control",
            style: TextStyle(
              color: Colors.black,
              fontSize: stdFontSize,
              fontWeight: FontWeight.bold,
              fontFamily: "Arial",
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              Text(
                "Automatic Gate Opening",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: stdFontSize + 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Arial",
                  // decoration: TextDecoration.underline,
                  decorationThickness: 2.0,
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Weekday Buttons (Left Side)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var day in ["mon", "tue", "wed", "thur", "fri", "sat", "sun"])
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: CupertinoButton(
                              padding: EdgeInsets.zero,
                              onPressed: () => selectDay(day),
                              child: Container(
                                width: deviceWidth * 0.3,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: gateDay == day ? Colors.red : Colors.grey[300],
                                  border: Border.all(color: Colors.red, width: 2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: EdgeInsets.only(left: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: gateDay == day ? Colors.white : Colors.transparent,
                                      ),
                                    ),
                                    Text(
                                      day == "thur" ? "THUR" : day.toUpperCase(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: stdFontSize,
                                        fontFamily: "Arial",
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: gateDay == day ? Colors.red : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // Time Input Box (Right Side)
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                            fontSize: stdFontSize+15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "Arial",
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          width: deviceWidth * 0.4,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            controller: timeController,
                            focusNode: timeFocusNode,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            maxLength: 4,
                            onChanged: updateTime,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              counterText: "",
                            ),
                            style: TextStyle(
                              fontSize: stdFontSize+15,
                              fontFamily: "Arial",
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "24 hour time in four digits no colon",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: stdFontSize  /* - 5*/,
                            fontFamily: "Arial",
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // SEND Button (Bottom Center)
              Padding(
                padding: EdgeInsets.only(bottom: 40, top: 20),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: sendGateSMS,
                  child: Container(
                    width: deviceWidth * 0.6,
                    height: deviceWidth * 0.2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.red, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "SEND",
                      style: TextStyle(
                        fontSize: stdFontSize+10,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Arial",
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],  // children
          ),
        ),
      ),
    );
  }
}

