import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String? dropdownValue;

class TeacherNotice extends StatefulWidget {
  const TeacherNotice({super.key});

  @override
  State<TeacherNotice> createState() => _TeacherNoticeState();
}

class _TeacherNoticeState extends State<TeacherNotice> {
  final _noticeController = TextEditingController();
  final _classController = TextEditingController();

  Future<void> send() async {
    if (_noticeController.text.trim() == '' ||
        _classController.text.trim() == '') {
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
                title: Text("Please write a notice and select a class."),
                titleTextStyle: TextStyle(
                  fontFamily: 'FiraSans',
                  color: Color.fromRGBO(53, 79, 63, 100),
                  fontSize: 25,
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(94, 110, 100, 100),
                      onPrimary: Color.fromRGBO(255, 255, 255, 0.612),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 25,
                      ),
                    ),
                  ),
                ]),
          );
        },
      );
    } else {
      addNotices(
        _noticeController.text.trim(),
        _classController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (context) {
          return Container(
            child: AlertDialog(
                title: Text("Notice Sent!!!"),
                titleTextStyle: TextStyle(
                  fontFamily: 'FiraSans',
                  color: Color.fromRGBO(53, 79, 63, 100),
                  fontSize: 25,
                ),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(94, 110, 100, 100),
                      onPrimary: Color.fromRGBO(255, 255, 255, 0.612),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(
                        fontFamily: 'FiraSans',
                        fontSize: 25,
                      ),
                    ),
                  ),
                ]),
          );
        },
      );
    }
    ;

    _noticeController.clear();
  }

  Future<void> addNotices(String notice, String Class) async {
    await FirebaseFirestore.instance.collection('Notices').add({
      'Notice': notice,
      'Date': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'Class': Class,
      'Name': 'TEACHER',
    });
  }

  Widget _noticeBox() {
    return TextField(
      controller: _noticeController,
      style: TextStyle(
        fontFamily: 'FiraSans',
        color: Color.fromRGBO(6, 10, 8, 0.612),
        fontSize: 18,
      ),
      decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(217, 217, 217, 100),
          labelText: 'Notice Box',
          hintText: 'Type Notice Here',
          labelStyle: TextStyle(
            fontFamily: 'Arima',
            fontSize: 40,
            color: Color.fromRGBO(53, 79, 63, 100),
          ),
          hintStyle: TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 20,
            color: Color.fromRGBO(53, 79, 63, 100),
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20.0))),
      maxLines: 9,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: ListView(
              padding: EdgeInsets.all(10),
              children: <Widget>[
                const ListTile(
                  title: Text('+ADD NOTICES',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(94, 110, 100, 100),
                          fontFamily: 'Arima',
                          fontSize: 45)),
                ),
                _noticeBox(),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text(
                          'SEND TO:-',
                          style: TextStyle(
                              color: Color.fromRGBO(94, 110, 100, 100),
                              fontFamily: 'Arima',
                              fontSize: 30),
                        ),
                      ),
                    ),
                    Expanded(
                        child: DropdownButtonFormField<String>(
                      style: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 25,
                          color: Color.fromRGBO(94, 110, 100, 100)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(217, 217, 217, 100),
                        hintText: 'Select a Class',
                        hintStyle: const TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 20,
                          color: Color.fromRGBO(53, 79, 63, 100),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20.0)),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _classController.text = newValue!;
                        });
                      },
                      items: <String>[
                        '1',
                        '2',
                        '3',
                        '4',
                        '5',
                        '6',
                        '7',
                        '8',
                        '9',
                        '10',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 450),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints.tightFor(width: 160, height: 40),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(94, 110, 100, 100),
                    onPrimary: Color.fromRGBO(255, 255, 255, 0.612),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () => {send()},
                  child: const Text(
                    'SEND',
                    style: TextStyle(fontFamily: 'FiraSans', fontSize: 25),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
