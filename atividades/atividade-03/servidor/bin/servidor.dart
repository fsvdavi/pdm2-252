import 'dart:io';

Future<void> main() async {
  final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 4040);
  print('Servidor iniciado em ${server.address.address}:${server.port}');
  print('Aguardando conexões...\n');

  await for (final socket in server) {
    print('Novo dispositivo conectado: ${socket.remoteAddress.address}');
    socket.listen((data) {
      final message = String.fromCharCodes(data).trim();
      print('Temperatura recebida: $message °C');
    }, onDone: () {
      print('Dispositivo desconectado: ${socket.remoteAddress.address}');
    });
  }
}
