import 'package:flutter/material.dart';
import 'package:mb_control/app_colors.dart';
import 'package:mb_control/models/operation.dart';
import 'package:mb_control/tools/color_utils.dart';
import 'package:mb_control/views/base/base.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mb_control/views/operation/link_operation_chart.dart';

class OperationChart extends StatelessWidget {
  const OperationChart({
    Key? key,
    required this.operation,
  }) : super(key: key);

  final Operation operation;

  @override
  Widget build(BuildContext context) {
    return Base(
        title: 'Charts',
        showBackBtn: true,
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                    height: 360, child: PieChartWidget(operation: operation)),
              ),
              const SizedBox(
                height: 50,
              ),
              BarChartSample3(
                operation: operation,
              ),
            ],
          ),
        ));
  }
}

class PieChartWidget extends StatefulWidget {
  const PieChartWidget({
    super.key,
    required this.operation,
  });

  final Operation operation;

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  int touchedIndex = -1;

  final List<Color> colors = [Colors.green, Colors.yellow, Colors.purple];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          // const SizedBox(
          //   height: 18,
          // ),
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
          // const SizedBox(
          //   height: 48,
          // ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Indicator(
                  color: Colors.blue,
                  text:
                      'Retorno: ${widget.operation.retornoTotalCliente!.toStringAsFixed(2)}\$',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.yellow,
                  text:
                      'Excedente: ${widget.operation.excedente!.toStringAsFixed(2)}\$',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.purple,
                  text:
                      'C. Promotor: ${widget.operation.comisionPromoter!.toStringAsFixed(2)}\$',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.deepOrange,
                  text:
                      'Costo P/I: ${widget.operation.costoProviderIncome!.toStringAsFixed(2)}\$',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.cyan,
                  text:
                      'Costo P/O: ${widget.operation.costoProviderOutcome!.toStringAsFixed(2)}\$',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 4,
                ),
                Indicator(
                  color: Colors.green,
                  text:
                      'Comision Market: ${widget.operation.costoProviderOutcome!.toStringAsFixed(2)}\$',
                  isSquare: true,
                ),
                const SizedBox(
                  height: 18,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(6, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: widget.operation.retornoTotalCliente! *
                100 /
                widget.operation.totalOperacion!,
            title:
                '${(widget.operation.retornoTotalCliente! * 100 / widget.operation.totalOperacion!).toStringAsFixed(1)} %',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.yellow,
            value: widget.operation.excedente! *
                100 /
                widget.operation.totalOperacion!,
            title:
                '${(widget.operation.excedente! * 100 / widget.operation.totalOperacion!).toStringAsFixed(1)} %',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
            value: widget.operation.comisionPromoter! *
                100 /
                widget.operation.totalOperacion!,
            title:
                '${(widget.operation.comisionPromoter! * 100 / widget.operation.totalOperacion!).toStringAsFixed(1)} %',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.deepOrange,
            value: widget.operation.costoProviderIncome! *
                100 /
                widget.operation.totalOperacion!,
            title:
                '${(widget.operation.costoProviderIncome! * 100 / widget.operation.totalOperacion!).toStringAsFixed(1)} %',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: Colors.cyan,
            value: widget.operation.costoProviderOutcome! *
                100 /
                widget.operation.totalOperacion!,
            title:
                '${(widget.operation.costoProviderOutcome! * 100 / widget.operation.totalOperacion!).toStringAsFixed(1)} %',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        case 5:
          return PieChartSectionData(
            color: Colors.green,
            value: widget.operation.comisionUtilidadMB! *
                100 /
                widget.operation.totalOperacion!,
            title:
                '${(widget.operation.comisionUtilidadMB! * 100 / widget.operation.totalOperacion!).toStringAsFixed(1)} %',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}

class _BarChart extends StatelessWidget {
  const _BarChart(this.operation);
  final Operation operation;
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: FlGridData(show: true),
        alignment: BarChartAlignment.spaceAround,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: AppColors.contentColorCyan,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: AppColors.contentColorBlue.darken(20),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Com/Promot';
        break;
      case 1:
        text = 'Costo/P/E';
        break;
      case 2:
        text = 'Costo/P/I';
        break;
      case 3:
        text = 'Utilidad';
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          AppColors.contentColorBlue.darken(20),
          AppColors.contentColorCyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: operation.comisionPromoter!,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: operation.costoProviderOutcome!,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: operation.costoProviderIncome!,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: operation.comisionUtilidadMB!,
              gradient: _barsGradient,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartSample3 extends StatefulWidget {
  const BarChartSample3({
    super.key,
    required this.operation,
  });

  final Operation operation;
  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.6,
      child: _BarChart(widget.operation),
    );
  }
}
