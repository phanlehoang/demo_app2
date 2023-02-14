import 'package:demo_app2/presentation/widgets/nice_widgets/1_nice_container.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../data/models/medical/2_medical_check_glucose.dart';
import 'dongs_chart.dart';
import 'nice_date_time.dart';

class GlucoseChartWidget extends StatelessWidget {
  final List<MedicalCheckGlucose> medicalCheckGlucoses;
  GlucoseChartWidget({required this.medicalCheckGlucoses});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        //đồ thị với syncfusion chart
        // DongChart(medicalCheckGlucoses: medicalCheckGlucoses),
        TrialChart(medicalCheckGlucoses: medicalCheckGlucoses)
      ],
    );
  }
}

class TrialChart extends StatelessWidget {
  TrialChart({
    super.key,
    required this.medicalCheckGlucoses,
  });

  final List<MedicalCheckGlucose> medicalCheckGlucoses;
  final zoomPanBehavior = ZoomPanBehavior(
    enablePanning: true,
    enablePinching: true,
    enableDoubleTapZooming: true,
    enableSelectionZooming: true,
    enableMouseWheelZooming: true,
    selectionRectBorderColor: Colors.red,
    selectionRectBorderWidth: 2,
    selectionRectColor: Colors.grey,
    zoomMode: ZoomMode.x,
  );
  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      // Initialize category axis
      primaryXAxis: CategoryAxis(),
      primaryYAxis: NumericAxis(
          minimum: 0,
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
                dashArray: <double>[10, 10]),
            PlotBand(
                isVisible: true,
                // provided the same y-value to start and end property in order to render the plotline for that y-value.
                start: 8.3,
                end: 11.1,
                borderWidth: 1,
                color: Color.fromARGB(255, 255, 255, 0),
                borderColor: Color.fromARGB(255, 255, 255, 0),
                // Label text for the reference plot line
                textStyle: TextStyle(color: Colors.green),
                // provided dash array to render the line in dashed format.
                dashArray: <double>[10, 10]),
          ],
          majorGridLines: MajorGridLines(
            width: 0,
          )),
      title: ChartTitle(
        text: 'Đường máu mao mạch',
        alignment: ChartAlignment.center,
      ), //fix Oy and flex Ox
      zoomPanBehavior: zoomPanBehavior,
      tooltipBehavior: TooltipBehavior(enable: true),
      //anotation

      series: <LineSeries<MedicalCheckGlucose, String>>[
        LineSeries<MedicalCheckGlucose, String>(
          // Bind data source
          dataSource: medicalCheckGlucoses,
          name: 'Glucose (UI)',
          //ko hiển thị điểm
          markerSettings: MarkerSettings(
              isVisible: true,
              shape: DataMarkerType.circle,
              borderWidth: 1,
              color: Colors.blueAccent),
          xValueMapper: (MedicalCheckGlucose medicalCheckGlucose, _) =>
              NiceDateTime.hourMinuteDayMonth(medicalCheckGlucose.time),
          yValueMapper: (MedicalCheckGlucose medicalCheckGlucose, _) =>
              medicalCheckGlucose.glucoseUI,
          // Enable data label
          dataLabelSettings: DataLabelSettings(
              margin: EdgeInsets.all(1),
              isVisible: true,
              alignment: ChartAlignment.center,
              labelAlignment: ChartDataLabelAlignment.top,
              borderRadius: 1,
              //khoảng cách label với điểm
              textStyle: TextStyle(fontSize: 10)),
        ),
        //làm sao để khoảng cách giữa label và node nhỏ lại
        //https://www.syncfusion.com/kb/12112/how-to-display-the-data-labels-in-the-chart-without-overlapping
        //legend
      ],
      legend: Legend(
        isVisible: true,
        // Border color and border width of legend
        borderColor: Colors.black,
        //chú thích nằm ở phải trên
        position: LegendPosition.top,
        //flow mode
        overflowMode: LegendItemOverflowMode.wrap,
      ),
    );
  }
}
