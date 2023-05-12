import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController controller = TextEditingController();

  String text = '';

  FocusNode focusNode = FocusNode();

  List<Color> colors = [Colors.red, Colors.green, Colors.black, Colors.yellow];

  int selectedColor = 0;

  int _valueOfTextSize = 24;
  int _valueOfTextStroke = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                GestureDetector(
                    onTap: onOpenKeyBoard,
                    child: Container(
                        height: 250,
                        padding: const EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius:
                            BorderRadius.all(Radius.circular(12.0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: <Widget>[
                                TextField(
                                  cursorHeight: _valueOfTextSize.toDouble(),
                                  controller: controller,
                                  onChanged: (value) {
                                    setState(() {
                                      text = value;
                                    });
                                  },
                                  focusNode: focusNode,
                                  showCursor: true,
                                  autofocus: true,
                                  keyboardType: TextInputType.multiline,
                                  minLines: 1,
                                  maxLines: 5,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: _valueOfTextSize.toDouble()),
                                  decoration: InputDecoration(
                                      counter: Container(),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: (_valueOfTextSize > 24)
                                              ? 0.0
                                              : -25.0)),
                                ),
                                Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: _valueOfTextSize.toDouble(),
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth =
                                      _valueOfTextStroke.toDouble()
                                      ..color = colors[selectedColor],
                                  ),
                                ),
                                Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: _valueOfTextSize.toDouble(),
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ))),
                const SizedBox(
                  height: 36.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'تغییر رنگ استروک',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    )
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var i = 0; i < colors.length; i++)
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedColor = i;
                          });
                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                              borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                              color: colors[i]),
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'تغییر سایز متن',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    )
                  ],
                ),
                Slider(
                    value: _valueOfTextSize.toDouble(),
                    min: 8.0,
                    max: 36.0,
                    divisions: 10,
                    activeColor: Colors.green,
                    inactiveColor: Colors.grey,
                    onChanged: (double newValue) {
                      setState(() {
                        _valueOfTextSize = newValue.round();
                      });
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'تغییر سایز استروک',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    )
                  ],
                ),
                Slider(
                    value: _valueOfTextStroke.toDouble(),
                    min: 0.0,
                    max: 8.0,
                    divisions: 10,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey,
                    onChanged: (double newValue) {
                      setState(() {
                        _valueOfTextStroke = newValue.round();
                      });
                    })
              ],
            )));
  }

  void onOpenKeyBoard() {
    if (focusNode.hasFocus) {
      focusNode.unfocus();
    } else {
      focusNode.requestFocus();
    }
  }
}

