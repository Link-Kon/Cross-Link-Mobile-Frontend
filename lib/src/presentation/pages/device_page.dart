import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../config/themes/app_colors.dart';

class DeviceScreen extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final Map<DeviceIdentifier, ValueNotifier<bool>> isConnectingOrDisconnecting = {};

  List<int> _getRandomBytes() {
    final math = Random();
    return [math.nextInt(255), math.nextInt(255), math.nextInt(255), math.nextInt(255)];
  }

  List<Widget> _buildServiceTiles(BuildContext context, List<BluetoothService> services) {
    return services
        .map(
          (s) => ServiceTile(
        service: s,
        characteristicTiles: s.characteristics
            .map(
              (c) => CharacteristicTile(
            characteristic: c,
            onReadPressed: () async {
              try {
                await c.read().then((value) => print('value $value'));
                print("Read: Success");
              } catch (e) {
                print("Read Error: $e");
              }
            },
            onWritePressed: () async {
              try {
                await c.write(_getRandomBytes(), withoutResponse: c.properties.writeWithoutResponse);
                print("Write: Success");
                if (c.properties.read) {
                  await c.read();
                }
              } catch (e) {
                print("Write Error: $e");
              }
            },
            onNotificationPressed: () async {
              try {
                String op = c.isNotifying == false? "Subscribe" : "Unubscribe";
                print("notifying a : ${c.isNotifying}");
                bool newValue = c.isNotifying;
                print('bool: $newValue : ${!newValue}');
                await c.setNotifyValue(!newValue, timeout: 5).then((value) => print("notifying b : ${c.isNotifying}"));
                print("$op : Success");
                if (c.properties.read) {
                  print("here");
                  await c.read();
                }
              } catch (e) {
                print("Write Error: $e");
              }
            },
            descriptorTiles: c.descriptors
                .map(
                  (d) => DescriptorTile(
                descriptor: d,
                onReadPressed: () async {
                  try {
                    await d.read();
                    print("Read: Success");
                  } catch (e) {
                    print("Read Error: $e");
                  }
                },
                onWritePressed: () async {
                  try {
                    await d.write([1]).then((value) => print('value'));
                    print("Write: Success");
                  } catch (e) {
                    print("Write error: $e");
                  }
                },
              ),
            ).toList(),
          ),
        ).toList(),
      ),
    ).toList();
  }

  @override
  void initState() {
    print('state: ${widget.device.connectionState.elementAt(0)}');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.device.localName),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Palette.black,
          elevation: 0,
          actions: <Widget>[
            StreamBuilder<BluetoothConnectionState>(
              stream: widget.device.connectionState,
              builder: (c, snapshot) {
                VoidCallback? onPressed;
                String text;
                switch (snapshot.data) {
                  case BluetoothConnectionState.connected:
                    onPressed = () async {
                      isConnectingOrDisconnecting[widget.device.remoteId] ??= ValueNotifier(true);
                      isConnectingOrDisconnecting[widget.device.remoteId]!.value = true;
                      try {
                        await widget.device.disconnect();
                        print("Disconnect: Success");
                      } catch (e) {
                        print("Disconnect Error: $e");
                      }
                      isConnectingOrDisconnecting[widget.device.remoteId] ??= ValueNotifier(false);
                      isConnectingOrDisconnecting[widget.device.remoteId]!.value = false;
                      setState(() {});
                    };
                    text = 'DISCONNECT';
                    break;
                  case BluetoothConnectionState.disconnected:
                    onPressed = () async {
                      isConnectingOrDisconnecting[widget.device.remoteId] ??= ValueNotifier(true);
                      isConnectingOrDisconnecting[widget.device.remoteId]!.value = true;
                      try {
                        await widget.device.connect(timeout: const Duration(seconds: 35));
                        print("Connect: Success");
                      } catch (e) {
                        print("Connect Error: $e");
                      }
                      isConnectingOrDisconnecting[widget.device.remoteId] ??= ValueNotifier(false);
                      isConnectingOrDisconnecting[widget.device.remoteId]!.value = false;
                      setState(() {});
                    };
                    text = 'CONNECT';
                    break;
                  default:
                    isConnectingOrDisconnecting[widget.device.remoteId] ??= ValueNotifier(false);
                    isConnectingOrDisconnecting[widget.device.remoteId]!.value == false;
                    onPressed = null;
                    text = snapshot.data.toString().split(".").last.toUpperCase();
                    break;
                }
                return ValueListenableBuilder<bool>(
                  valueListenable: isConnectingOrDisconnecting[widget.device.remoteId]!,
                  builder: (context, value, child) {
                    isConnectingOrDisconnecting[widget.device.remoteId] ??= ValueNotifier(false);
                    if (isConnectingOrDisconnecting[widget.device.remoteId]!.value == true) {
                      // Show spinner when connecting or disconnecting
                      return const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: AspectRatio(
                          aspectRatio: 1.0,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.black12,
                            color: Colors.black26,
                          ),
                        ),
                      );
                    } else {
                      return TextButton(
                        onPressed: onPressed,
                        child: Text(
                          text,
                          style: const TextStyle(fontSize: 14),
                        )
                      );
                    }
                  }
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<BluetoothConnectionState>(
                stream: widget.device.connectionState,
                initialData: BluetoothConnectionState.connecting,
                builder: (c, snapshot) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('${widget.device.remoteId}'),
                    ),
                    ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          snapshot.data == BluetoothConnectionState.connected
                              ? const Icon(Icons.bluetooth_connected)
                              : const Icon(Icons.bluetooth_disabled),
                          snapshot.data == BluetoothConnectionState.connected
                              ? StreamBuilder<int>(
                              stream: rssiStream(maxItems: 1),
                              builder: (context, snapshot) {
                                return Text(snapshot.hasData ? '${snapshot.data}dBm' : '',
                                    style: Theme.of(context).textTheme.bodySmall);
                              })
                              : Text('', style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                      title: Text('Device is ${snapshot.data.toString().split('.')[1]}.'),
                      trailing: StreamBuilder<bool>(
                        stream: widget.device.isDiscoveringServices,
                        initialData: false,
                        builder: (c, snapshot) => IndexedStack(
                          index: (snapshot.data ?? false) ? 1 : 0,
                          children: <Widget>[
                            TextButton(
                              child: const Text("Get Services"),
                              onPressed: () async {
                                try {
                                  await widget.device.discoverServices(timeout: 5);
                                  print("Discover Services: Success");
                                } catch (e) {
                                  print("Discover Services Error: $e");
                                }
                              },
                            ),
                            const IconButton(
                              icon: SizedBox(
                                width: 18.0,
                                height: 18.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation(Colors.grey),
                                ),
                              ),
                              onPressed: null,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<int>(
                stream: widget.device.mtu,
                initialData: 0,
                builder: (c, snapshot) => ListTile(
                  title: const Text('MTU Size'),
                  subtitle: Text('${snapshot.data} bytes'),
                  trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () async {
                        try {
                          await widget.device.requestMtu(223);
                          print("Request Mtu: Success");
                        } catch (e) {
                          print("Change Mtu Error: $e");
                        }
                      }),
                ),
              ),
              StreamBuilder<List<BluetoothService>>(
                stream: widget.device.servicesStream,
                initialData: const [],
                builder: (c, snapshot) {
                  return Column(
                    children: _buildServiceTiles(context, snapshot.data ?? []),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<int> rssiStream({Duration frequency = const Duration(seconds: 5), int? maxItems}) async* {
    var isConnected = true;
    final subscription = widget.device.connectionState.listen((v) {
      isConnected = v == BluetoothConnectionState.connected;
    });
    int i = 0;
    while (isConnected && (maxItems == null || i < maxItems)) {
      try {
        yield await widget.device.readRssi();
      } catch (e) {
        print("Error reading RSSI: $e");
        break;
      }
      await Future.delayed(frequency);
      i++;
    }
    // Device disconnected, stopping RSSI stream
    subscription.cancel();
  }
}

///////////////////////

class ServiceTile extends StatelessWidget {
  final BluetoothService service;
  final List<CharacteristicTile> characteristicTiles;

  const ServiceTile({Key? key, required this.service, required this.characteristicTiles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (characteristicTiles.isNotEmpty) {
      return ExpansionTile(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Service'),
            Text('0x${service.serviceUuid.toString().toUpperCase()}',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color))
          ],
        ),
        children: characteristicTiles,
      );
    } else {
      return ListTile(
        title: const Text('Service'),
        subtitle: Text('0x${service.serviceUuid.toString().toUpperCase()}'),
      );
    }
  }
}


class CharacteristicTile extends StatefulWidget {
  final BluetoothCharacteristic characteristic;
  final List<DescriptorTile> descriptorTiles;
  final Future<void> Function()? onReadPressed;
  final Future<void> Function()? onWritePressed;
  final Future<void> Function()? onNotificationPressed;

  const CharacteristicTile(
      {Key? key,
        required this.characteristic,
        required this.descriptorTiles,
        this.onReadPressed,
        this.onWritePressed,
        this.onNotificationPressed})
      : super(key: key);

  @override
  State<CharacteristicTile> createState() => _CharacteristicTileState();
}

class _CharacteristicTileState extends State<CharacteristicTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: widget.characteristic.onValueReceived,
      initialData: widget.characteristic.lastValue,
      builder: (context, snapshot) {
        final List<int>? value = snapshot.data;
        print('values: $value');
        return ExpansionTile(
          title: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text('Characteristic'),
                Text(
                  '0x${widget.characteristic.characteristicUuid.toString().toUpperCase()}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color),
                ),
                Row(
                  children: [
                    if (widget.characteristic.properties.read)
                      TextButton(
                          child: const Text("Read"),
                          onPressed: () async {
                            await widget.onReadPressed!();
                            setState(() {});
                          }),
                    if (widget.characteristic.properties.write)
                      TextButton(
                          child: Text(widget.characteristic.properties.writeWithoutResponse ? "WriteNoResp" : "Write"),
                          onPressed: () async {
                            await widget.onWritePressed!();
                            setState(() {});
                          }),
                    if (widget.characteristic.properties.notify || widget.characteristic.properties.indicate)
                      TextButton(
                          child: Text(widget.characteristic.isNotifying ? "Unsubscribe" : "Subscribe"),
                          onPressed: () async {
                            print('before ${widget.characteristic.isNotifying}');
                            await widget.onNotificationPressed!();
                            print('after ${widget.characteristic.isNotifying}');
                            setState(() {});
                          })
                  ],
                )
              ],
            ),
            subtitle: Text(value.toString()),
            contentPadding: const EdgeInsets.all(0.0),
          ),
          children: widget.descriptorTiles,
        );
      },
    );
  }
}

class DescriptorTile extends StatelessWidget {
  final BluetoothDescriptor descriptor;
  final VoidCallback? onReadPressed;
  final VoidCallback? onWritePressed;

  const DescriptorTile({Key? key, required this.descriptor, this.onReadPressed, this.onWritePressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Descriptor'),
          Text('0x${descriptor.descriptorUuid.toString().toUpperCase()}',
              style:
              Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color))
        ],
      ),
      subtitle: StreamBuilder<List<int>>(
        stream: descriptor.onValueReceived,
        initialData: descriptor.lastValue,
        builder: (c, snapshot) => Text(snapshot.data.toString()),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.file_download,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onReadPressed,
          ),
          IconButton(
            icon: Icon(
              Icons.file_upload,
              color: Theme.of(context).iconTheme.color?.withOpacity(0.5),
            ),
            onPressed: onWritePressed,
          )
        ],
      ),
    );
  }
}