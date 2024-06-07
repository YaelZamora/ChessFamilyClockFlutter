import 'dart:math';

import 'package:chess_family_clock/helper_960.dart';
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

  List<String> posicion = ['A', 'C', 'C', 'A', 'T', 'D', 'T', 'R'];
  int numero = 0;
  Random aleatorio = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          '960',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  numero = aleatorio.nextInt(7679);
                });
              },
              child: const Text(
                'Cambiar',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              opcion[numero].opcion,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            //MARK: Botón para jugar
            TextButton.icon(
              onPressed: () {
                //MARK: Muestra la ventana emergente
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
              icon: const Icon(
                Icons.done,
                color: Colors.indigo,
                size: 20,
              ),
              label: const Text(
                'Jugar',
                style: TextStyle(
                  color: Colors.indigo,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*

 */