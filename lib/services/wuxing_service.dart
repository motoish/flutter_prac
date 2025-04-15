import 'package:flutter/material.dart';

enum WuXing { mu, huo, tu, jin, shui }

String getWuXingName(WuXing x) {
  switch (x) {
    case WuXing.mu:
      return '木';
    case WuXing.huo:
      return '火';
    case WuXing.tu:
      return '土';
    case WuXing.jin:
      return '金';
    case WuXing.shui:
      return '水';
  }
}

const Map<String, WuXing> ganToWuXing = {
  '甲': WuXing.mu,
  '乙': WuXing.mu,
  '丙': WuXing.huo,
  '丁': WuXing.huo,
  '戊': WuXing.tu,
  '己': WuXing.tu,
  '庚': WuXing.jin,
  '辛': WuXing.jin,
  '壬': WuXing.shui,
  '癸': WuXing.shui,
};

const Map<String, WuXing> zhiToWuXing = {
  '寅': WuXing.mu,
  '卯': WuXing.mu,
  '巳': WuXing.huo,
  '午': WuXing.huo,
  '辰': WuXing.tu,
  '戌': WuXing.tu,
  '丑': WuXing.tu,
  '未': WuXing.tu,
  '申': WuXing.jin,
  '酉': WuXing.jin,
  '子': WuXing.shui,
  '亥': WuXing.shui,
};

Color colorForWuXing(WuXing xing) {
  switch (xing) {
    case WuXing.mu:
      return Colors.green;
    case WuXing.huo:
      return Colors.red;
    case WuXing.tu:
      return Colors.brown;
    case WuXing.jin:
      return Colors.grey;
    case WuXing.shui:
      return Colors.blue;
  }
}
