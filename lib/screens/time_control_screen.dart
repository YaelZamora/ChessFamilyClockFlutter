import 'package:chess_family_clock/screens/time_control_clock_screen.dart';
import 'package:flutter/material.dart';

class TimeControlScreen extends StatelessWidget {
  const TimeControlScreen({super.key});

  final snackBar1 = const SnackBar(
    content: Text('Error en el control de tiempo'),
  );

  final snackBar2 = const SnackBar(
    content: Text('Error en las jugadas'),
  );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final primerControl = TextEditingController();
    final segundoControl = TextEditingController();
    final tercerControl = TextEditingController();

    final jugadasUno = TextEditingController();
    final jugadasDos = TextEditingController();
    final jugadasTres = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Control de tiempo',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          RowTime(
            hintTiempo: 'Primer Control',
            hintJugadas: 'Jugadas',
            controlador: primerControl,
            controlJugadas: jugadasUno,
          ),
          const SizedBox(
            height: 50,
          ),
          RowTime(
            hintTiempo: 'Segundo Control',
            hintJugadas: 'Jugadas',
            controlador: segundoControl,
            controlJugadas: jugadasDos,
          ),
          const SizedBox(
            height: 50,
          ),
          RowTime(
            hintTiempo: 'Tercer Control',
            hintJugadas: 'Jugadas',
            controlador: tercerControl,
            controlJugadas: jugadasTres,
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
                if (int.parse(jugadasUno.text) > int.parse(jugadasDos.text) ||
                    int.parse(jugadasUno.text) > int.parse(jugadasTres.text) ||
                    int.parse(jugadasDos.text) > int.parse(jugadasTres.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(snackBar1);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => TimeControlClock(
                        controlUno: int.parse(primerControl.text),
                        controlDos: int.parse(segundoControl.text),
                        controlTres: int.parse(tercerControl.text),
                        jugadasUno: int.parse(jugadasUno.text),
                        jugadasDos: int.parse(jugadasDos.text),
                        jugadasTres: int.parse(jugadasTres.text),
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
        ],
      ),
    );
  }
}

class RowTime extends StatelessWidget {
  const RowTime({
    super.key,
    required this.hintTiempo,
    required this.hintJugadas,
    required this.controlador,
    required this.controlJugadas,
  });

  final String hintTiempo;
  final String hintJugadas;
  final TextEditingController controlador;
  final TextEditingController controlJugadas;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          width: 200,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintTiempo,
            ),
            onChanged: (value) {
              controlador.text = value;
            },
            onSubmitted: (value) {
              controlador.text = value;
            },
          ),
        ),
        SizedBox(
          width: 100,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hintJugadas,
            ),
            onChanged: (value) {
              controlJugadas.text = value;
            },
            onSubmitted: (value) {
              controlJugadas.text = value;
            },
          ),
        ),
      ],
    );
  }
}
