import 'package:demo_app2/presentation/screens/1_patient_screens/history_widget/nice_date_time.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/models/medical/2_medical_check_glucose.dart';

class DongChart extends StatelessWidget {
  final List<MedicalCheckGlucose> medicalCheckGlucoses;
  DongChart({required this.medicalCheckGlucoses});

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
          interval: 1,
          autoScrollingDelta: 4,
          majorGridLines: MajorGridLines(width: 0),
          majorTickLines: MajorTickLines(width: 0),
          // labelPosition: ChartDataLabelPosition.inside,
          // tickPosition: TickPosition.inside,
          // edgeLabelPlacement: EdgeLabelPlacement.shift,
        ),
        primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 20,
            plotBands: [
              PlotBand(
                  isVisible: true,
                  // provided the same y-value to start and end property in order to render the plotline for that y-value.
                  start: 3.9,
                  end: 8.3,
                  borderWidth: 1,
                  color: Color.fromARGB(255, 190, 254, 118),
                  borderColor: Color.fromARGB(255, 29, 226, 35),
                  // Label text for the reference plot line
                  textStyle: TextStyle(color: Colors.green),
                  // provided dash array to render the line in dashed format.
                  dashArray: <double>[10, 10])
            ],
            majorGridLines: MajorGridLines(
              width: 0,
            )),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
        ),
        // Chart title
        title: ChartTitle(
          text: 'Đường máu mao mạch',
          alignment: ChartAlignment.center,
        ),
        // Enable legend
        legend: Legend(
          isVisible: true,
          // Border color and border width of legend
          offset: Offset(10, -100),
        ),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <LineSeries<MedicalCheckGlucose, String>>[
          LineSeries<MedicalCheckGlucose, String>(
              dataSource: medicalCheckGlucoses,
              name: 'Gluco(mol/kg)',
              xValueMapper: (MedicalCheckGlucose sales, _) =>
                  NiceDateTime.hourMinuteDayMonth(sales.time),
              yValueMapper: (MedicalCheckGlucose sales, _) => sales.glucoseUI,
              // Enable data label
              dataLabelSettings: DataLabelSettings(isVisible: true),
              animationDelay: 250)
        ]);
  }
}
