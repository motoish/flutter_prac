import 'package:flutter/material.dart';
import 'package:flutter_prac/models/bazi_chart.dart';
import 'package:flutter_prac/models/birth_data.dart';
import 'package:flutter_prac/widgets/bazi_result_card.dart';

class ResultPage extends StatelessWidget {
  final BaZiChart chart;
  final BirthData data;

  const ResultPage({super.key, required this.chart, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('排盘结果')),
      body: Center(
        child: SingleChildScrollView(
          child: BaZiResultCard(
            chart: chart,
            birthDate: data.date,
            name: data.name,
            gender: data.gender,
          ),
        ),
      ),
    );
  }
}
