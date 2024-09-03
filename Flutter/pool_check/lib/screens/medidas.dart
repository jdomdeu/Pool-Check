import 'dart:convert';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'datos.dart';

class MedidasPage extends StatefulWidget {
  const MedidasPage({super.key});

  @override
  State<MedidasPage> createState() => _MedidasPageState();
}

class _MedidasPageState extends State<MedidasPage> {
  final _bluetooth = FlutterBluetoothSerial.instance;
  bool _bluetoothState = false;
  bool _isConnecting = false;
  BluetoothConnection? _connection;
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _deviceConnected;
  int times = 0;
  Stream<String>? _dataStream;

  void _getDevices() async {
    var res = await _bluetooth.getBondedDevices();
    setState(() => _devices = res);
  }

  void _receiveData() {
    _dataStream = _connection?.input?.map((event) => ascii.decode(event));
  }

  void _sendData(String data) {
    if (_connection?.isConnected ?? false) {
      _connection?.output.add(ascii.encode(data));
    }
  }

  void _requestPermission() async {
    await Permission.location.request();
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
    _bluetooth.state.then((state) {
      setState(() => _bluetoothState = state.isEnabled);
    });
    _bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BluetoothState.STATE_OFF:
          setState(() => _bluetoothState = false);
          break;
        case BluetoothState.STATE_ON:
          setState(() => _bluetoothState = true);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CONEXION BLUETOOTH',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          _controlBT(),
          _infoDevice(),
          Expanded(child: _listDevices()),
          if (_connection?.isConnected ?? false) _sendDataButton(),
        ],
      ),
    );
  }

  Widget _controlBT() {
    return Container(
      color: Colors.blue.shade100,
      child: SwitchListTile(
        value: _bluetoothState,
        onChanged: (bool value) async {
          if (value) {
            await _bluetooth.requestEnable();
          } else {
            await _bluetooth.requestDisable();
          }
        },
        tileColor: Colors.blue.shade100,
        title: Text(
          _bluetoothState ? "Bluetooth encendido" : "Bluetooth apagado",
          style: TextStyle(color: Colors.blue.shade900),
        ),
      ),
    );
  }

  Widget _infoDevice() {
    return ListTile(
      tileColor: Colors.blue.shade50,
      title: Text(
        "Conectado a: ${_deviceConnected?.name ?? "ninguno"}",
        style: TextStyle(color: Colors.blue.shade900),
      ),
      trailing: _connection?.isConnected ?? false
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () async {
                    await _connection?.finish();
                    setState(() => _deviceConnected = null);
                  },
                  child: const Text("Desconectar"),
                ),
              ],
            )
          : TextButton(
              onPressed: _getDevices,
              child: const Text("Ver dispositivos"),
            ),
    );
  }

  Widget _listDevices() {
    return _isConnecting
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Container(
              color: Colors.blue.shade50,
              child: Column(
                children: [
                  for (final device in _devices)
                    ListTile(
                      title: Text(device.name ?? device.address,
                          style: TextStyle(color: Colors.blue.shade900)),
                      trailing: TextButton(
                        child: const Text('Conectar'),
                        onPressed: () async {
                          setState(() => _isConnecting = true);
                          _connection = await BluetoothConnection.toAddress(device.address);
                          _deviceConnected = device;
                          _devices = [];
                          _isConnecting = false;
                          _receiveData();
                          setState(() {});
                        },
                      ),
                    )
                ],
              ),
            ),
          );
  }

  Widget _sendDataButton() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        width: 350,
        height: 100,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DatosPage(dataStream: _dataStream),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            ),
            icon: const Icon(
              Icons.align_horizontal_left_rounded,
              color: Colors.white,
              size: 35,
            ),
            label: Text(
              "VER MEDIDAS",
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
