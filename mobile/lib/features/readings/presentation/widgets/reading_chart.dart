import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../domain/entities/reading_entity.dart';

class ReadingPieChart extends StatelessWidget {
  final ReadingEntity reading;

  const ReadingPieChart({super.key, required this.reading});

  @override
  Widget build(BuildContext context) {
    final temp = reading.temperature;
    final humidity = reading.humidity;

    final total = temp + humidity;

    if (total == 0) {
      return  SizedBox(
        height: 220.h,
        child: const Center(child: Text("No data")),
      );
    }

    return Container(
      height: 320.h,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Current Distribution",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
           SizedBox(height: 20.h),

          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 2,
                centerSpaceRadius: 40,

                sections: [
                  PieChartSectionData(
                    value: temp,
                    title:
                        "${((temp / total) * 100).toStringAsFixed(1)}%",
                    color: Colors.redAccent,
                    radius: 60,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  PieChartSectionData(
                    value: humidity,
                    title:
                        "${((humidity / total) * 100).toStringAsFixed(1)}%",
                    color: Colors.blueAccent,
                    radius: 60,
                    titleStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              swapAnimationDuration:
                  const Duration(milliseconds: 400),
              swapAnimationCurve: Curves.easeInOut,
            ),
          ),

          const SizedBox(height: 10),

          /// Legend
      const    Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _Legend(color: Colors.redAccent, text: "Temperature"),
              SizedBox(width: 20),
              _Legend(color: Colors.blueAccent, text: "Humidity"),
            ],
          ),
        ],
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;

  const _Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 6),
        Text(text),
      ],
    );
  }
}