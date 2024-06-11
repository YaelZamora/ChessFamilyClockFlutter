import 'package:chess_family_clock/screens/set_time_screen.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter/material.dart';

class ClockScreen extends StatefulWidget {
  const ClockScreen({
    super.key,
    required this.tiempo,
    this.incremento = 0,
  });

  final int tiempo;
  final int incremento;

  @override
  State<ClockScreen> createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen>
    with TickerProviderStateMixin {
  // ignore: prefer_final_fields
  late CustomTimerController _controllerBlancas = CustomTimerController(
    vsync: this,
    begin: Duration(minutes: widget.tiempo),
    end: const Duration(seconds: 0),
    initialState: CustomTimerState.reset,
    interval: CustomTimerInterval.seconds,
  );

  // ignore: prefer_final_fields
  late CustomTimerController _controllerNegras = CustomTimerController(
    vsync: this,
    begin: Duration(minutes: widget.tiempo),
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
        child: SingleChildScrollView(
          //MARK: Inicio de los botones del reloj
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
                      color: whiteRunning ? Colors.blue : Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CustomTimer(
                      controller: _controllerBlancas,
                      builder: (state, remaining) {
                        if (state.name == 'finished') {
                          _controllerBlancas.dispose();
                          _controllerNegras.dispose();
                        }
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
                                    (widget.tiempo > 59)
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
              //MARK: Sección botones de control (Home, pausa y reinicio)
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
                        if (botonPicado) {
                          _controllerBlancas.pause();
                          _controllerNegras.pause();
                        } else {
                          if (!whiteRunning) {
                            _controllerNegras.pause();
                            boton = 1;
                          } else if (!blackRunning) {
                            _controllerBlancas.pause();
                            boton = 2;
                          }
                        }
                      },
                      icon: const Icon(
                        Icons.pause,
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
              //MARK: Botón de tiempo
              GestureDetector(
                onTap: blackRunning ? _negrasPausa : null,
                child: Container(
                  width: size.width,
                  height: size.height * 0.4,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: blackRunning ? Colors.blue : Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomTimer(
                    controller: _controllerNegras,
                    builder: (state, remaining) {
                      if (state.name == 'finished') {
                        _controllerBlancas.dispose();
                        _controllerNegras.dispose();
                      }
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
                                  (widget.tiempo > 59)
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
      ),
    );
  }

  void _blancasPausa() {
    setState(() {
      (jugadasBlancas == 1) ? null : Wakelock.enable();
      _controllerNegras.start();
      _controllerBlancas.pause();
      _controllerBlancas.begin = Duration(minutes: widget.tiempo, seconds: (widget.incremento * jugadasBlancas));
      _controllerBlancas.add(Duration(seconds: widget.incremento));
      jugadasBlancas++;
      whiteRunning = false;
      blackRunning = true;
    });
  }

  void _negrasPausa() {
    setState(() {
      _controllerBlancas.start();
      _controllerNegras.pause();
      _controllerNegras.begin = Duration(minutes: widget.tiempo, seconds: (widget.incremento * jugadasNegras));
      _controllerNegras.add(Duration(seconds: widget.incremento));
      jugadasNegras++;
      blackRunning = false;
      whiteRunning = true;
    });
  }
}
