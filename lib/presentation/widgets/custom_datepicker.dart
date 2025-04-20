import 'package:flutter/material.dart';

class CustomDatepicker extends StatefulWidget {
  final Function(DateTime startDate, DateTime? endDate) onDateSelected;

  const CustomDatepicker({super.key, required this.onDateSelected});

  @override
  State<CustomDatepicker> createState() => _CustomDatepickerState();
}

class _CustomDatepickerState extends State<CustomDatepicker> {
  DateTime _startDate = DateTime.now();
  DateTime? _endDate;

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate ?? _startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
      widget.onDateSelected(_startDate, _endDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Fecha de inicio', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ListTile(
          title: Text(
            '${_startDate.day}/${_startDate.month}/${_startDate.year}',
          ),
          trailing: Icon(Icons.calendar_today),
          onTap: () => _selectDate(context, true),
        ),
        SizedBox(height: 16),
        Text(
          'Fecha de fin (opcional)',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ListTile(
          title: Text(
            _endDate == null
                ? 'No seleccionada'
                : '${_endDate!.day}/${_endDate!.month}/${_endDate!.year}',
          ),
          trailing: Icon(Icons.calendar_today),
          onTap: () => _selectDate(context, false),
        ),
      ],
    );
  }
}
