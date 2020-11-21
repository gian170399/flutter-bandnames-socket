import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {
  Online,
  Offline,
  Connecting,
}

class SocketService with ChangeNotifier {
  //el serverStatus lo dejamos en privado para que no cambie ningun valor de este en ningun otro lugar, para poder controlarlo en esta clase
  ServerStatus _serverStatus = ServerStatus.Connecting; //intentando conectar primero
  IO.Socket _socket;
  //para poder utilizar el _serverStatus tenemos que hacer el get y set
  ServerStatus get serverStatus => this._serverStatus; //cuando llamamos al SocketService, se va la propiedad get ServerStatus que retorna la propiedad privada
  IO.Socket get socket => this._socket;

  //Function get emit => this._socket.emit;


  SocketService() {
    //cuando se cree una nueva instancia del socketservice llama a este metodo
    this._initConfig();
  }

  void _initConfig() {
    // Dart client
    //esto lo sacamos de la pagina de io
    //192.168.1.56
    _socket = IO.io('http://192.168.1.56:3000/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    // socket.connect();
    //////////////////////////////////////////////////////
    /////el on es para escuchar
    this._socket.on('connect', (_) {
      //print('connect');
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.on('disconnect', (_) {
      //print('disconnect');
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    //esto es para mostrar en consola de visual lo que podamos ingresar mediante la consola del navegador
    // socket.on('nuevo-mensaje', (payload) {
    //   /**socket.emit('emitir-mensaje',{nombre:'Giancarlo',mensaje:'Hola'}); esto va en la consola del navegador para que aqui en la consola pueda recibirlos */
    //   print('nuevo-mensaje:');
    //   print('nombre:'+payload['nombre']);
    //   print('mensaje:'+payload['mensaje']);
    //   print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
    // });

    // socket.connect();
  }
}
