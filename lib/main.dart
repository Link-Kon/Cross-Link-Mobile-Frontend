import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

//import 'amplifyconfiguration.dart';
import 'src/adapters/bluetooth_adapter.dart';
import 'src/config/router/app_router.dart';
import 'src/config/router/routes.dart';
import 'src/config/themes/app_colors.dart';
import 'src/domain/models/gyro_info.dart';
//import 'src/domain/models/gyro_info_list.dart';
import 'src/domain/models/heart_info.dart';
//import 'src/domain/models/heart_info_list.dart';
import 'src/domain/repositories/gyro_info_api_repository.dart';
import 'src/domain/repositories/heart_info_api_repository.dart';
import 'src/domain/repositories/illness_api_repository.dart';
import 'src/domain/repositories/relationship_api_repository.dart';
import 'src/domain/repositories/user_api_repository.dart';
import 'src/domain/repositories/user_data_api_repository.dart';
import 'src/domain/repositories/user_patient_api_repository.dart';
import 'src/locator.dart';
import 'src/presentation/cubits/gyro_info/gyro_info_cubit.dart';
import 'src/presentation/cubits/heart_info/heart_info_cubit.dart';
import 'src/presentation/cubits/illness/illness_cubit.dart';
import 'src/presentation/cubits/user/user_cubit.dart';
import 'src/presentation/cubits/user_data/user_data_cubit.dart';
import 'src/presentation/cubits/user_links/user_links_cubit.dart';
import 'src/presentation/cubits/user_patient/user_patient_cubit.dart';
import 'src/presentation/cubits/wearable/wearable_cubit.dart';
import 'src/presentation/cubits/wearable/wearable_state.dart';
import 'src/presentation/pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'src/utils/functions/auth_service.dart';
import 'src/utils/functions/firebase_api.dart';

final navigatorKey = GlobalKey<NavigatorState>();
WearableCubit? wearableCubitGlobal;
String? deviceTokenGlobal;
bool activateGyroInfo = true;
bool activateHeartInfo = true;


///Amplify
Future<void> myAsyncNotificationReceivedHandler(
    PushNotificationMessage notification) async {
  // Process the received push notification message in the background
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  wearableCubitGlobal = WearableCubit();
  GyroInfoCubit gyroInfoCubit = GyroInfoCubit(locator<GyroInfoApiRepository>(),);
  HeartInfoCubit heartInfoCubit = HeartInfoCubit(locator<HeartInfoApiRepository>(),);
  UserCubit userCubit = UserCubit(locator<UserApiRepository>(),);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  deviceTokenGlobal = await FirebaseApi().initNotification();

  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  AuthService().reAuthenticate(); //Timer of 60 minutes

  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) async {
      debugPrint('status: $status');
      runApp(MyApp(
        wearableCubit: wearableCubitGlobal!,
        gyroInfoCubit: gyroInfoCubit,
        heartInfoCubit: heartInfoCubit,
        userCubit: userCubit,
        token: deviceTokenGlobal,
      ));
    });

  } else {
    //final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
    runApp(MyApp(
      wearableCubit: wearableCubitGlobal!,
      gyroInfoCubit: gyroInfoCubit,
      heartInfoCubit: heartInfoCubit,
      userCubit: userCubit,
      token: deviceTokenGlobal,
    ));
  }

  scheduleBodyInfoRequest(wearableCubitGlobal!, gyroInfoCubit, heartInfoCubit, userCubit);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key,
    required this.wearableCubit,
    required this.gyroInfoCubit,
    required this.heartInfoCubit,
    required this.userCubit,
    required this.token
  });

  final WearableCubit wearableCubit;
  final GyroInfoCubit gyroInfoCubit;
  final HeartInfoCubit heartInfoCubit;
  final UserCubit userCubit;
  final String? token;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MaterialColor customColor = const MaterialColor(
    0xFF82DE0E, <int, Color> {
      50: Color(0xFFE9F8D9),
      100: Color(0xFFD4F1B5),
      200: Color(0xFFBCEA8F),
      300: Color(0xFFA3E269),
      400: Color(0xFF8FDC4A),
      500: Color(0xFF82DE0E), // The default color
      600: Color(0xFF79D90C),
      700: Color(0xFF6ED208),
      800: Color(0xFF63CB04),
      900: Color(0xFF4FC200),
    },
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( //initialize the multi-bloc provider
      providers: [
        BlocProvider(create: (context) => UserLinksCubit(
          locator<RelationshipApiRepository>(),
        )),
        BlocProvider(create: (context) => IllnessCubit(
          locator<IllnessApiRepository>(),
        )),
        BlocProvider(create: (context) => UserDataCubit(
          locator<UserDataApiRepository>(),
        )),
        BlocProvider(create: (context) => UserPatientCubit(
          locator<UserPatientApiRepository>(),
        )),
        BlocProvider(create: (context) => widget.userCubit),
        BlocProvider(create: (context) => widget.wearableCubit),
        BlocProvider(create: (context) => widget.gyroInfoCubit),
        BlocProvider(create: (context) => widget.heartInfoCubit)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cross Link App',
        theme: ThemeData(
          primarySwatch: customColor,
          splashColor: Palette.splashColor,
          highlightColor: Palette.highlightColor,
          scaffoldBackgroundColor: Colors.white, //default background
        ),
        initialRoute: Routes.HOME,
        routes: appRoutes(),
        navigatorObservers: [BluetoothAdapterStateObserver()],
        navigatorKey: navigatorKey,
        home: StreamBuilder<BluetoothAdapterState>(
            stream: FlutterBluePlus.adapterState,
            initialData: BluetoothAdapterState.unknown,
            builder: (c, snapshot) {
              final adapterState = snapshot.data;
              if (adapterState == BluetoothAdapterState.on) {
                return HomePage(token: widget.token!);
              } else {
                FlutterBluePlus.stopScan();
                return BluetoothOffScreen(adapterState: adapterState);
              }
            }),
      ),
    );
  }
}

