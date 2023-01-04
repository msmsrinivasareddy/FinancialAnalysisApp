import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Welcome extends StatefulWidget {
  final List<ChartData> assetData;

  final List<ChartData> liabilityData;
  Welcome(this.assetData, this.liabilityData);

  @override
  _WelcomeState createState() => _WelcomeState(assetData, liabilityData);
}

class _WelcomeState extends State<Welcome> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  final List<ChartData> assetData;

  final List<ChartData> liabilityData;
  _WelcomeState(this.assetData, this.liabilityData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: const Text('Finance App'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
          child: Container(
              child: SfCartesianChart(
                  primaryXAxis: CategoryAxis(),
                  // Chart title
                  title: ChartTitle(text: 'Asset & Liability Analysis'),
                  // Enable legend
                  legend: Legend(
                      isVisible: true,
                      // Border color and border width of legend
                      borderColor: Colors.black,
                      borderWidth: 2),
                  // Enable tooltip
                  tooltipBehavior: _tooltipBehavior,
                  series: <CartesianSeries>[
            LineSeries<ChartData, String>(
                name: 'Asset',
                dataSource: assetData,
                pointColorMapper: (ChartData asset, _) => Colors.green,
                xValueMapper: (ChartData asset, _) => asset.year,
                yValueMapper: (ChartData asset, _) => asset.amount,
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true)),
            LineSeries<ChartData, String>(
                name: 'Liability',
                dataSource: liabilityData,
                pointColorMapper: (ChartData asset, _) => Colors.red,
                xValueMapper: (ChartData asset, _) => asset.year,
                yValueMapper: (ChartData asset, _) => asset.amount,
                // Enable data label
                dataLabelSettings: DataLabelSettings(isVisible: true))
          ]))),
    );
  }
}

class ChartData {
  ChartData(this.year, this.amount);
  var year;
  var amount;
}
