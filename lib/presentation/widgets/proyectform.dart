import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';
import 'package:pulse_task/presentation/widgets/custom_datepicker.dart';

class Proyectform extends StatelessWidget {
  final Proyecto? proyectoExistente;
  final bool isEditing;

  const Proyectform({
    super.key,
    this.proyectoExistente,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF222121),
      appBar: AppBar(
        backgroundColor: const Color(0xFF222121),
        centerTitle: true,
        title: Text('Crear proyecto', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
  bool _isLoading = false; // Añade esta variable
  String _proyect = '';
  String _description = '';
  String _selectedCategory = 'Personal';
  String _selectedrelevancia = '1'; // Cambiar a la clave como string
  DateTime _fechaInicio = DateTime.now();
  DateTime? _fechaFin;

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

  final Map<int, String> _relevancia = {1: 'baja', 2: 'Media', 3: 'Alta'};

  void _onDateSelected(DateTime startDate, DateTime? endDate) {
    setState(() {
      _fechaInicio = startDate;
      _fechaFin = endDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final proyectoProvider = Provider.of<Projectprovider>(
      context,
      listen: false,
    );

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nombre',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              initialValue: _proyect,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Objetivo especifico del proyecto',
                hintStyle: TextStyle(color: Colors.white54),
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

            Text(
              'Detalles',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              initialValue: _description,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Por que es importante este objetivo?',
                hintStyle: TextStyle(color: Colors.white54),
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

            CustomDatepicker(
              onDateSelected: _onDateSelected,
              initialStartDate: DateTime.now(),
            ),

            Text(
              'Categoria',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 8),

            DropdownButtonFormField<String>(
              borderRadius: BorderRadius.circular(19),
              value: _selectedCategory,
              dropdownColor: const Color(0xFF222121),
              style: TextStyle(color: Colors.white),
              items:
                  _categories.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: TextStyle(color: Colors.white)),
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

            Text(
              'Relevancia',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: _selectedrelevancia,
              dropdownColor: const Color(0xFF222121),
              style: TextStyle(color: Colors.white),
              items:
                  _relevancia.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key.toString(), // "1", "2", "3"
                      child: Text(
                        entry.value,
                        style: TextStyle(color: Colors.white),
                      ), // "baja", "Media", "Alta"
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedrelevancia = newValue!;
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
                onPressed:
                    _isLoading
                        ? null
                        : () async {
                          // Deshabilita el botón durante carga
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);

                            final nuevoProyecto = Proyecto(
                              nombre: _proyect,
                              descripcion: _description,
                              categoria: _selectedCategory,
                              fechaInicio: _fechaInicio,
                              fechaFin: _fechaFin,
                            );

                            try {
                              await proyectoProvider.addProyecto(nuevoProyecto);

                              if (!mounted) return;

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '✅ Proyecto creado exitosamente',
                                  ),
                                ),
                              );

                              // Espera un momento para que el usuario vea el mensaje
                              await Future.delayed(Duration(milliseconds: 500));

                              if (mounted) context.goNamed('home');
                            } catch (e) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('❌ Error: ${e.toString()}'),
                                ),
                              );
                            } finally {
                              if (mounted) setState(() => _isLoading = false);
                            }
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
      ),
    );
  }
}
