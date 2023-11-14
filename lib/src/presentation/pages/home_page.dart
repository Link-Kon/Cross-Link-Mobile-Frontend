import 'dart:async';

import 'package:cross_link/src/config/router/routes.dart';
import 'package:cross_link/src/presentation/widgets/navigation_drawer_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/border_widget.dart';
import '../../utils/common_widgets/section_bold_text_widget.dart';
import '../../utils/common_widgets/section_text_widget.dart';
import '../../utils/common_widgets/section_title_text_widget.dart';
import '../../utils/constants/nums.dart';
import '../../utils/constants/strings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.token});
  final String? token;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  StreamSubscription<User?>? _authSubscription;
  User? userLogged;
  bool existUser = false;
  List<_ChartData>? chartData;
  late String? token;

  @override
  void initState() {
    //TODO: replace with wearable data
    chartData = <_ChartData>[
      _ChartData(2005, 21, 28),
      _ChartData(2006, 24, 44),
      _ChartData(2007, 36, 48),
      _ChartData(2008, 38, 50),
      _ChartData(2009, 54, 66),
      _ChartData(2010, 57, 78),
      _ChartData(2011, 70, 184)
    ];

    _authSubscription = FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (mounted) {
        if (user != null) {
          existUser = true;
          userLogged = user;

        } else {
          userLogged = null;
          existUser = false;
        }

        setState(() {});
      }
    });

    token = widget.token;
    super.initState();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Palette.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {Navigator.pushNamed(context, Routes.DEVICE_SETTINGS);},
            icon: const Icon(Icons.share)
          ),
        ],
      ),
      body: Container(
        child: _buildHomePage(),
      ),
    );
  }

  Widget _buildHomePage() {
    return Container(
      padding: const EdgeInsets.only(left: defaultSize, right: defaultSize, bottom: defaultSize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[
                SectionTitleTextWidget(text: 'Hello, ${existUser? userLogged!.displayName : 'User'}!'),
                const SizedBox(height: 5),
                const SectionTextWidget(text: 'Descriptive text'),
                const SizedBox(height: 30),
                BorderWidget(child: Image.asset(defaultWearableImage)),
                const SizedBox(height: 30),
                const SectionBoldTextWidget(text: 'Heart rate summary'),
                const SizedBox(height: 5),
                BorderWidget(child: _buildDefaultLineChart(0)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SfCartesianChart _buildDefaultLineChart(int index) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      /*title: ChartTitle(
          text: 'Inflation - Consumer price',
          alignment: ChartAlignment.near,
          textStyle: const TextStyle(fontSize: 10)
      ),*/
      legend: Legend(
          isVisible: false,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,
          majorGridLines: const MajorGridLines(width: 0)
      ),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}%',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)
      ),
      series: _getDefaultLineSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<LineSeries<_ChartData, num>> _getDefaultLineSeries() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
        animationDuration: 2500,
        dataSource: chartData!,
        xValueMapper: (_ChartData sales, _) => sales.x,
        yValueMapper: (_ChartData sales, _) => sales.y,
        width: 2,
        name: 'Germany',
        markerSettings: const MarkerSettings(isVisible: true),
        color: Colors.red
      ),
    ];
  }

}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}