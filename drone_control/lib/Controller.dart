// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Joystick extends StatefulWidget {
  final channel = IOWebSocketChannel.connect("ws://192.168.225.101:85");
  int throttle = 1000;

  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  bool armed = false;
  double width_left_ov = 0;
  double width_left_sm = 0;
  bool direction = false;
  bool read_angle = false;
  bool fpv_ON = false;
  int R_setpoint = 0;
  int P_setpoint = 0;
  int Y_setpoint = 0;
  int Y_setpoint_F = 0;
  Offset _dragPosition_left = Offset(62.5, 125);
  Offset _dragPosition_right = Offset(62.5, 62.5);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        Calculations();
        _dragPosition_left = Offset(
            (width_left_ov - width_left_sm) / 2, width_left_ov - width_left_sm);
        _dragPosition_right = Offset((width_left_ov - width_left_sm) / 2,
            (width_left_ov - width_left_sm) / 2);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Container(
                  margin: EdgeInsets.only(right: 10, top: 15),
                  child: FlutterSwitch(
                      value: armed,
                      showOnOff: true,
                      width: MediaQuery.of(context).size.width / 8.5,
                      height: MediaQuery.of(context).size.height / 12.5,
                      activeText: "Armed",
                      inactiveText: "Disarmed",
                      valueFontSize: 10.5.sp,
                      activeTextColor: Colors.white,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.white,
                      inactiveTextColor: Colors.deepPurple,
                      inactiveToggleColor: Colors.deepPurple,
                      inactiveSwitchBorder:
                          Border.all(color: Colors.deepPurple, width: 1),
                      onToggle: (value) {
                        setState(() {
                          armed = value;
                        });
                        Map<String, bool> data2 = {"Armed": armed};
                        widget.channel.sink.add(data2.toString());
                      })),
              Container(
                  margin: EdgeInsets.only(right: 10, top: 15),
                  child: FlutterSwitch(
                      value: direction,
                      showOnOff: true,
                      width: MediaQuery.of(context).size.width / 8.5,
                      height: MediaQuery.of(context).size.height / 12.5,
                      activeText: "direction",
                      inactiveText: "Altitude",
                      valueFontSize: 10.5.sp,
                      activeTextColor: Colors.white,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.white,
                      inactiveTextColor: Colors.deepPurple,
                      inactiveToggleColor: Colors.deepPurple,
                      inactiveSwitchBorder:
                          Border.all(color: Colors.deepPurple, width: 1),
                      onToggle: (value) {
                        setState(() {
                          direction = value;
                        });
                      }))
            ]),
            Text("RSP :  $R_setpoint", style: TextStyle(fontSize: 15.sp)),
            Text("PSP :  $P_setpoint", style: TextStyle(fontSize: 15.sp)),
            Text("YSP :  $Y_setpoint", style: TextStyle(fontSize: 15.sp)),
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, bottom: 15),
                  width: MediaQuery.of(context).size.width / 4.2,
                  height: MediaQuery.of(context).size.width / 4.2,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.deepPurple, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  left: _dragPosition_left.dx,
                  top: _dragPosition_left.dy,
                  child: GestureDetector(
                    onPanStart: _onDragStart_left,
                    onPanUpdate: _onDragUpdate_left,
                    onPanEnd: _onDragEnd_left,
                    child: Container(
                      margin: EdgeInsets.only(left: 15, bottom: 15),
                      width: MediaQuery.of(context).size.width / 14,
                      height: MediaQuery.of(context).size.width / 14,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ]),
          Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Text("THROTTLE :  ${widget.throttle}",
                      style: TextStyle(fontSize: 17.sp))),
              FittedBox(
                  fit: BoxFit.cover,
                  child: TextButton(
                      onPressed: () {
                        setState(() {
                          Calculations();
                          _dragPosition_left = Offset(
                              (width_left_ov - width_left_sm) / 2,
                              width_left_ov - width_left_sm);
                        });
                      },
                      child: const Text(
                        "Initialize",
                        style: TextStyle(color: Colors.deepPurple),
                      )))
            ],
          ),
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Container(
                  margin: EdgeInsets.only(right: 10, top: 15),
                  child: FlutterSwitch(
                      value: read_angle,
                      showOnOff: true,
                      width: MediaQuery.of(context).size.width / 8.5,
                      height: MediaQuery.of(context).size.height / 12.5,
                      activeText: "angle ON",
                      inactiveText: "angle OFF",
                      valueFontSize: 10.5.sp,
                      activeTextColor: Colors.white,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.white,
                      inactiveTextColor: Colors.deepPurple,
                      inactiveToggleColor: Colors.deepPurple,
                      inactiveSwitchBorder:
                          Border.all(color: Colors.deepPurple, width: 1),
                      onToggle: (value) {
                        setState(() {
                          read_angle = value;
                        });
                      })),
              Container(
                  margin: EdgeInsets.only(right: 10, top: 15),
                  child: FlutterSwitch(
                      value: fpv_ON,
                      showOnOff: true,
                      width: MediaQuery.of(context).size.width / 8.5,
                      height: MediaQuery.of(context).size.height / 12.5,
                      activeText: "fpv ON",
                      inactiveText: "fpv OFF",
                      valueFontSize: 10.5.sp,
                      activeTextColor: Colors.white,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.white,
                      inactiveTextColor: Colors.deepPurple,
                      inactiveToggleColor: Colors.deepPurple,
                      inactiveSwitchBorder:
                          Border.all(color: Colors.deepPurple, width: 1),
                      onToggle: (value) {
                        setState(() {
                          fpv_ON = value;
                        });
                      }))
            ]),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: Text(
                "Roll  :",
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
            Container(
                margin: EdgeInsets.only(right: 20),
                child: Text(
                  "pitch :",
                  style: TextStyle(fontSize: 15.sp),
                )),
            Container(
                margin: EdgeInsets.only(right: 20),
                child: Text(
                  "yaw  :",
                  style: TextStyle(fontSize: 15.sp),
                )),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15, bottom: 15),
                  width: MediaQuery.of(context).size.width / 4.2,
                  height: MediaQuery.of(context).size.width / 4.2,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.deepPurple, width: 2),
                    shape: BoxShape.circle,
                  ),
                ),
                Positioned(
                  left: _dragPosition_right.dx,
                  top: _dragPosition_right.dy,
                  child: GestureDetector(
                    onPanStart: _onDragStart_right,
                    onPanUpdate: _onDragUpdate_right,
                    onPanEnd: _onDragEnd_right,
                    child: Container(
                      margin: const EdgeInsets.only(right: 15, bottom: 15),
                      width: MediaQuery.of(context).size.width / 14,
                      height: MediaQuery.of(context).size.width / 14,
                      decoration: const BoxDecoration(
                        color: Colors.deepPurple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ])));
  }

  void _onDragStart_left(DragStartDetails details) {
    setState(() {
      Calculations();
      _dragPosition_left =
          Offset((width_left_ov - width_left_sm) / 2, _dragPosition_left.dy);
      Y_setpoint =
          (_dragPosition_left.dx * -(180 / (width_left_ov - width_left_sm)) +
                  90)
              .toInt();
    });
  }

  void _onDragUpdate_left(DragUpdateDetails details) async {
    setState(() {
      _dragPosition_left += details.delta;
      if (_dragPosition_left.dx > width_left_ov - width_left_sm) {
        _dragPosition_left =
            Offset(width_left_ov - width_left_sm, _dragPosition_left.dy);
      }
      if (_dragPosition_left.dx < 0) {
        _dragPosition_left = Offset(0, _dragPosition_left.dy);
      }
      if (_dragPosition_left.dy > width_left_ov - width_left_sm) {
        _dragPosition_left =
            Offset(_dragPosition_left.dx, width_left_ov - width_left_sm);
      }
      if (_dragPosition_left.dy < 0) {
        _dragPosition_left = Offset(_dragPosition_left.dx, 0);
      }
      widget.throttle =
          (_dragPosition_left.dy * -(1000 / (width_left_ov - width_left_sm)) +
                  2000)
              .toInt();
      if (direction == false) {
        Y_setpoint = 0;
      } else if (direction == true) {
        Y_setpoint =
            ((_dragPosition_left.dx - (width_left_ov - width_left_sm) / 2) *
                    (180 / (width_left_ov - width_left_sm)))
                .toInt();
      }
    });
    Map<String, int> data = {
      'throttle': widget.throttle,
      'YSP': Y_setpoint,
    };
    widget.channel.sink.add(data.toString());
  }

  void _onDragEnd_left(DragEndDetails details) async {
    setState(() {
      _dragPosition_left =
          Offset((width_left_ov - width_left_sm) / 2, _dragPosition_left.dy);
      widget.throttle =
          (_dragPosition_left.dy * -(1000 / (width_left_ov - width_left_sm)) +
                  2000)
              .toInt();
      Y_setpoint = 0;
      Map<String, int> data = {
        'throttle': widget.throttle,
        'YSP': Y_setpoint,
      };
      widget.channel.sink.add(data.toString());
    });
  }

  void _onDragStart_right(DragStartDetails details) {
    setState(() {
      Calculations();
      _dragPosition_right = Offset((width_left_ov - width_left_sm) / 2,
          (width_left_ov - width_left_sm) / 2);
    });
  }

  void _onDragUpdate_right(DragUpdateDetails details) {
    setState(() {
      Calculations();
      _dragPosition_right += details.delta;
      if (_dragPosition_right.dx > width_left_ov - width_left_sm) {
        _dragPosition_right =
            Offset(width_left_ov - width_left_sm, _dragPosition_right.dy);
      }
      if (_dragPosition_right.dx < 0) {
        _dragPosition_right = Offset(0, _dragPosition_right.dy);
      }
      if (_dragPosition_right.dy > width_left_ov - width_left_sm) {
        _dragPosition_right =
            Offset(_dragPosition_right.dx, width_left_ov - width_left_sm);
      }
      if (_dragPosition_right.dy < 0) {
        _dragPosition_right = Offset(_dragPosition_right.dx, 0);
      }
      if (direction == false) {
        R_setpoint = 0;
        P_setpoint = 0;
      } else if (direction == true) {
        R_setpoint =
            ((_dragPosition_right.dx - (width_left_ov - width_left_sm) / 2) *
                    (180 / (width_left_ov - width_left_sm)))
                .toInt();
        P_setpoint =
            (_dragPosition_right.dy * -(180 / (width_left_ov - width_left_sm)) +
                    90)
                .toInt();
      }
      Map<String, int> data1 = {
        "RSP": R_setpoint,
        "PSP": P_setpoint,
      };
      widget.channel.sink.add(data1.toString());
    });
  }

  void _onDragEnd_right(DragEndDetails details) {
    setState(() {
      Calculations();
      _dragPosition_right = Offset((width_left_ov - width_left_sm) / 2,
          (width_left_ov - width_left_sm) / 2);
      R_setpoint = 0;
      P_setpoint = 0;
      Map<String, int> data1 = {
        "RSP": R_setpoint,
        "PSP": P_setpoint,
      };
      widget.channel.sink.add(data1.toString());
    });
  }

  void Calculations() {
    width_left_ov = MediaQuery.of(context).size.width / 4.2;
    width_left_sm = MediaQuery.of(context).size.width / 14;
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}
