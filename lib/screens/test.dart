import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final CountDownController controlador = CountDownController();
  bool reverse = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            CircularCountDownTimer(
              controller: controlador,
              width: 100,
              height: 100,
              duration: 500,
              isReverse: reverse,
              textFormat: CountdownTextFormat.MM_SS,
              fillColor: Colors.amber,
              ringColor: Colors.red,
            ),

            ElevatedButton(
                onPressed: (){
                  setState(() {
                    if (reverse == true) {
                      controlador.pause();
                      reverse = false;
                      controlador.resume();
                    } else {
                      controlador.pause();
                      reverse = true;
                      controlador.resume();
                    }
                    print(reverse);
                  });
                },
                child: const Text('Hola a todos'),
            ),
          ],
        ),
      ),
    );
  }
}
