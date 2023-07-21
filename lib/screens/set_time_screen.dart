import 'package:chess_family_clock/screens/clock_screen.dart';
import 'package:chess_family_clock/screens/gong_screen.dart';
import 'package:chess_family_clock/screens/screen_960.dart';
import 'package:flutter/material.dart';

class SetTimeScreen extends StatefulWidget {
  const SetTimeScreen({super.key});

  @override
  State<SetTimeScreen> createState() => _SetTimeScreenState();
}

class _SetTimeScreenState extends State<SetTimeScreen> {
  final snackBar = const SnackBar(
    content: Text('Tienes que poner tiempo inicial'),
  );

  final proximamente = const SnackBar(content: Text('Próximamente'));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tiempo = TextEditingController();
    final suma = TextEditingController();

    //int tiempoInicial = 3;
    //int incremento = 2;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'ChessFamily Clock',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: size.height / 2,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Tiempo inicial',
                    ),
                    onChanged: (value) {
                      tiempo.text = value;
                    },
                    onSaved: (value) {
                      tiempo.text = value!;
                    },
                    onFieldSubmitted: (value) => tiempo.text = value,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Incremento',
                    ),
                    onChanged: (value) {
                      suma.text = value;
                    },
                    onSaved: (value) {
                      suma.text = value!;
                    },
                    onFieldSubmitted: (value) => suma.text = value,
                  ),
                ],
              ),
            ),
            TextButton(
              /* onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const TimeControlScreen(),
                ),
              ), */
              onPressed: () =>
                  ScaffoldMessenger.of(context).showSnackBar(proximamente),
              child: const Text('Control de tiempo'),
            ),
            Container(
              width: size.width,
              height: 50,
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.indigo,
              ),
              clipBehavior: Clip.hardEdge,
              child: MaterialButton(
                onPressed: () {
                  if (tiempo.text == '') {
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    if (suma.text.isEmpty) suma.text = '0';
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => ClockScreen(
                          tiempo: int.parse(tiempo.text),
                          incremento: int.parse(suma.text),
                        ),
                      ),
                    );
                  }
                },
                minWidth: size.width,
                height: 50,
                child: const Text(
                  'Aceptar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () {
                    if (tiempo.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => GongScreen(
                            tiempo: int.parse(tiempo.text),
                            incremento: 0,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('GONG'),
                ),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const Screen960(),
                    ),
                  ),
                  child: const Text('960'),
                ),
                /* TextButton(
                  onPressed: () {
                    if (tiempoInicial == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HourGlass(
                            tiempo: tiempoInicial,
                            incremento: incremento,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('HourGlass'),
                ), */
              ],
            ),
          ],
        ),
      ),
    );
  }
}
