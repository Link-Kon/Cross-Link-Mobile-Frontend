import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../../main.dart';
import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/border_widget.dart';
import '../../utils/common_widgets/section_text_widget.dart';
import '../../utils/constants/nums.dart';
import '../cubits/wearable/wearable_cubit.dart';

class FindDevicesPage extends StatefulWidget {
  const FindDevicesPage({Key? key}) : super(key: key);

  @override
  State<FindDevicesPage> createState() => _FindDevicesPageState();
}

class _FindDevicesPageState extends State<FindDevicesPage> {
  final Map<DeviceIdentifier, ValueNotifier<bool>> isConnectingOrDisconnecting = {};

  bool searchDevices = false;
  String deviceConnectedId = '';
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aCubit = BlocProvider.of<WearableCubit>(context);

    return ScaffoldMessenger(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Find Devices'),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Palette.black,
          elevation: 0,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            setState(() {});
            if (FlutterBluePlus.isScanningNow == false) {
              FlutterBluePlus.startScan(timeout: const Duration(seconds: 7), androidUsesFineLocation: false);
            }
            return Future.delayed(const Duration(milliseconds: 500));
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BorderWidget(
                  radius: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            SizedBox(width: 10),
                            Text('Enable search', style: TextStyle(fontSize: regularTextSize),),
                          ],
                        ),
                        CupertinoSwitch(
                          value: searchDevices,
                          activeColor: Palette.primaryColor,
                          onChanged: (value) async {
                            searchDevices = value;

                            if (searchDevices) {
                              try {
                                await FlutterBluePlus.startScan(timeout: const Duration(seconds: 10), androidUsesFineLocation: false);
                                _timer = Timer(const Duration(seconds: 10), () {
                                  searchDevices = false;
                                  if (mounted) setState(() {});
                                });
                              } catch (e) {
                                debugPrint("Start Scan Error: e");
                              }
                            } else {
                              try {
                                FlutterBluePlus.stopScan();
                              } catch (e) {
                                debugPrint("Stop Scan Error: $e");
                              }
                            }
                            setState(() {}); // force refresh of connectedSystemDevices
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
                const SectionTextWidget(text: 'Available devices'),
                const SizedBox(height: 10),

                StreamBuilder<List<BluetoothDevice>>(
                  stream: Stream.fromFuture(FlutterBluePlus.connectedSystemDevices),
                  initialData: const [],
                  builder: (c, snapshot) => Column(
                    children: (snapshot.data ?? [])
                        //.where((d) => (d.remoteId.toString().split(':')[0] == '98') && (d.remoteId.toString().split(':')[1] == 'DA'))
                        .map((d) => BorderWidget(
                          child: ListTile(
                            title: Text(d.localName),
                            subtitle: const Text('Active device'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    alignment: Alignment.bottomCenter,
                                    actionsAlignment: MainAxisAlignment.start,
                                    backgroundColor: Palette.dialogBack,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: const Text('Unpair device'),
                                    content: SectionTextWidget(text: 'Unpair with ${d.localName.isEmpty? 'this device' : d.localName}'),
                                    actions: <TextButton>[
                                      TextButton(
                                        child: const Text('Cancel', style: TextStyle(fontSize: regularTextSize)),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text(activateGyroInfo? 'Deactivate Fall Detection' : 'Activate Fall Detection', style: const TextStyle(fontSize: regularTextSize)),
                                        onPressed: () {
                                          activateGyroInfo = !activateGyroInfo;
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: Text(activateHeartInfo? 'Deactivate Heart Analysis' : 'Activate Heart Analysis', style: const TextStyle(fontSize: regularTextSize)),
                                        onPressed: () {
                                          activateHeartInfo = !activateHeartInfo;
                                          Navigator.pop(context);
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Disconnect', style: TextStyle(fontSize: regularTextSize)),
                                        onPressed: () async {
                                          isConnectingOrDisconnecting[d.remoteId] ??= ValueNotifier(true);
                                          isConnectingOrDisconnecting[d.remoteId]!.value = true;
                                          try {
                                            await d.disconnect().then((value) {
                                              setState(() {});
                                              Navigator.pop(context);
                                            });
                                            aCubit.setDevice(device: null);
                                            debugPrint("Disconnect: Success");
                                          } catch (e) {
                                            debugPrint("Disconnect Error: $e");
                                          }
                                          isConnectingOrDisconnecting[d.remoteId] ??= ValueNotifier(false);
                                          isConnectingOrDisconnecting[d.remoteId]!.value = false;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        )
                    ).toList(),
                  ),
                ),

                const SizedBox(height: 10),

                StreamBuilder<List<ScanResult>>(
                  stream: FlutterBluePlus.scanResults,
                  initialData: const [],
                  builder: (c, snapshot) => Column(
                    children: (snapshot.data ?? [])
                      .where((r) => (r.device.remoteId.toString().split(':')[0] == '98') && (r.device.remoteId.toString().split(':')[1] == 'DA')
                    && (r.device.remoteId.toString() != deviceConnectedId))
                      .map((r) => BorderWidget(
                        child: ListTile(
                          title: Text(r.device.localName),
                          subtitle: Text(r.device.remoteId.toString()),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  alignment: Alignment.bottomCenter,
                                  actionsAlignment: MainAxisAlignment.start,
                                  backgroundColor: Palette.dialogBack,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  title: const Text('Pair device'),
                                  content: SectionTextWidget(text: 'Pair with ${r.device.localName.isEmpty? 'this device' : r.device.localName}'),
                                  actions: <TextButton>[
                                    TextButton(
                                      child: const Text('Cancel', style: TextStyle(fontSize: regularTextSize)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('Connect', style: TextStyle(fontSize: regularTextSize)),
                                      onPressed: () {
                                        isConnectingOrDisconnecting[r.device.remoteId] ??= ValueNotifier(true);
                                        isConnectingOrDisconnecting[r.device.remoteId]!.value = true;

                                        r.device.connect(timeout: const Duration(seconds: 35)).catchError((e) {
                                          debugPrint('Connect Error: $e');
                                        }).then((v) async {

                                          aCubit.setDevice(device: r.device);
                                          deviceConnectedId = r.device.remoteId.str;

                                          isConnectingOrDisconnecting[r.device.remoteId] ??= ValueNotifier(false);
                                          isConnectingOrDisconnecting[r.device.remoteId]!.value = false;

                                          //Obtener servicios y activar notificaciones
                                          await r.device.discoverServices(timeout: 5).then((v) async {
                                            List<BluetoothService> services = v;
                                            await r.device.requestMtu(223);

                                            for (BluetoothService service in services) {
                                              if (service.serviceUuid.toString().toUpperCase() == '0000FFE0-0000-1000-8000-00805F9B34FB') {
                                                for (BluetoothCharacteristic characteristic in service.characteristics) {
                                                  if (characteristic.characteristicUuid.toString().toUpperCase() == '0000FFE1-0000-1000-8000-00805F9B34FB') {
                                                    try {
                                                      debugPrint('activating notifications');
                                                      characteristic.setNotifyValue(true, timeout: 5);
                                                      debugPrint('Success');

                                                    } catch (e) {
                                                      debugPrint("Activating Notifications Error: $e");
                                                    }
                                                    setState(() {});
                                                    break;
                                                  }
                                                }
                                                break;
                                              }
                                            }
                                          });
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ).marginOnly(bottom: 10),
                    ).toList(),
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
