// Modelo de Proyecto
class Proyecto {
  int? id;
  final String nombre;
  final String descripcion;
  final String categoria;
  final int? relevancia;
  String estado;
  final DateTime fechaInicio;
  final DateTime? fechaFin;

  //Constructor
  Proyecto({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.categoria,
    this.relevancia,
    required this.estado,
    required this.fechaInicio,
    this.fechaFin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'categoria': categoria,
      'relevancia': relevancia,
      'estado': estado,
      'fechaInicio': fechaInicio.toIso8601String(),
      'fechaFin': fechaFin?.toIso8601String(),
    };
  }

  factory Proyecto.fromMap(Map<String, dynamic> map) {
    return Proyecto(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      categoria: map['categoria'],
      relevancia: map['relevancia'],
      estado: map['estado'] as String,
      fechaInicio: DateTime.parse(map['fechaInicio']),
      fechaFin:
          map['fechaFin'] != null ? DateTime.parse(map['fechaFin']) : null,
    );
  }
}
