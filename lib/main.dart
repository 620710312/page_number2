import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_number2/Home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Hw7(),
    );
  }
}

class Hw7 extends StatefulWidget {
  static const buttonSize = 75.0;

  const Hw7({Key? key}) : super(key: key);

  @override
  State<Hw7> createState() => _Hw7State();
}

class _Hw7State extends State<Hw7> {
  String _inputstate = '';
  final String PIN = "123456";
  String message = "";
  var _num = 0;

  void _showOkDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Widget buildButton(int num) {
    Widget? child;
    if (num == -1) {
      child = Icon(Icons.backspace);
    } else {
      child = Text('$num');
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          var length = _inputstate.length;
          if (num == -1) {
          print('Backspace');
          _num--;
            setState(() {
              _inputstate = _inputstate.substring(0, length - 1);
              child = Icon(Icons.backspace);
            });
          } else {
            _num++;
            print('$num');
            setState(() {
              _inputstate = '$_inputstate$num';
            });
            child = Text('$num');
          }
          if(length+1 == 6) {
            if (_inputstate == PIN) {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Home()
                  ),
                );
              });
            }
            else {
              setState(() {
                message = 'Please try again!';
                _inputstate = _inputstate.substring(0, 0);
                _num = 0;
              });
              _showOkDialog(context, 'Invalid PIN', message);
            }
          }
        },
        child: Container(
          //color: Colors.white, // ห้ามกำหนด color ตรงนี้ ถ้าหากกำหนดใน BoxDecoration แล้ว
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.greenAccent, width: 4.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  // สีเงา
                  offset: Offset(2, 4),
                  // ทิศทางของเงาในแนวนอนและแนวตั้ง ตามลำดับ
                  blurRadius: 4.0,
                  spreadRadius: 2.0,
                )
              ]),

          alignment: Alignment.center,
          width: Hw7.buttonSize,
          height: Hw7.buttonSize,
          child: Container(child: child
          ),
        ),

      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock,
                  size: 100,
                  color: Colors.black12,
                ),
                SizedBox(height: 15.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 36),
                  ),
                ),
                Text(
                  'Enter PIN to login',
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Collection for
              for (var i = 0; i < _num; i++)
                Container(
                  width: 20.0,
                  height: 20.0,
                  margin: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 1; i <= 3; i++) buildButton(i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 4; i <= 6; i++) buildButton(i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 7; i <= 9; i++) buildButton(i),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 90, height: 75),
                  buildButton(0),
                  buildButton(-1),
                ],
              ),
            ],
          ),

          /* Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text('ลืมรหัสผ่าน',
                    style: TextStyle(color: Colors.lightBlueAccent),

                  ),
                ),
              ),*/
        ],
      ),
    ));
  }
}
