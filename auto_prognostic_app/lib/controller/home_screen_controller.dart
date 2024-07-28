import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ObdController extends GetxController {
  // Observable variables for OBD data
  var coolantPressure = 0.0.obs;
  var coolantTemp = 0.0.obs;
  var engineRpm = 0.0.obs;
  var fuelPressure = 0.0.obs;
  var lubOilPressure = 0.0.obs;
  var lubOilTemp = 0.0.obs;

  var prediction = 0.obs;
  var explanation = RxList<double>();
  var isLoading = false.obs;
  var data = {};
  @override
  void onInit() {
    super.onInit();
    getObdData();
    Timer.periodic(const Duration(seconds: 1), (_) => getObdData());
  }

  void getObdData() async {
    print("inside the Get Data method");
    try {
      print("inside try block");
      final response =
          await http.get(Uri.parse('http://192.168.4.210:5000/api/obd/data'));
      if (response.statusCode == 200) {
        print(response.statusCode);
        final jsonData = jsonDecode(response.body)['data'];
        print("data is $jsonData");
        coolantPressure.value = jsonData['Coolant Pressure'];
        coolantTemp.value = jsonData['Coolant Temp'];
        engineRpm.value = jsonData['Engine RPM'];
        fuelPressure.value = jsonData['Fuel Pressure'];
        lubOilPressure.value = jsonData['Lub Oil Pressure'];
        lubOilTemp.value = jsonData['Lub Oil Temp'];
      } else {
        print('Error fetching OBD data: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while fetching OBD data: $e');
    }
  }

  getPrediction() async {
    try {
      isLoading.value = true;
      final predictionResponse =
          await http.get(Uri.parse('http://192.168.4.210:5000/api/data'));
      if (predictionResponse.statusCode == 200) {
        final jsonData = jsonDecode(predictionResponse.body);
        prediction.value = jsonData['prediction'];
        explanation.assignAll(
            convertSmallValuesToZero(jsonData['explanation'].cast<double>()));

        data.addAll(jsonData['data']);
      } else {
        print(
            'Error fetching prediction/explanation data: ${predictionResponse.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while fetching data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  List<double> convertSmallValuesToZero(List<double> values,
      {double threshold = 1e-4}) {
    return values
        .map((value) => (value.abs() < threshold) ? 0.0 : value)
        .toList();
  }
}
