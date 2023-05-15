import 'package:chess_family_clock/screens/clock_screen.dart';
import 'package:flutter/material.dart';

class Screen960 extends StatefulWidget {
  const Screen960({super.key});

  @override
  State<Screen960> createState() => Screen960State();
}

class Screen960State extends State<Screen960> {
  final tiempo = TextEditingController();
  final suma = TextEditingController();

  List<dynamic> posicion = ['A', 'C', 'C', 'A', 'T', 'D', 'T', 'R'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  posicion.shuffle();
                });
              },
              child: const Text('Cambiar'),
            ),
            Text('$posicion'),
            TextButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Fijar tiempo'),
                    content: SizedBox(
                      height: 100,
                      child: Column(
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
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (tiempo.text.isEmpty) tiempo.text = '5';
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
                        },
                        child: const Text('Aceptar'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.done),
              label: const Text('Jugar'),
            ),
          ],
        ),
      ),
    );
  }
}
