import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
//import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GSM Module',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Smart Home', titleColor: 0xFF00497D),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.titleColor})
      : super(key: key);

  final String title;
  final int titleColor;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int ledOn = 0;
  int fanOn = 0;
  int heaterOn = 0;
  final telephony = Telephony.instance;
  bool isEditing = true;
  late TextEditingController _mobilePhoneController;
  late TextEditingController _passwordController;
  Color textColor = const Color(0xFF00497D);
  String phoneNumber = "";
  String password = "";
  bool canSend = false;
  String _feedbackMessage = "";

  @override
  void initState()
  {
    super.initState();
    _mobilePhoneController = TextEditingController();
    _passwordController = TextEditingController();
    telephony.listenIncomingSms(
        onNewMessage: onMessage, listenInBackground: false);
  }

  onMessage(SmsMessage message) async {
    setState(() {
      _feedbackMessage = message.body ?? "Error reading message body.";
    });
  }

  @override
  void dispose() {
    _mobilePhoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3E6FF),
        title: Text(
          widget.title,
          style: TextStyle(color: Color(widget.titleColor)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF00497D),
          ),
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10),
                  child: Row(
                    children: [
                      Text(
                        'Phone Number',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      // Other widgets here
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _mobilePhoneController,
                          maxLength: 11,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter Phone Number Here',
                            hintStyle: TextStyle(color: textColor),
                            filled: true,
                            fillColor: isEditing
                                ? const Color(0xFFD3E6FF)
                                : Colors.transparent,
                            border: isEditing
                                ? OutlineInputBorder()
                                : InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                          ),
                          style: TextStyle(color: textColor),
                          enabled: isEditing,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        'Password',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _passwordController,
                          maxLength: 5,
                          decoration: InputDecoration(
                            hintText: 'Enter Password Here',
                            hintStyle: TextStyle(color: textColor),
                            filled: true,
                            fillColor: isEditing
                                ? const Color(0xFFD3E6FF)
                                : Colors.transparent,
                            border: isEditing
                                ? OutlineInputBorder()
                                : InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 5, horizontal: 5),
                          ),
                          style: TextStyle(color: textColor),
                          enabled: isEditing,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isEditing = true;
                            textColor = const Color(0xFF00497D);
                            phoneNumber = _mobilePhoneController.text;
                            password = _passwordController.text;
                          });
                          if (phoneNumber.length < 11) {
                            _showPopup('Mobile Phone',
                                'Mobile phone must be 11 number');
                            phoneNumber = "";
                            canSend = false;
                          } else if (password.length < 5) {
                            _showPopup(
                                'Password', 'Password must be 5 characters');
                            password = "";
                            canSend = false;
                          } else {
                            canSend = true;
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFFD3E6FF)),
                        ),
                        child: Text(
                          'Save',
                          style: TextStyle(
                            color: const Color(0xFF00497D),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: ledOn == 1
                                ? const Color(0xFFB6F2AF)
                                : const Color.fromARGB(255, 219, 86, 86),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (canSend) {
                                setState(() {
                                  ledOn = ledOn == 1 ? 0 : 1;
                                  print('LED: $ledOn');
                                  if (ledOn == 1) {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/1',
                                    );
                                    Future.delayed(Duration(seconds: 60), ()
                                    { 
                                        _showPopup('LED State', '$_feedbackMessage');
                                    });

                                    //_showPopup('LED State', '$_feedbackMessage');
                                  } else {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/0',
                                    );
                                    Future.delayed(Duration(seconds: 60), ()
                                    { 
                                        _showPopup('LED State', '$_feedbackMessage');
                                    });
                                    //_showPopup('LED State', '$_feedbackMessage');
                                  }
                                });
                              } else {
                                _showPopup('Error',
                                    'Please enter valid Phone Number & Password');
                              }
                            },
                            icon: Icon(
                              ledOn == 1
                                  ? Icons.lightbulb
                                  : Icons.lightbulb_outline,
                              color: ledOn == 1
                                  ? const Color(0xFF386238)
                                  : Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                            color: ledOn == 1
                                ? const Color(0xFFB6F2AF)
                                : const Color.fromARGB(255, 219, 86, 86),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (canSend) {
                                setState(() {
                                  ledOn = ledOn == 1 ? 0 : 1;
                                  print('LED: $ledOn');
                                  if (ledOn == 1) {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/1',
                                    );
                                    Future.delayed(Duration(seconds: 60), ()
                                    { 
                                        _showPopup('LED State', '$_feedbackMessage');
                                    });
                                    //_showPopup('LED State', '$_feedbackMessage');
                                  } else {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/0',
                                    );
                                    Future.delayed(Duration(seconds: 30), ()
                                    { 
                                        _showPopup('LED State', '$_feedbackMessage');
                                    });
                                    //_showPopup('LED State', '$_feedbackMessage');
                                  }
                                });
                              } else {
                                _showPopup('Error',
                                    'Please enter valid Phone Number & Password');
                              }
                            },
                            child: Text(
                              ledOn == 1 ? 'On' : 'Off',
                              style: TextStyle(
                                color: ledOn == 1
                                    ? const Color(0xFF386238)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: fanOn == 1
                                ? const Color(0xFFB6F2AF)
                                : const Color.fromARGB(255, 219, 86, 86),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (canSend) {
                                setState(() {
                                  fanOn = fanOn == 1 ? 0 : 1;
                                  print('Fan: $fanOn');
                                  if (fanOn == 1) {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/3',
                                    );
                                    _showPopup('Fan State', '$_feedbackMessage');
                                  } else {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/2',
                                    );
                                    _showPopup('Fan State', '$_feedbackMessage');
                                  }
                                });
                              } else {
                                _showPopup('Error',
                                    'Please enter valid Phone Number & Password');
                              }
                            },
                            icon: Icon(
                              fanOn == 1
                                  ? Icons.ac_unit
                                  : Icons.ac_unit_outlined,
                              color: fanOn == 1
                                  ? const Color(0xFF386238)
                                  : Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                            color: fanOn == 1
                                ? const Color(0xFFB6F2AF)
                                : const Color.fromARGB(255, 219, 86, 86),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (canSend) {
                                setState(() {
                                  fanOn = fanOn == 1 ? 0 : 1;
                                  print('Fan: $fanOn');
                                  if (fanOn == 1) {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/3',
                                    );
                                    _showPopup('Fan State', '$_feedbackMessage');
                                  } else {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/2',
                                    );
                                    _showPopup('Fan State', '$_feedbackMessage');
                                  }
                                });
                              } else {
                                _showPopup('Error',
                                    'Please enter valid Phone Number & Password');
                              }
                            },
                            child: Text(
                              fanOn == 1 ? 'On' : 'Off',
                              style: TextStyle(
                                color: fanOn == 1
                                    ? const Color(0xFF386238)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: heaterOn == 1
                                ? const Color(0xFFB6F2AF)
                                : const Color.fromARGB(255, 219, 86, 86),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (canSend) {
                                setState(() {
                                  heaterOn = heaterOn == 1 ? 0 : 1;
                                  print('Heater: $heaterOn');
                                  if (heaterOn == 1) {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/5',
                                    );
                                    _showPopup('Heater State', '$_feedbackMessage');
                                  } else {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/4',
                                    );
                                    _showPopup('Heater State', '$_feedbackMessage');
                                  }
                                });
                              } else {
                                _showPopup('Error',
                                    'Please enter valid Phone Number & Password');
                              }
                            },
                            icon: Icon(
                              heaterOn == 1
                                  ? Icons.heat_pump
                                  : Icons.heat_pump_outlined,
                              color: heaterOn == 1
                                  ? const Color(0xFF386238)
                                  : Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 120,
                          height: 50,
                          decoration: BoxDecoration(
                            color: heaterOn == 1
                                ? const Color(0xFFB6F2AF)
                                : const Color.fromARGB(255, 219, 86, 86),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (canSend) {
                                setState(() {
                                  heaterOn = heaterOn == 1 ? 0 : 1;
                                  print('Heater: $heaterOn');
                                  if (heaterOn == 1) {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/5',
                                    );
                                    _showPopup('Heater State', '$_feedbackMessage');
                                  } else {
                                    telephony.sendSms(
                                      to: phoneNumber,
                                      message: '@' + password + '/4',
                                    );
                                    _showPopup('Heater State', '$_feedbackMessage');
                                  }
                                });
                              } else {
                                _showPopup('Error',
                                    'Please enter valid Phone Number & Password');
                              }
                            },
                            child: Text(
                              heaterOn == 1 ? 'On' : 'Off',
                              style: TextStyle(
                                color: heaterOn == 1
                                    ? const Color(0xFF386238)
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to show popup
  void _showPopup(String device, String action) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$device'),
          content: Text('$action'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}