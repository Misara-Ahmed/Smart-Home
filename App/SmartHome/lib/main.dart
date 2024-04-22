import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';

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
      home: const MyHomePage(title: 'Home Page', titleColor: 0xFF00497D),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFD3E6FF),
        title: Text(
          widget.title,
          style: TextStyle(color: Color(widget.titleColor)),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF00497D),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ledOn == 1 ? const Color(0xFFB6F2AF) : const Color.fromARGB(255, 219, 86, 86),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              ledOn = ledOn == 1 ? 0 : 1;
                              print('LED: $ledOn');
                              if (ledOn == 1)
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/1",
                                );
                                _showPopup('Light Bulb', 'Turned On');
                              }
                              else
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/0",
                                );
                                _showPopup('Light Bulb', 'Turned Off');
                              }
                            });
                          },
                          icon: Icon(
                            ledOn == 1 ? Icons.lightbulb : Icons.lightbulb_outline,
                            color: ledOn == 1 ? const Color(0xFF386238) : Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: ledOn == 1 ? const Color(0xFFB6F2AF) : const Color.fromARGB(255, 219, 86, 86),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              ledOn = ledOn == 1 ? 0 : 1;
                              print('LED: $ledOn');
                              if (ledOn == 1)
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/1",
                                );

                                _showPopup('Light Bulb', 'Turned On');
                              }
                              else
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/0",
                                );
                                _showPopup('Light Bulb', 'Turned Off');
                              }
                            });
                          },
                          child: Text(
                            ledOn == 1 ? 'On' : 'Off',
                            style: TextStyle(
                              color: ledOn == 1 ? const Color(0xFF386238) : Colors.white,
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
                          color: fanOn == 1 ? const Color(0xFFB6F2AF) : const Color.fromARGB(255, 219, 86, 86),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              fanOn = fanOn == 1 ? 0 : 1;
                              print('Fan: $fanOn');
                              if (fanOn == 1)
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/3",
                                );
                                _showPopup('Fan', 'Turned On');
                              }
                              else
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/2",
                                );
                                _showPopup('Fan', 'Turned Off');
                              }
                            });
                          },
                          icon: Icon(
                            fanOn == 1 ? Icons.ac_unit : Icons.ac_unit_outlined,
                            color: fanOn == 1 ? const Color(0xFF386238) : Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: fanOn == 1 ? const Color(0xFFB6F2AF) : const Color.fromARGB(255, 219, 86, 86),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              fanOn = fanOn == 1 ? 0 : 1;
                              print('Fan: $fanOn');
                              if (fanOn == 1)
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/3",
                                );
                                _showPopup('Fan', 'Turned On');
                              }
                              else
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/2",
                                );
                                _showPopup('Fan', 'Turned Off');
                              }
                            });
                          },
                          child: Text(
                            fanOn == 1 ? 'On' : 'Off',
                            style: TextStyle(
                              color: fanOn == 1 ? const Color(0xFF386238) : Colors.white,
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
                          color: heaterOn == 1 ? const Color(0xFFB6F2AF) : const Color.fromARGB(255, 219, 86, 86),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              heaterOn = heaterOn == 1 ? 0 : 1;
                              print('Heater: $heaterOn');
                              if (heaterOn == 1)
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/5",
                                );
                                _showPopup('Heater', 'Turned On');
                              } else
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/4",
                                );
                                _showPopup('Heater', 'Turned Off');
                              }
                            });
                          },
                          icon: Icon(
                            heaterOn == 1 ? Icons.heat_pump : Icons.heat_pump_outlined,
                            color: heaterOn == 1 ? const Color(0xFF386238) : Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 150,
                        height: 50,
                        decoration: BoxDecoration(
                          color: heaterOn == 1 ? const Color(0xFFB6F2AF) : const Color.fromARGB(255, 219, 86, 86),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              heaterOn = heaterOn == 1 ? 0 : 1;
                              print('Heater: $heaterOn');
                              if (heaterOn == 1)
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/5",
                                );
                                _showPopup('Heater', 'Turned On');
                              }
                              else
                              {
                                telephony.sendSms(
                                  to: "01157127253",
                                  message: "@RSMMM/4",
                                );
                                _showPopup('Heater', 'Turned Off');
                              }
                            });
                          },
                          child: Text(
                            heaterOn == 1 ? 'On' : 'Off',
                            style: TextStyle(
                              color: heaterOn == 1 ? const Color(0xFF386238) : Colors.white,
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
