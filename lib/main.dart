import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_string/random_string.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GeneratePass',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();


  double _sliderValue = 5;
  bool _switchValue = false;
  int _rnd = 0;

  void _generatePassword() {
    _rnd = randomBetween(5, 20);
    _textEditingController.text = randomAlphaNumeric(_sliderValue.round());
    if (_switchValue) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(
          'Copied \☺',
        ),
        backgroundColor: Colors.black45.withOpacity(0.4),
        duration: const Duration(seconds: 2),
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                style: const TextStyle(
                  fontSize: 22
                ),
                controller: _textEditingController,
                maxLength: 30,
                autofocus: false,
                autocorrect: false,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.withOpacity(0.2),
                  //hintText: 'Your Password: ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Slider(
                divisions: 25,
                min: 5,
                max: 30,
                label: 'Password length: ${_sliderValue.round()}',
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value;
                  });
                },
                value: _sliderValue,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _MyElevatedButton(
                  text: 'Generate',
                  callback: () => _generatePassword(),
                ),
                const SizedBox(
                  height: 30,
                ),
                _MyElevatedButton(
                    text: 'Copy',
                    callback: () {
                      if (_textEditingController.text.isNotEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Copied!'),
                        ));
                        FlutterClipboard.copy('${_textEditingController.text}')
                            .then((value) =>
                            print('${_textEditingController.text}'));
                      }
                    }),
              ],
            ),
          ],
        ),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  Colors.black,
                  //Colors.black,
                  Colors.grey,
                  Colors.blueGrey,
                ],
                begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
      ),
    );
  }
}

class _MyElevatedButton extends StatelessWidget {
  final VoidCallback callback;

  final String text;

  const _MyElevatedButton(
      {Key? key, required this.callback, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: callback,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

