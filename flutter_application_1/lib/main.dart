import 'package:flutter/material.dart';

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
  bool isEditing = true;
  late TextEditingController _textFieldController;
  Color textColor = const Color(0xFF00497D);
  late String savedText; 

  @override
  void initState() {
    super.initState();
    _textFieldController = TextEditingController();
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }

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
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _textFieldController,
                        maxLength: 11,
                        decoration: InputDecoration(
                          hintText: 'Enter Number Here',
                          hintStyle: TextStyle(color: textColor),
                          filled: true,
                          fillColor: isEditing ? const Color(0xFFD3E6FF) : Colors.transparent,
                          border: isEditing ? OutlineInputBorder() : InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 5), 
                        ),
                        style: TextStyle(color: textColor),
                        enabled: isEditing,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isEditing = false; 
                        textColor = const Color(0xFFD3E6FF); 
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFD3E6FF)),  
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: const Color(0xFF00497D), 
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        isEditing = true; 
                        textColor = const Color(0xFF00497D);
                        savedText = _textFieldController.text; 
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFD3E6FF)), 
                    ),
                    child: Text(
                      'Change',
                      style: TextStyle(
                        color: const Color(0xFF00497D), 
                      ),
                    ),
                  ),
                ],
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
                          color: ledOn == 1 ? const Color(0xFFB6F2AF) : const Color.fromARGB(255, 219, 86, 86),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              ledOn = ledOn == 1 ? 0 : 1;
                              print('LED: $ledOn');
                              if (ledOn == 1) {
                                _showPopup('Light Bulb', 'Turned On');
                              } else {
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
                              if (ledOn == 1) {
                                _showPopup('Light Bulb', 'Turned On');
                              } else {
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
                              if (fanOn == 1) {
                                _showPopup('Fan', 'Turned On');
                              } else {
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
                              if (fanOn == 1) {
                                _showPopup('Fan', 'Turned On');
                              } else {
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
                              if (heaterOn == 1) {
                                _showPopup('Heater', 'Turned On');
                              } else {
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
                              if (heaterOn == 1) {
                                _showPopup('Heater', 'Turned On');
                              } else {
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

  Widget _buildButton(String label, int status, VoidCallback onPressed) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: status == 1 ? const Color(0xFFB6F2AF) : const Color.fromARGB(255, 219, 86, 86),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              status == 1 ? Icons.lightbulb : Icons.lightbulb_outline,
              color: status == 1 ? const Color(0xFF386238) : Colors.white,
              size: 30,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: status == 1 ? const Color(0xFFB6F2AF) : const Color.fromARGB(255, 219, 86, 86),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextButton(
            onPressed: onPressed,
            child: Text(
              status == 1 ? 'On' : 'Off',
              style: TextStyle(
                color: status == 1 ? const Color(0xFF386238) : Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

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
