import 'package:cross_link/src/utils/constants/nums.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});
  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>{

  int selected = 0;

  List<_ChartData>? chartData;
  List<String> problemList = [];

  @override
  void initState() {
    super.initState();
    chartData = <_ChartData>[
      _ChartData(2005, 21, 28),
      _ChartData(2006, 24, 44),
      _ChartData(2007, 36, 48),
      _ChartData(2008, 38, 50),
      _ChartData(2009, 54, 66),
      _ChartData(2010, 57, 78),
      _ChartData(2011, 70, 184)
    ];

    problemList.add('Problem 1');
    problemList.add('Problem 2');
    problemList.add('Problem 3');

    selected = 0;
  }

  @override
  void dispose() {
    chartData!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Healthcare Summary"),
      ),
      body: SingleChildScrollView (
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
          children: <Widget>[
            const Text("Here you can see a detailed summary of your health and some recommendations"),
            const SizedBox(height: 20,),
            tabBar(),
            const SizedBox(height: 20,),
            _buildDefaultLineChart(selected),
            const SizedBox(height: 40,),
            _buildDefaultLineChart(0),
            const Text('End graphic'),
          ],
        ),
      ),
    );
  }

  SfCartesianChart _buildDefaultLineChart(int index) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Inflation - Consumer price'),
      legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap),
      primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          interval: 2,
          majorGridLines: const MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          labelFormat: '{value}%',
          axisLine: const AxisLine(width: 0),
          majorTickLines: const MajorTickLines(color: Colors.transparent)),
      series: _getSeries(index),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<LineSeries<_ChartData, num>> _getSeries(int index) {
    List<LineSeries<_ChartData, num>> temp = [];
    switch (index) {
      case 0:
        temp = _getDefaultLineSeries1();
        break;
      case 1:
        temp = _getDefaultLineSeries2();
        break;
      case 2:
        temp = _getDefaultLineSeries3();
        break;
    }
    return temp;
  }

  List<LineSeries<_ChartData, num>> _getDefaultLineSeries1() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Germany',
          markerSettings: const MarkerSettings(isVisible: true)),
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'England',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }

  List<LineSeries<_ChartData, num>> _getDefaultLineSeries2() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          width: 2,
          name: 'England',
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y2,
          markerSettings: const MarkerSettings(isVisible: true))
    ];
  }

  List<LineSeries<_ChartData, num>> _getDefaultLineSeries3() {
    return <LineSeries<_ChartData, num>>[
      LineSeries<_ChartData, num>(
          animationDuration: 2500,
          dataSource: chartData!,
          xValueMapper: (_ChartData sales, _) => sales.x,
          yValueMapper: (_ChartData sales, _) => sales.y,
          width: 2,
          name: 'Germany',
          markerSettings: const MarkerSettings(isVisible: true)),
    ];
  }

  Container tabBar() {
    return Container(
      height: 30,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.black,)
          )
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: problemList.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              debugPrint(problemList[index]);
              selected = index;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: selected==index? Colors.black : Colors.transparent,)
                )
            ),
            child: Text(problemList[index],
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        separatorBuilder: (context, index) {
          return const Padding(padding: EdgeInsets.symmetric(horizontal: 10));
        },
      ),
    );
  }

}

class _ChartData {
  _ChartData(this.x, this.y, this.y2);
  final double x;
  final double y;
  final double y2;
}