import 'package:chess_family_clock/screens/set_time_screen.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class TimeControlClock extends StatefulWidget {
  const TimeControlClock({
    super.key,
    required this.controlUno,
    required this.controlDos,
    required this.controlTres,
    required this.jugadasUno,
    required this.jugadasDos,
    required this.jugadasTres,
  });

  final int controlUno;
  final int controlDos;
  final int controlTres;
  final int jugadasUno;
  final int jugadasDos;
  final int jugadasTres;

  @override
  State<TimeControlClock> createState() => _TimeControlClockState();
}

//TODO: Aquí venimos de la pantalla de TimeControl, para manejar los controles de tiempo
class _TimeControlClockState extends State<TimeControlClock>
    with TickerProviderStateMixin {
  // ignore: prefer_final_fields
  late CustomTimerController _controllerBlancas = CustomTimerController(
    vsync: this,
    begin: Duration(minutes: widget.controlUno),
    end: const Duration(seconds: 0),
    initialState: CustomTimerState.reset,
    interval: CustomTimerInterval.seconds,
  );

  // ignore: prefer_final_fields
  late CustomTimerController _controllerNegras = CustomTimerController(
    vsync: this,
    begin: Duration(minutes: widget.controlUno),
    end: const Duration(seconds: 0),
    initialState: CustomTimerState.reset,
    interval: CustomTimerInterval.seconds,
  );

  late bool whiteRunning = true;
  late bool blackRunning = true;
  late bool botonPicado = false;
  int jugadasBlancas = 0;
  int jugadasNegras = 0;
  int boton = 0;

  @override
  void dispose() {
    _controllerBlancas.dispose();
    _controllerNegras.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RotatedBox(
              quarterTurns: 2,
              child: GestureDetector(
                onTap: whiteRunning ? _blancasPausa : null,
                child: Container(
                  width: size.width,
                  height: size.height * 0.4,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomTimer(
                    controller: _controllerBlancas,
                    builder: (state, remaining) {
                      return (state.name == 'finished')
                          ? const Icon(
                              Icons.flag_rounded,
                              color: Colors.red,
                              size: 150,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (widget.controlUno > 59)
                                      ? '${remaining.hours} : ${remaining.minutes} : ${remaining.seconds}'
                                      : '${remaining.minutes} : ${remaining.seconds}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                                Text(
                                  'Jugadas: $jugadasBlancas',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                    },
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            const SetTimeScreen(),
                      ),
                    ),
                    icon: const Icon(
                      Icons.home,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      botonPicado = !botonPicado;
                      if (boton == 1) {
                        _controllerNegras.start();
                      } else if (boton == 2) {
                        _controllerBlancas.start();
                      }

                      if (!whiteRunning) {
                        _controllerNegras.pause();
                        boton = 1;
                      } else if (!blackRunning) {
                        _controllerBlancas.pause();
                        boton = 2;
                      }
                    },
                    icon: Icon(
                      (botonPicado) ? Icons.pause : Icons.play_arrow,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _controllerBlancas.reset();
                      _controllerNegras.reset();
                      jugadasBlancas = 0;
                      jugadasNegras = 0;
                    },
                    icon: const Icon(
                      Icons.refresh,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: blackRunning ? _negrasPausa : null,
              child: Container(
                width: size.width,
                height: size.height * 0.4,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: CustomTimer(
                  controller: _controllerNegras,
                  builder: (state, remaining) {
                    return (state.name == 'finished')
                        ? const Icon(
                            Icons.flag_rounded,
                            color: Colors.red,
                            size: 150,
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (widget.controlUno > 59)
                                    ? '${remaining.hours} : ${remaining.minutes} : ${remaining.seconds}'
                                    : '${remaining.minutes} : ${remaining.seconds}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50,
                                ),
                              ),
                              Text(
                                'Jugadas: $jugadasNegras',
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _blancasPausa() {
    setState(() {
      (jugadasBlancas == 1) ? null : WakelockPlus.enable;
      _controllerNegras.start();
      _controllerBlancas.pause();
      //_controllerBlancas.add(Duration(seconds: widget.incremento));
      jugadasBlancas++;
      if (jugadasBlancas == widget.jugadasUno) {
        _controllerBlancas.add(Duration(minutes: widget.controlDos));
      } else if (jugadasBlancas == widget.jugadasDos) {
        _controllerBlancas.add(Duration(minutes: widget.controlTres));
      }
      whiteRunning = false;
      blackRunning = true;
    });
  }

  void _negrasPausa() {
    setState(() {
      _controllerBlancas.start();
      _controllerNegras.pause();
      //_controllerNegras.add(Duration(seconds: widget.incremento));
      jugadasNegras++;
      if (jugadasNegras == widget.jugadasUno) {
        _controllerNegras.add(Duration(minutes: widget.controlDos));
      } else if (jugadasNegras == widget.jugadasDos) {
        _controllerNegras.add(Duration(minutes: widget.controlTres));
      }
      blackRunning = false;
      whiteRunning = true;
    });
  }
}
