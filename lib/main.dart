import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cross_link/src/adapters/bluetooth_adapter.dart';
import 'package:cross_link/src/config/router/app_router.dart';
import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/config/themes/app_colors.dart';
import 'package:cross_link/src/locator.dart';
import 'package:cross_link/src/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

import 'amplifyconfiguration.dart';
import 'src/domain/repositories/illness_api_repository.dart';
import 'src/domain/repositories/relationship_api_repository.dart';
import 'src/domain/repositories/user_api_repository.dart';
import 'src/presentation/cubits/illness/illness_cubit.dart';
import 'src/presentation/cubits/user/user_cubit.dart';
import 'src/presentation/cubits/user_links/user_links_cubit.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();

  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  if (Platform.isAndroid) {
    WidgetsFlutterBinding.ensureInitialized();
    [
      Permission.location,
      Permission.storage,
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan
    ].request().then((status) {
      print('status: $status');
      runApp(const MyApp());
    });

  } else {
    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
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
        BlocProvider(create: (context) => UserCubit(
          locator<UserApiRepository>(),
        ))
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
        home: StreamBuilder<BluetoothAdapterState>(
            stream: FlutterBluePlus.adapterState,
            initialData: BluetoothAdapterState.unknown,
            builder: (c, snapshot) {
              final adapterState = snapshot.data;
              if (adapterState == BluetoothAdapterState.on) {
                return const HomePage();
              } else {
                FlutterBluePlus.stopScan();
                return BluetoothOffScreen(adapterState: adapterState);
              }
            }),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port)=> true;
  }
}