import 'dart:io';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cross_link/src/config/router/app_router.dart';
import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
          primarySwatch: Colors.blue,
        ),
        initialRoute: Routes.HOME,
        routes: appRoutes(),
        //home: BlocProvider,
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