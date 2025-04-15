import 'dart:convert';
import 'package:flutter/services.dart';

class SolarTerm {
  final String name;
  final DateTime datetime;

  SolarTerm({required this.name, required this.datetime});
}

class SolarTermService {
  final Map<int, List<SolarTerm>> _cache = {};

  Future<List<SolarTerm>> getTerms(int year) async {
    if (_cache.containsKey(year)) return _cache[year]!;

    final jsonStr = await rootBundle.loadString(
      'assets/solar_terms_2020_2025.json',
    );
    final jsonData = json.decode(jsonStr) as List;
    final yearData = jsonData.firstWhere(
      (e) => e['year'] == year,
      orElse: () => null,
    );

    if (yearData == null) return [];

    final List<SolarTerm> terms =
        (yearData['jieqi'] as List).map((item) {
          return SolarTerm(
            name: item['name'],
            datetime: DateTime.parse(item['datetime']),
          );
        }).toList();

    _cache[year] = terms;
    return terms;
  }

  /// 获取指定时间前的最近节气
  Future<SolarTerm?> getLastSolarTermBefore(DateTime time) async {
    final terms = await getTerms(time.year);
    final previous = terms.where((t) => t.datetime.isBefore(time)).toList();
    return previous.isNotEmpty ? previous.last : null;
  }

  /// 是否在立春之前（用于年柱换年）
  Future<bool> isBeforeLiChun(DateTime time) async {
    final terms = await getTerms(time.year);
    final lichun = terms.firstWhere(
      (t) => t.name == '立春',
      orElse: () => SolarTerm(name: '', datetime: DateTime(2000)),
    );
    return time.isBefore(lichun.datetime);
  }

  /// 获取当前节气名（可用于调试）
  Future<String?> getCurrentSolarTerm(DateTime time) async {
    final terms = await getTerms(time.year);
    for (var i = 0; i < terms.length - 1; i++) {
      if (time.isAfter(terms[i].datetime) &&
          time.isBefore(terms[i + 1].datetime)) {
        return terms[i].name;
      }
    }
    return null;
  }
}
