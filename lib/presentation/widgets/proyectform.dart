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
        title: Text(
          isEditing ? 'Editar proyecto' : 'Crear proyecto',
          style: const TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: AddProyect(
        proyectoExistente: proyectoExistente,
        isEditing: isEditing,
      ),
    );
  }
}

class AddProyect extends StatefulWidget {
  final Proyecto? proyectoExistente;
  final bool isEditing;

  const AddProyect({super.key, this.proyectoExistente, this.isEditing = false});

  @override
  State<AddProyect> createState() => _AddProyectState();
}

class _AddProyectState extends State<AddProyect> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late String _proyect;
  late String _description;
  late String _selectedCategory;
  late String _selectedrelevancia;
  late DateTime _fechaInicio;
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

  final Map<int, String> _relevancia = {1: 'Baja', 2: 'Media', 3: 'Alta'};

  @override
  void initState() {
    super.initState();
    // Inicializar con datos del proyecto existente o valores por defecto
    _proyect = widget.proyectoExistente?.nombre ?? '';
    _description = widget.proyectoExistente?.descripcion ?? '';
    _selectedCategory = widget.proyectoExistente?.categoria ?? 'Personal';
    _selectedrelevancia =
        widget.proyectoExistente?.relevancia.toString() ?? '1';
    _fechaInicio = widget.proyectoExistente?.fechaInicio ?? DateTime.now();
    _fechaFin = widget.proyectoExistente?.fechaFin;
  }

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo: Nombre del proyecto
            const Text(
              'Nombre',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _proyect,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Objetivo específico del proyecto',
                hintStyle: const TextStyle(color: Colors.white54),
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
              onChanged: (value) => _proyect = value,
            ),
            const SizedBox(height: 16),

            // Campo: Descripción
            const Text(
              'Detalles',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              initialValue: _description,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: '¿Por qué es importante este objetivo?',
                hintStyle: const TextStyle(color: Colors.white54),
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
              onChanged: (value) => _description = value,
            ),
            const SizedBox(height: 16),

            // Selector de fechas
            CustomDatepicker(
              onDateSelected: _onDateSelected,
              initialStartDate: _fechaInicio,
              initialEndDate: _fechaFin,
            ),
            const SizedBox(height: 16),

            // Campo: Categoría
            const Text(
              'Categoría',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              dropdownColor: const Color(0xFF222121),
              style: const TextStyle(color: Colors.white),
              items:
                  _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
              onChanged: (value) => setState(() => _selectedCategory = value!),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Campo: Relevancia
            const Text(
              'Relevancia',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedrelevancia,
              dropdownColor: const Color(0xFF222121),
              style: const TextStyle(color: Colors.white),
              items:
                  _relevancia.entries.map((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.key.toString(),
                      child: Text(entry.value),
                    );
                  }).toList(),
              onChanged:
                  (value) => setState(() => _selectedrelevancia = value!),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(19),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Botón de guardar
            Center(
              child: ElevatedButton(
                onPressed:
                    _isLoading
                        ? null
                        : () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);

                            final proyecto = Proyecto(
                              id: widget.proyectoExistente?.id,
                              nombre: _proyect,
                              descripcion: _description,
                              categoria: _selectedCategory,
                              fechaInicio: _fechaInicio,
                              fechaFin: _fechaFin,
                              relevancia: int.parse(_selectedrelevancia),
                            );

                            try {
                              if (widget.isEditing) {
                                await proyectoProvider.updateProyecto(proyecto);
                              } else {
                                await proyectoProvider.addProyecto(proyecto);
                              }

                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    widget.isEditing
                                        ? '✅ Proyecto actualizado'
                                        : '✅ Proyecto creado',
                                  ),
                                ),
                              );

                              await Future.delayed(
                                const Duration(milliseconds: 500),
                              );
                              if (mounted) context.goNamed('home');
                            } catch (e) {
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: Text(
                  widget.isEditing ? 'Guardar cambios' : 'Crear nuevo proyecto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
