import 'package:auto_prognostic_app/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../controller/home_screen_controller.dart';
import 'components/home_screen_container.dart';
import 'prediction_screen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List imagePath = [
    "assets/images/enginee.png",
    "assets/images/oilPressure.png",
    "assets/images/fuelPressure.png",
    "assets/images/lubOil.png",
    "assets/images/coolant.png",
    "assets/images/fuelPressure.png",
  ];

  final List names = [
    "Engine RPM",
    "Lubricant Oil Pressure",
    "Coolant Pressure",
    "Lubricant Oil Tempature",
    "Coolant Tempature",
    "Fuel Pressure",
  ];

  final ObdController obdController = Get.put(ObdController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
          height: 100.h,
          width: 100.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 4.h),
                Image.asset(
                  "assets/images/engine.png",
                  height: 20.h,
                ),
                SizedBox(height: 4.h),
                Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: List.generate(
                    imagePath.length,
                    (index) => GestureDetector(
                        onTap: () {
                          switch (index) {
                            case 0:
                              Get.to(() => DetailsScreen(
                                  title: "Engine RPM",
                                  widget: Obx(
                                    () => SfRadialGauge(
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          minimum: 0,
                                          maximum:
                                              8000, // Typical range for RPM in many engines
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                                startValue: 0,
                                                endValue: 3000,
                                                color: Colors.green),
                                            GaugeRange(
                                                startValue: 3000,
                                                endValue: 6000,
                                                color: Colors.orange),
                                            GaugeRange(
                                                startValue: 6000,
                                                endValue: 8000,
                                                color: Colors.red)
                                          ],
                                          pointers: [
                                            NeedlePointer(
                                              value: obdController
                                                  .engineRpm.value
                                                  .toDouble(), // Set the current RPM value here
                                              enableAnimation: true,
                                            )
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              widget: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      '${obdController.engineRpm.value} RPM',
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              angle: 90,
                                              positionFactor: 0.75,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )));
                              break;
                            case 1:
                              Get.to(() => DetailsScreen(
                                  title: "Lubricant Oil Pressure",
                                  widget: Obx(() => SfRadialGauge(
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                            minimum: 0,
                                            maximum: 100,
                                            pointers: <GaugePointer>[
                                              RangePointer(
                                                enableAnimation: true,
                                                value: obdController
                                                    .lubOilPressure.value
                                                    .toPrecision(
                                                        2), // Set the current oil pressure value here
                                                color: Colors.blue,
                                              )
                                            ],
                                            annotations: <GaugeAnnotation>[
                                              GaugeAnnotation(
                                                widget: Container(
                                                  child: Text(
                                                      '${obdController.lubOilPressure.value.toPrecision(2)} Psi',
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                angle: 90,
                                                positionFactor: 0.5,
                                              )
                                            ],
                                          )
                                        ],
                                      ))));
                              break;
                            case 2:
                              Get.to(() => DetailsScreen(
                                  title: 'Coolant Pressure',
                                  widget: Obx(
                                    () => SfRadialGauge(
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          minimum: 0,
                                          maximum:
                                              30, // Typical range for coolant pressure
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                                startValue: 0,
                                                endValue: 10,
                                                color: Colors.green),
                                            GaugeRange(
                                                startValue: 10,
                                                endValue: 20,
                                                color: Colors.orange),
                                            GaugeRange(
                                                startValue: 20,
                                                endValue: 30,
                                                color: Colors.red)
                                          ],
                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                              value: obdController
                                                  .coolantPressure.value
                                                  .toPrecision(
                                                      2), // Set the current coolant pressure value here
                                              enableAnimation: true,
                                            )
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              widget: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      '${obdController.coolantPressure.value.toPrecision(2)} PSI', // Example pressure value with unit
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              angle: 90,
                                              positionFactor: 0.75,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )));
                              break;
                            case 3:
                              Get.to(() => DetailsScreen(
                                  title: "Lubricant Oil Tempature",
                                  widget: Obx(
                                    () => SfRadialGauge(
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          minimum: 0,
                                          maximum:
                                              300, // Typical range for lubrication oil temperature in Fahrenheit
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                                startValue: 0,
                                                endValue: 100,
                                                color: Colors.blue),
                                            GaugeRange(
                                                startValue: 100,
                                                endValue: 200,
                                                color: Colors.green),
                                            GaugeRange(
                                                startValue: 200,
                                                endValue: 300,
                                                color: Colors.red)
                                          ],
                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                              value: obdController
                                                  .lubOilTemp.value
                                                  .toPrecision(
                                                      2), // Set the current oil temperature value here
                                              enableAnimation: true,
                                            )
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              widget: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      '${obdController.lubOilTemp.value.toPrecision(2)}° C', // Example temperature value with unit
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              angle: 90,
                                              positionFactor: 0.75,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )));
                              break;
                            case 4:
                              Get.to(() => DetailsScreen(
                                  title: "Coolant Tempature",
                                  widget: Obx(
                                    () => SfRadialGauge(
                                      axes: <RadialAxis>[
                                        RadialAxis(
                                          minimum: 50,
                                          maximum:
                                              200, // Typical range for coolant temperature in Celsius
                                          ranges: <GaugeRange>[
                                            GaugeRange(
                                                startValue: 50,
                                                endValue: 85,
                                                color: Colors.blue),
                                            GaugeRange(
                                                startValue: 85,
                                                endValue: 130,
                                                color: Colors.green),
                                            GaugeRange(
                                                startValue: 130,
                                                endValue: 200,
                                                color: Colors.red)
                                          ],
                                          pointers: <GaugePointer>[
                                            NeedlePointer(
                                              value: obdController
                                                  .coolantTemp.value
                                                  .toPrecision(
                                                      2), // Set the current coolant temperature value here
                                              enableAnimation: true,
                                            )
                                          ],
                                          annotations: <GaugeAnnotation>[
                                            GaugeAnnotation(
                                              widget: Container(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      '${obdController.coolantTemp.value.toPrecision(2)}°C', // Example temperature value with unit
                                                      style: const TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              angle: 90,
                                              positionFactor: 0.75,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )));
                            case 5:
                              Get.to(() => DetailsScreen(
                                  title: "Fuel Pressure",
                                  widget: Obx(() => SfRadialGauge(
                                        axes: <RadialAxis>[
                                          RadialAxis(
                                            minimum: 0,
                                            maximum: 100,
                                            ranges: <GaugeRange>[
                                              GaugeRange(
                                                  startValue: 0,
                                                  endValue: 30,
                                                  color: Colors.green),
                                              GaugeRange(
                                                  startValue: 30,
                                                  endValue: 60,
                                                  color: Colors.orange),
                                              GaugeRange(
                                                  startValue: 60,
                                                  endValue: 100,
                                                  color: Colors.red),
                                            ],
                                            pointers: <GaugePointer>[
                                              NeedlePointer(
                                                value: obdController
                                                    .fuelPressure.value
                                                    .toDouble()
                                                    .toPrecision(2),
                                                enableAnimation: true,
                                              )
                                            ],
                                            annotations: <GaugeAnnotation>[
                                              GaugeAnnotation(
                                                widget: Container(
                                                  child: Obx(() => Text(
                                                        '${obdController.fuelPressure.value.toPrecision(2)} PSI',
                                                        style: const TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )),
                                                ),
                                                angle: 90,
                                                positionFactor: 0.75,
                                              )
                                            ],
                                          ),
                                        ],
                                      ))));
                          }
                        },
                        child: HomeScreenContainer(
                            imagePath[index], names[index])),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: Center(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () async {
                showLoadingDialog();
                await obdController.getPrediction();
                hideLoadingDialog();
                Get.to(() => PredictionScreen());
              },
              child: Container(
                  alignment: Alignment.center,
                  height: 7.h,
                  width: 85.w,
                  margin: EdgeInsets.only(left: 8.w),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 84, 93, 54),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Text("Prognostic",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white))),
            ),
          ),
        ));
  }

  void showLoadingDialog() {
    Get.defaultDialog(
      title: "Predicting...",
      content: Center(
        child: Container(
          height: 15.h,
          width: 90.w,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 10.h,
                  child: Lottie.asset(
                      'assets/images/lottie.json')), // Ensure you have a loading.json file in your assets
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoadingDialog() {
    if (Get.isDialogOpen != null && Get.isDialogOpen!) {
      Get.back();
    }
  }
}
