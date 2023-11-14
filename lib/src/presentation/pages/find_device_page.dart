import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../adapters/bluetooth_widgets.dart';
import '../../config/themes/app_colors.dart';
import 'device_page.dart';

class FindDevicePage extends StatefulWidget {
  const FindDevicePage({Key? key}) : super(key: key);

  @override
  State<FindDevicePage> createState() => _FindDevicePageState();
}

class _FindDevicePageState extends State<FindDevicePage> {
  final Map<DeviceIdentifier, ValueNotifier<bool>> isConnectingOrDisconnecting = {};

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find Devices Old'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Palette.black,
          elevation: 0,
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: FlutterBluePlus.isScanning,
          initialData: false,
          builder: (c, snapshot) {
            if (snapshot.data ?? false) {
              return FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Palette.black,
                onPressed: () async {
                  try {
                    FlutterBluePlus.stopScan();
                  } catch (e) {
                    print("Stop Scan Error: $e");
                  }
                },
                child: const Icon(Icons.stop),
              );
            } else {
              return FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                foregroundColor: Colors.white,
                onPressed: () async {
                  try {
                    await FlutterBluePlus.startScan(timeout: const Duration(seconds: 15), androidUsesFineLocation: false);

                  } catch (e) {
                    debugPrint("Start Scan Error: e");
                  }
                  setState(() {}); // force refresh of connectedSystemDevices
                },
                child: const Text("SCAN"),
              );
            }
          },
        ),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {}); // force refresh of connectedSystemDevices
            if (FlutterBluePlus.isScanningNow == false) {
              FlutterBluePlus.startScan(timeout: const Duration(seconds: 15), androidUsesFineLocation: false);
            }
            return Future.delayed(const Duration(milliseconds: 500)); // show refresh icon breifly
          },
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                StreamBuilder<List<BluetoothDevice>>(
                  stream: Stream.fromFuture(FlutterBluePlus.connectedSystemDevices),
                  initialData: const [],
                  builder: (c, snapshot) => Column(
                    children: (snapshot.data ?? [])
                        .map((d) => ListTile(
                      title: Text(d.localName),
                      subtitle: Text(d.remoteId.toString()),
                      trailing: StreamBuilder<BluetoothConnectionState>(
                        stream: d.connectionState,
                        initialData: BluetoothConnectionState.disconnected,
                        builder: (c, snapshot) {
                          if (snapshot.data == BluetoothConnectionState.connected) {
                            return ElevatedButton(
                              child: const Text('OPEN'),
                              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return DeviceScreen(device: d);
                                  },
                                  settings: const RouteSettings(name: '/deviceScreen'))),
                            );
                          }
                          if (snapshot.data == BluetoothConnectionState.disconnected) {
                            return ElevatedButton(
                              child: const Text('CONNECT'),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      isConnectingOrDisconnecting[d.remoteId] ??= ValueNotifier(true);
                                      isConnectingOrDisconnecting[d.remoteId]!.value = true;
                                      d.connect(timeout: const Duration(seconds: 35)).catchError((e) {
                                        print('Connect Error: $e');
                                      }).then((v) {
                                        isConnectingOrDisconnecting[d.remoteId] ??= ValueNotifier(false);
                                        isConnectingOrDisconnecting[d.remoteId]!.value = false;
                                      });
                                      return DeviceScreen(device: d);
                                    },
                                    settings: const RouteSettings(name: '/deviceScreen')));
                              }
                            );
                          }
                          return Text(snapshot.data.toString().toUpperCase().split('.')[1]);
                        },
                      ),
                    )).toList(),
                  ),
                ),
                StreamBuilder<List<ScanResult>>(
                  stream: FlutterBluePlus.scanResults,
                  initialData: const [],
                  builder: (c, snapshot) => Column(
                    children: (snapshot.data ?? [])
                        .map(
                          (r) => ScanResultTile(
                        result: r,
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              isConnectingOrDisconnecting[r.device.remoteId] ??= ValueNotifier(true);
                              isConnectingOrDisconnecting[r.device.remoteId]!.value = true;
                              r.device.connect(timeout: const Duration(seconds: 35)).catchError((e) {
                                print('Connect Error: $e');
                              }).then((v) {
                                isConnectingOrDisconnecting[r.device.remoteId] ??= ValueNotifier(false);
                                isConnectingOrDisconnecting[r.device.remoteId]!.value = false;
                              });
                              return DeviceScreen(device: r.device);
                            },
                            settings: const RouteSettings(name: '/deviceScreen'))),
                      ),
                    )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}