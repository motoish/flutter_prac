// 十神计算规则表：日干 -> [相对干 => 十神]
const Map<String, Map<String, String>> shiShenTable = {
  '甲': {
    '甲': '比肩',
    '乙': '劫财',
    '丙': '食神',
    '丁': '伤官',
    '戊': '偏财',
    '己': '正财',
    '庚': '七杀',
    '辛': '正官',
    '壬': '偏印',
    '癸': '正印',
  },
  '乙': {
    '甲': '劫财',
    '乙': '比肩',
    '丙': '伤官',
    '丁': '食神',
    '戊': '正财',
    '己': '偏财',
    '庚': '正官',
    '辛': '七杀',
    '壬': '正印',
    '癸': '偏印',
  },
  '丙': {
    '丙': '比肩',
    '丁': '劫财',
    '戊': '食神',
    '己': '伤官',
    '庚': '偏财',
    '辛': '正财',
    '壬': '七杀',
    '癸': '正官',
    '甲': '偏印',
    '乙': '正印',
  },
  '丁': {
    '丙': '劫财',
    '丁': '比肩',
    '戊': '伤官',
    '己': '食神',
    '庚': '正财',
    '辛': '偏财',
    '壬': '正官',
    '癸': '七杀',
    '甲': '正印',
    '乙': '偏印',
  },
  '戊': {
    '甲': '偏印',
    '乙': '正印',
    '丙': '比肩',
    '丁': '劫财',
    '戊': '比肩',
    '己': '劫财',
    '庚': '食神',
    '辛': '伤官',
    '壬': '偏财',
    '癸': '正财',
  },
  '己': {
    '甲': '正印',
    '乙': '偏印',
    '丙': '劫财',
    '丁': '比肩',
    '戊': '劫财',
    '己': '比肩',
    '庚': '伤官',
    '辛': '食神',
    '壬': '正财',
    '癸': '偏财',
  },
  '庚': {
    '甲': '正财',
    '乙': '偏财',
    '丙': '偏印',
    '丁': '正印',
    '戊': '比肩',
    '己': '劫财',
    '庚': '比肩',
    '辛': '劫财',
    '壬': '食神',
    '癸': '伤官',
  },
  '辛': {
    '甲': '偏财',
    '乙': '正财',
    '丙': '正印',
    '丁': '偏印',
    '戊': '劫财',
    '己': '比肩',
    '庚': '劫财',
    '辛': '比肩',
    '壬': '伤官',
    '癸': '食神',
  },
  '壬': {
    '甲': '伤官',
    '乙': '食神',
    '丙': '正财',
    '丁': '偏财',
    '戊': '正印',
    '己': '偏印',
    '庚': '比肩',
    '辛': '劫财',
    '壬': '比肩',
    '癸': '劫财',
  },
  '癸': {
    '甲': '食神',
    '乙': '伤官',
    '丙': '偏财',
    '丁': '正财',
    '戊': '偏印',
    '己': '正印',
    '庚': '劫财',
    '辛': '比肩',
    '壬': '劫财',
    '癸': '比肩',
  },
};

String getShiShen(String riGan, String otherGan) {
  return shiShenTable[riGan]?[otherGan] ?? '未知';
}
