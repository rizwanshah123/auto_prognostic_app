import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:sizer/sizer.dart';

import '../controller/home_screen_controller.dart';

class PredictionScreen extends StatelessWidget {
  PredictionScreen({super.key});
  final ObdController obdController = Get.put(ObdController());

  @override
  Widget build(BuildContext context) {
    print("Explaination Data is ${obdController.explanation}");
    final List<_ChartData> data = [
      _ChartData('Engine RPM', obdController.explanation[0]),
      _ChartData('Lub Oil Pressure', obdController.explanation[1]),
      _ChartData('Coolant Pressure', obdController.explanation[3]),
      _ChartData('Lub Oil Temp', obdController.explanation[4]),
      _ChartData('Coolant Temp', obdController.explanation[5]),
      _ChartData('Fuel Pressure', obdController.explanation[2]),
    ];
    List<_ImpactData> impacts = data.map((item) {
      String impact;
      if (item.value > 0) {
        impact = 'Improves the Result';
      } else if (item.value < 0) {
        impact = 'Worsens the Result';
      } else {
        impact = 'Does Not Change the Result';
      }
      return _ImpactData(item.metric, impact);
    }).toList();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Result Screen"),
          centerTitle: true,
        ),
        body: SizedBox(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 1.h),
                SfCartesianChart(
                  title: const ChartTitle(text: 'SHAP Values Explanation'),
                  primaryXAxis: const CategoryAxis(
                    title: AxisTitle(text: 'Features'),
                    labelRotation: 10, // Rotate labels if they overlap
                  ),
                  primaryYAxis: const NumericAxis(
                    edgeLabelPlacement: EdgeLabelPlacement.shift,
                    title: AxisTitle(text: 'SHAP Values'),
                    labelFormat: '{value}', // Format the Y-axis labels
                  ),
                  series: <CartesianSeries<_ChartData, String>>[
                    BarSeries<_ChartData, String>(
                      dataSource: data,
                      xValueMapper: (_ChartData data, _) => data.metric,
                      yValueMapper: (_ChartData data, _) => data.value,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      color: Colors.blue, // Set bar color
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                const Text("Impact of Each Features",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: 2.h),
                DataTable(
                  border: TableBorder.all(),
                  columns: const [
                    DataColumn(label: Text('Feature Name')),
                    DataColumn(label: Text('Impact')),
                  ],
                  rows: impacts.map((impactData) {
                    return DataRow(
                      cells: [
                        DataCell(Text(impactData.feature)),
                        DataCell(Text(impactData.impact)),
                      ],
                    );
                  }).toList(),
                ),
                SizedBox(height: 2.h),
                const Text("Prognostic",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    )),
                SizedBox(height: 1.h),
                Text(
                    obdController.prediction.value == 1
                        ? "You are Good to Go!"
                        : "Car Need Maintenance",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                        color: obdController.prediction.value == 1
                            ? Colors.black
                            : Colors.red)),
                SizedBox(height: 2.h),
                const Text("Feature Values",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    )),
                SizedBox(height: 1.h),
                DataTable(
                  border: TableBorder.all(),
                  columns: const [
                    DataColumn(label: Text('Parameter')),
                    DataColumn(label: Text('Value')),
                  ],
                  rows: obdController.data.entries
                      .map((entry) => DataRow(cells: [
                            DataCell(Text(entry.key)),
                            DataCell(Text(entry.value.toString())),
                          ]))
                      .toList(),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.metric, this.value);

  final String metric;
  final double value;
}

class _ImpactData {
  _ImpactData(this.feature, this.impact);

  final String feature; // Feature name
  final String impact; // Impact description
}
