import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({
    super.key,
    required this.data,
    required this.total,
  });

  final Map<String, dynamic> data;

  final double total;
  @override
  State<PieChartSample2> createState() => _PieChartSample2tate();
}

class _PieChartSample2tate extends State<PieChartSample2> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Indicator(
                color: Colors.blue,
                text: 'First',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.yellow,
                text: 'Second',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.purple,
                text: 'Third',
                isSquare: true,
              ),
              SizedBox(
                height: 4,
              ),
              Indicator(
                color: Colors.green,
                text: 'Fourth',
                isSquare: true,
              ),
              SizedBox(
                height: 18,
              ),
            ],
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    return widget.data.keys
        .map((e) => PieChartSectionData(
              color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                  .withOpacity(1.0),
              value: widget.data[e],
              title: (widget.data[e] * 100 / widget.total).toStringAsFixed(1),
              radius: 50,
              titleStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: shadows,
              ),
            ))
        .toList();

    // return List.generate(4, (i) {
    //   final isTouched = i == touchedIndex;
    //   final fontSize = isTouched ? 25.0 : 16.0;
    //   final radius = isTouched ? 60.0 : 50.0;
    //   const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    //   switch (i) {
    //     case 0:
    //       return PieChartSectionData(
    //         color: Colors.blue,
    //         value: 40,
    //         title: '40%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 1:
    //       return PieChartSectionData(
    //         color: Colors.yellow,
    //         value: 30,
    //         title: '30%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 2:
    //       return PieChartSectionData(
    //         color: Colors.purple,
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     case 3:
    //       return PieChartSectionData(
    //         color: Colors.purple,
    //         value: 15,
    //         title: '15%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white,
    //           shadows: shadows,
    //         ),
    //       );
    //     default:
    //       throw Error();
    //   }
    // });
  }
}
