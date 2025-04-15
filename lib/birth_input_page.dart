import 'package:flutter/material.dart';
import 'package:flutter_prac/models/birth_data.dart';
import 'package:flutter_prac/services/bazi_calculator.dart';
import 'package:flutter_prac/pages/result_page.dart';

class BirthInputPage extends StatefulWidget {
  const BirthInputPage({super.key});

  @override
  State<BirthInputPage> createState() => _BirthInputPageState();
}

class _BirthInputPageState extends State<BirthInputPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String _selectedGender = '男';

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 12, minute: 0),
    );
    if (picked != null) {
      setState(() => _selectedTime = picked);
    }
  }

  void _submit() async {
    if (_formKey.currentState?.validate() == true && _selectedDate != null) {
      final birthData = BirthData(
        name: _nameController.text.isEmpty ? null : _nameController.text,
        gender: _selectedGender,
        date: _selectedDate!,
        hour: _selectedTime?.hour,
        minute: _selectedTime?.minute,
      );

      final chart = await calculateBaZi(birthData);

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ResultPage(chart: chart, data: birthData),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('出生信息输入')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: '姓名（可选）'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _selectedGender,
                items: ['男', '女', '其他'].map((gender) {
                  return DropdownMenuItem(
                    value: gender,
                    child: Text(gender),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) setState(() => _selectedGender = value);
                },
                decoration: const InputDecoration(labelText: '性别'),
              ),
              const SizedBox(height: 12),
              ListTile(
                title: Text(
                  _selectedDate == null
                      ? '请选择出生日期'
                      : '出生日期：${_selectedDate!.toLocal()}'.split(' ')[0],
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _pickDate(context),
              ),
              ListTile(
                title: Text(
                  _selectedTime == null
                      ? '请选择出生时间'
                      : '出生时间：${_selectedTime!.format(context)}',
                ),
                trailing: const Icon(Icons.access_time),
                onTap: () => _pickTime(context),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _submit, child: const Text('生成排盘')),
            ],
          ),
        ),
      ),
    );
  }
}
