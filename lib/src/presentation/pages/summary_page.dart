import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../config/themes/app_colors.dart';
import '../../utils/common_widgets/border_widget.dart';
import '../../utils/common_widgets/section_bold_text_widget.dart';
import '../../utils/common_widgets/section_text_widget.dart';

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
    /*problemList.add('Problem 4');
    problemList.add('Problem 5');
    problemList.add('Problem 6');*/

    selected = 0;

    super.initState();
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
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Palette.black,
        elevation: 0,
      ),
      body: SingleChildScrollView (
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  //SectionTitleTextWidget(text: 'Summary'),
                  SizedBox(height: 5),
                  SectionTextWidget(text: 'Health summary and some recommendations'),
                  SizedBox(height: 20),
                ],
              ),
            ),
            tabBar(),
            Container(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 20),

                  const SectionBoldTextWidget(text: 'Subtitle 1'),
                  const SizedBox(height: 5),
                  BorderWidget(child: _buildDefaultLineChart(selected)),

                  const SizedBox(height: 30),

                  const SectionBoldTextWidget(text: 'Subtitle 2'),
                  const SizedBox(height: 5),
                  BorderWidget(child: _buildDefaultLineChart(0)),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  SfCartesianChart _buildDefaultLineChart(int index) {
    return SfCartesianChart(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      plotAreaBorderWidth: 0,
      //title: ChartTitle(text: 'Inflation - Consumer price', alignment: ChartAlignment.near),
      legend: Legend(
        isVisible: false,
        overflowMode: LegendItemOverflowMode.wrap
      ),
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
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade200,)
          )
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        physics: const AlwaysScrollableScrollPhysics(),// NeverScrollableScrollPhysics(),
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
                  bottom: BorderSide(color: selected==index? Palette.primaryColor : Colors.transparent,)
                )
            ),
            child: Text(problemList[index],
              style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500,
                color: selected == index? Palette.textSelected : Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        separatorBuilder: (context, index) => SizedBox(width: problemList.length<4? 40 : 20),
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