void scheduleBodyInfoRequest(WearableCubit wearableCubit, GyroInfoCubit gyroInfoCubit, HeartInfoCubit heartInfoCubit, UserCubit userCubit) {
  BluetoothCharacteristic? bluetoothCharacteristic;
  StreamSubscription? subscription;
  List<GyroInfo> gyroList = [];
  List<HeartInfo> heartList = [];
  //var i = 0;

  Timer.periodic(const Duration(seconds: 30), (Timer timer) {
    switch (wearableCubit.state.runtimeType) {
      case WearableLoading:
        debugPrint('WearableLoading');
        break;

      case WearableSuccess:
        if (wearableCubit.state.device == null) {
          debugPrint('No Active Wearable');

        } else {
          debugPrint('WearableSuccess');
          if (bluetoothCharacteristic == null) {
            bluetoothCharacteristic = receivedBodyData(wearableCubit.state.device!.servicesList!);
          } else {
            Timer(const Duration(seconds: 30), () {
              subscription?.cancel();
            });

            subscription = bluetoothCharacteristic!.onValueReceived.listen((value) {
              //print(i+1);
              //i = i+1;
              gyroList.add(recollectGyroInfo(value));
              heartList.add(recollectHeartInfo(value));
            });

            //print(gyroList.length);
            //print(heartList.length);

            debugPrint('send info');
            String code = userCubit.state.response!.userCode;
            String username = userCubit.state.response!.name;

            //var g = GyroInfoList(username: 'username', userCode: 'code', list: gyroList);
            //var h = HeartInfoList(username: 'username', userCode: 'code', list: heartList);

            //if (activateGyroInfo) print(g.toJson());
            //if (activateHeartInfo) print(h.toJson());

            if (activateGyroInfo) gyroInfoCubit.addGyroInfo(userCode: code, username: username, list: gyroList);
            if (activateHeartInfo) heartInfoCubit.addHeartInfo(userCode: code, username: username, list: heartList);
          }

          gyroList.clear();
          heartList.clear();
          //i = 0;
        }
        break;
    }
  });
}

BluetoothCharacteristic? receivedBodyData(List<BluetoothService> services) {
  for (BluetoothService service in services) {
    if (service.serviceUuid.toString().toUpperCase() == '0000FFE0-0000-1000-8000-00805F9B34FB') {
      for (BluetoothCharacteristic characteristic in service.characteristics) {
        if (characteristic.characteristicUuid.toString().toUpperCase() == '0000FFE1-0000-1000-8000-00805F9B34FB') {
          return characteristic;
        }
      }
      break;
    }
  }
  return null;
}

GyroInfo recollectGyroInfo(List<int> information) {
  const asciiDecoder = AsciiDecoder();
  var info = asciiDecoder.convert(information).split('|');
  //debugPrint('result ${asciiDecoder.convert(information)}');

  return GyroInfo(
    accelX: double.parse(info[3].split(':')[1]),
    accelY: double.parse(info[4].split(':')[1]),
    accelZ: double.parse(info[5].split(':')[1]),
    rotX: double.parse(info[6].split(':')[1]),
    rotY: double.parse(info[7].split(':')[1]),
    rotZ: double.parse(info[8].split(':')[1]),
  );
}

HeartInfo recollectHeartInfo(List<int> information) {
  const asciiDecoder = AsciiDecoder();
  var info = asciiDecoder.convert(information).split('|');
  //debugPrint('result ${asciiDecoder.convert(information)}');

  return HeartInfo(
    red: double.parse(info[1].split(':')[1]),
    infraRed: double.parse(info[2].split(':')[1]),
  );
}


class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port)=> true;
  }
}