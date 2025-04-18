import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulse_task/presentation/widgets/custom_datepicker.dart';

class CreateproyectView extends StatelessWidget {
  const CreateproyectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Crear proyecto')),
      body: AddProyect(),
    );
  }
}

class AddProyect extends StatefulWidget {
  const AddProyect({super.key});

  @override
  State<AddProyect> createState() => _AddProyectState();
}

class _AddProyectState extends State<AddProyect> {
  final _formKey = GlobalKey<FormState>();
  String _proyect = '';
  String _description = '';
  String _selectedCategory = 'Personal';

  final List<String> _categories = [
    'Personal',
    'Trabajo',
    'Deporte',
    'Familia',
    'Hogar',
    'Salud',
    'Dinero',
    'Vario',
  ];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nombre', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          TextFormField(
            initialValue: _proyect,
            decoration: InputDecoration(
              hintText: 'Objetivo especifico del proyecto',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa un objetivo';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _proyect = value;
              });
            },
          ),

          SizedBox(height: 16),

          Text('Detalles', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          TextFormField(
            initialValue: _description,
            decoration: InputDecoration(
              hintText: 'Por que es importante este objetivo?',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa los detalles';
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _description = value;
              });
            },
          ),
          SizedBox(height: 16),

          CustomDatepicker(),

          Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),

          DropdownButtonFormField<String>(
            borderRadius: BorderRadius.circular(19),
            value: _selectedCategory,
            items:
                _categories.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa al menos una categoria';
              }
              return null;
            },
            onChanged: (newValue) {
              setState(() {
                _selectedCategory = newValue!;
              });
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(19),
              ),
            ),
          ),
          SizedBox(height: 46),

          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Guardar el proyecto
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Proyecto Creado')));
                  context.goNamed('home');
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: Text('Crear nuevo proyecto'),
            ),
          ),
        ],
      ),
    );
  }
}
