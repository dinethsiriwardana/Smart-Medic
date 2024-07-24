import 'dart:math';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:intl/intl.dart';

var year = int.parse(DateFormat('yyyy').format(DateTime.now()));

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

late AnimationController lottieController;

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();

  String get _textEditingControllertext => _textEditingController.text;
  int get _textEditingControllerint => int.parse(_textEditingController.text);
  Color maincolor = Color.fromARGB(255, 255, 130, 145);
  Color maincolor2 = Color.fromARGB(255, 130, 255, 140);

  String bpm = "--";
  String bheat = "--";
  String spo2 = "--";
  String stage = "--";
  String name = "--";

  @override
  void initState() {
    super.initState();

    lottieController = AnimationController(
      vsync: this,
    );

    lottieController.addStatusListener((status) {
      int cont = 0;

      // Do something
      if (status == AnimationStatus.completed) {
        lottieController.reset();
        lottieController.forward();
      }
    });
  }

  @override
  void dispose() {
    lottieController.dispose();
    super.dispose();
  }

  int gender = 1;

  senddatatofirebase() async {
    var age = year - _textEditingControllerint;
    DatabaseReference ref = FirebaseDatabase.instance.ref("heart_disease/0/");
    int sendnumber = 0;
    await ref.set({
      "HR": int.parse(bpm),
      "temp": double.parse(bheat),
      "SPO2": int.parse(spo2),
      "Stage": int.parse(stage),
      "age": age,
      "gen": gender,
      "Name": name
    });
  }

  @override
  Widget build(BuildContext context) {
    readdata() async {
      DatabaseReference starCountRef =
          await FirebaseDatabase.instance.ref('heart_disease/0/');
      starCountRef.onValue.listen((DatabaseEvent event) async {
        // Do something
        final data = await event.snapshot.value as Map;
        if ((bpm != data["HR"].toString()) ||
            (bheat != data["temp"].toString()) ||
            (spo2 != data["SPO2"].toString()) ||
            (stage != data["Stage"].toString())) {
          print(data);
          bpm = data["HR"].toString();
          bheat = data["temp"].toString();
          spo2 = data["SPO2"].toString();
          stage = data["Stage"].toString();
          name = data["Name"].toString();
          setState(() {});
        }
      });
    }

    readdata();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 130, 145),
      body: Center(
        child: Container(
          height: 100.h,
          width: 100.w,
          padding: EdgeInsets.fromLTRB(10, 40, 10, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Smart Medicare",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lora(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 10.w,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    "Stage - $stage",
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 13.w,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 100.w,
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Positioned(
                              top: 0,
                              child: SizedBox(
                                height: 100,
                                width: 200,
                                child: Lottie.asset(
                                  "assets/hart.json",
                                  animate: true,
                                  repeat: false,
                                  controller: lottieController,
                                  onLoaded: (composition) {
                                    lottieController.duration =
                                        Duration(seconds: 3);
                                    lottieController.forward();
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100.w,
                              height: 50.w,
                              child: Stack(
                                alignment: AlignmentDirectional.center,
                                children: [
                                  Positioned(
                                    bottom: 30,
                                    child: Text(
                                      "BPM",
                                      // textAlign: TextAlign.center,
                                      style: GoogleFonts.titilliumWeb(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    bpm,
                                    // textAlign: TextAlign.center,
                                    style: GoogleFonts.titilliumWeb(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.w,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.thermostat,
                                      size: 10.w,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "$bheat ˚C",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 10.w,
                                      child: Image.asset('assets/spo2.png'),
                                    ),
                                    Text(
                                      "$spo2%",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.w,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.35.w,
                                  child: Radio<int>(
                                    activeColor: Colors.white,
                                    value: 1,
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = 1;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Male',
                                  style: TextStyle(
                                      fontSize: 6.w,
                                      color:
                                          (gender == 1 ? Colors.white : null)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.35.w,
                                  child: Radio<int>(
                                    activeColor: Colors.white,
                                    value: 0,
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = 0;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'Female',
                                  style: TextStyle(
                                      fontSize: 6.w,
                                      color:
                                          (gender == 0 ? Colors.white : null)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            inputNumberBox(_textEditingController, "B Year",
                                "B Year", () {}, false)
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(30),
                    height: 50,
                    width: 80.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ))),
                      child: Text(
                        "Send Data",
                        style: TextStyle(color: maincolor),
                      ),
                      onPressed: () {
                        if (_textEditingControllertext != "") {
                          senddatatofirebase();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox inputNumberBox(
    TextEditingController _inputController,
    String _hintText,
    String _labletext,
    // String _onchangeType,
    VoidCallback _ontap,
    bool _obscureText,
  ) {
    return SizedBox(
      width: 25.w,
      height: 15.w,
      child: TextField(
        controller: _inputController,
        keyboardType: TextInputType.number,
        // focusNode: _passwordagainfocusController,
        onTap: _ontap,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
          hintText: _hintText,
          labelText: _labletext,
          // errorText: "widget.invalidEmailErrorText",
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
          labelStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        autocorrect: false,
        obscureText: _obscureText,
        onChanged: (_onchangeType) => _updateState(),
        // onChanged: (_onchangeType) {
        //   if (_onchangeType.isEmpty) {
        //     _updateState();
        //   } else {
        //     _updateState();
        //   }
        // },
      ),
    );
  }

  _updateState() {
    setState(() {});
  }
}
