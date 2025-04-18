import 'package:flutter/material.dart';

class CustomDatepicker extends StatefulWidget {
  const CustomDatepicker({super.key});

  @override
  State<CustomDatepicker> createState() => _CustomDatepickerState();
}

class _CustomDatepickerState extends State<CustomDatepicker> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Plazo', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextFormField(
          controller: _dateController,
          readOnly: true, // Evita que el usuario escriba manualmente
          decoration: InputDecoration(
            hintText: 'Seleccione una fecha',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(19)),
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today, color: Colors.grey),
              onPressed: _selectDate,
            ),
          ),
          onTap: _selectDate, // Abre el date picker al tocar el campo
        ),
      ],
    );
  }
}
