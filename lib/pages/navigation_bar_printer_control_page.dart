import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:spero_app_/widgets/%C4%B1con_buttons.dart';
import 'package:spero_app_/widgets/buttons.dart';
import 'package:http/http.dart' as http;

class NavigatorBarPrinterControlPage extends StatefulWidget {
  NavigatorBarPrinterControlPage(
      {super.key, required this.Ip, required this.Api});
  final String Ip;
  final String Api;

  @override
  State<NavigatorBarPrinterControlPage> createState() =>
      _NavigatorBarPrinterControlPageState();
}

class _NavigatorBarPrinterControlPageState
    extends State<NavigatorBarPrinterControlPage> {
  int _selectedIndex = 0;
  double multIplier = 1;
  String printerStatus = '';
  double _tablePosition = 0.0;

  final String portName = '/dev/ttyACM0';
  final int baudRate = 9600;

  final String messageToSend = '[CMD] MotorForward|123\n';

  final octoPrintUrl = 'http://192.168.1.102/api';
  int extruderTemp = 0;

  void _onButtonTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (_selectedIndex == 0) {
        multIplier = 0.1;
      } else if (_selectedIndex == 1) {
        multIplier = 1.0;
      } else if (_selectedIndex == 2) {
        multIplier = 10.0;
      } else if (_selectedIndex == 3) {
        multIplier = 100;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Expanded(
          child: Column(
            children: [
              Column(children: [
                Text("Motor Move",style: TextStyle(fontSize: 20,),),

                Button(
                  buttonText: "forward",
                  butonColor: Colors.red,
                  textColor: Colors.white,
                  radius: 10,
                  height: 60,
                  buttonIcon: Center(),
                  onPress: () {sendDeviceControl('forward',widget.Ip,widget.Api);},
                ),
                Button(
                  buttonText: "backword",
                  butonColor: Colors.red,
                  textColor: Colors.white,
                  radius: 10,
                  height: 60,
                  buttonIcon: Center(),
                  onPress: () {sendDeviceControl('backword',widget.Ip,widget.Api);},
                ),
                Button(
                  buttonText: "eject",
                  butonColor: Colors.red,
                  textColor: Colors.white,
                  radius: 10,
                  height: 60,
                  buttonIcon: Center(),
                  onPress: () {sendDeviceControl('eject',widget.Ip,widget.Api);},
                ),
                Button(
                  buttonText: "stop",
                  butonColor: Colors.red,
                  textColor: Colors.white,
                  radius: 10,
                  height: 60,
                  buttonIcon: Center(),
                  onPress: () {sendDeviceControl('stop',widget.Ip,widget.Api);},
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "X/Y",
                    style: TextStyle(fontSize: 22),
                  ),
                  const Text("Z", style: TextStyle(fontSize: 22)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButtons(
                        buttonIcon: const Icon(Icons.arrow_upward),
                        onPress: () {
                          debugPrint(
                              multIplier.toString() + widget.Api + widget.Ip);

                          setMove(
                              "x", multIplier.toInt(), widget.Ip, widget.Api);
                        },
                      ),
                      IconButtons(
                        buttonIcon: const Icon(Icons.arrow_upward),
                        onPress: () {
                          setMove(
                              "z", multIplier.toInt(), widget.Ip, widget.Api);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            IconButtons(
                                buttonIcon:
                                    const Icon(Icons.arrow_back_rounded),
                                onPress: () {
                                  setMove("-y", multIplier.toInt(), widget.Ip,
                                      widget.Api);
                                }),
                            const SizedBox(
                              width: 15,
                            ),
                            IconButtons(
                                buttonIcon: const Icon(Icons.home),
                                onPress: () {}),
                            const SizedBox(
                              width: 15,
                            ),
                            IconButtons(
                                buttonIcon: const Icon(Icons.arrow_forward),
                                onPress: () {
                                  setMove("y", multIplier.toInt(), widget.Ip,
                                      widget.Api);
                                }),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: IconButtons(
                            buttonIcon: const Icon(Icons.home),
                            onPress: () => () {}),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButtons(
                        buttonIcon: const Icon(Icons.arrow_downward_outlined),
                        onPress: () {
                          setMove(
                              "-x", multIplier.toInt(), widget.Ip, widget.Api);
                        }),
                    IconButtons(
                        buttonIcon: const Icon(Icons.arrow_downward_outlined),
                        onPress: () {
                          setMove(
                              "-z", multIplier.toInt(), widget.Ip, widget.Api);
                        }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _onButtonTapped(0),
                      child: Text('0.1'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _selectedIndex == 0 ? Colors.red : Colors.blue,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _onButtonTapped(1),
                      child: Text('1'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _selectedIndex == 1 ? Colors.red : Colors.blue,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _onButtonTapped(2),
                      child: Text('10'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _selectedIndex == 2 ? Colors.red : Colors.blue,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _onButtonTapped(3),
                      child: Text('100'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _selectedIndex == 3 ? Colors.red : Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendDeviceControl(String data, String Ip, String Api) async {
    try {
      final json = {'request': data};
      final response = await Dio().post(
        '${Ip}plugin/speroplugin/device-control',
        options: Options(
          headers: {
            'X-Api-Key': Api,
          },
          contentType: Headers.jsonContentType,
        ),
        data: json,
      );

      if (response.statusCode == 200) {
        debugPrint("yes");
      } else {
        debugPrint("no");
      }
    } catch (error) {
      print('sendDeviceControl => $error');
    }
  }

  void createQueue(String Ip, String Api) async {
    final response = await http.get(
      Uri.parse('${Ip}/api/plugin/speroplugin/create-queue'),
      headers: {
        'X-Api-Key': Api,
      },
    );

    if (response.statusCode == 200) {
      debugPrint("yes");
    } else {
      debugPrint("no");
    }
  }

  void setMove(String direction, int distance, String Ip, String Api) async {
    try {
      await Dio().post('${Ip}api/printer/printhead',
          data: {
            'command': 'jog',
            direction: distance,
          },
          options: Options(headers: {'X-Api-Key': Api}));
      setState(() {
        _tablePosition += distance;
      });
    } catch (e) {
      print('Error setting extruder temperature: $e');
    }
  }

  void setExtruderTemp(int temp, String Ip, String Api) async {
    try {
      await Dio().post('${Ip}/api/printer/tool',
          data: {
            'command': 'target',
            'targets': {'tool0': temp}
          },
          options: Options(headers: {'X-Api-Key': Api}));
      setState(() {
        extruderTemp = temp;
      });
    } catch (e) {
      print('Error setting extruder temperature: $e');
    }
  }
}
