import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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

  List<Color> colorsStroke = [
    Colors.red,
    Colors.green,
    Colors.black,
    Colors.yellow
  ];
  List<Color> colorsText = [
    Colors.black,
    Colors.green,
    Colors.blue,
    Colors.brown
  ];

  int selectedColorStroke = 0;
  int selectedColorText = 0;

  int _valueOfTextSize = 24;
  int _valueOfTextStroke = 5;

  WidgetsToImageController widgetsToImageController = WidgetsToImageController();

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
                        child: ListView(
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
                                  maxLines: null,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: _valueOfTextSize.toDouble()),
                                  decoration: InputDecoration(
                                      counter: Container(),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: (_valueOfTextSize > 17)?0.0: -25.0)),
                                ),
                                WidgetsToImage(controller: widgetsToImageController, child: Stack(
                                  children: [
                                    Text(
                                      text,
                                      style: TextStyle(
                                        fontSize: _valueOfTextSize.toDouble(),
                                        foreground: Paint()
                                          ..style = PaintingStyle.stroke
                                          ..strokeWidth =
                                          _valueOfTextStroke.toDouble()
                                          ..color =
                                          colorsStroke[selectedColorStroke],
                                      ),
                                    ),
                                    Text(
                                      text,
                                      style: TextStyle(
                                        fontSize: _valueOfTextSize.toDouble(),
                                        color: colorsText[selectedColorText],
                                      ),
                                    ),
                                  ],
                                ))
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
                    for (var i = 0; i < colorsStroke.length; i++)
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedColorStroke = i;
                          });
                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              color: colorsStroke[i]),
                        ),
                      )
                  ],
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'تغییر رنگ متن',
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
                    for (var i = 0; i < colorsText.length; i++)
                      InkWell(
                        onTap: () {
                          setState(() {
                            selectedColorText = i;
                          });
                        },
                        child: Container(
                          height: 45.0,
                          width: 45.0,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              color: colorsText[i]),
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
                    }),
                const SizedBox(
                  height: 16.0,
                ),
                InkWell(
                  onTap: ()async{
                    var image = await widgetsToImageController.capture();
                    if (image != null) {
                      _createLevelFile(image);
                    }
                  },
                  child: Container(
                    height: 56.0,
                    margin: const EdgeInsets.only(left: 24.0, right: 24.0),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                    ),
                    child: const Center(
                      child: Text(
                        'جروجی PNG',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
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

  Future<File?> _createLevelFile(image) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File("$appDocPath/picture.png");
    await file.create(recursive: true);
    await file.writeAsBytes(image);
    await Share.shareFiles(['$appDocPath/picture.png']);
    return null;
  }

}
