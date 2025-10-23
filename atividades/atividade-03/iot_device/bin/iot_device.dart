import 'dart:io';
import 'dart:math';
import 'dart:async';

Future<void> main() async {
  final socket = await Socket.connect(InternetAddress.loopbackIPv4, 4040);
  print('Conectado ao servidor em ${socket.remoteAddress.address}:${socket.remotePort}');
  print('Enviando temperaturas a cada 10 segundos...\n');

  final random = Random();

  Timer.periodic(const Duration(seconds: 10), (timer) {
    final temperatura = 20 + random.nextInt(15) + random.nextDouble();
    final mensagem = temperatura.toStringAsFixed(2);
    socket.writeln(mensagem);
    print('Temperatura enviada: $mensagem °C');
  });
}


