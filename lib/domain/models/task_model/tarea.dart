// Modelo de tarea

class Tarea {
  int? id;
  final String nombre;
  final String descripcion;
  final String estado;
  final DateTime fechaCreacion;
  final DateTime? fechaVencimiento;
  final int notificado; // 0 = no notificado, 1 = notificado
  final int proyectoId;

  Tarea({
    this.id,
    required this.nombre,
    required this.descripcion,
    required this.estado,
    required this.fechaCreacion,
    this.fechaVencimiento,
    this.notificado = 0,
    required this.proyectoId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'estado': estado,
      'fechaCreacion': fechaCreacion.toIso8601String(),
      'fechaVencimiento': fechaVencimiento?.toIso8601String(),
      'notificado': notificado,
      'proyectoId': proyectoId,
    };
  }

  factory Tarea.fromMap(Map<String, dynamic> map) {
    return Tarea(
      id: map['id'],
      nombre: map['nombre'],
      descripcion: map['descripcion'],
      estado: map['estado'],
      fechaCreacion: DateTime.parse(map['fechaCreacion']),
      fechaVencimiento:
          map['fechaVencimiento'] != null
              ? DateTime.parse(map['fechaVencimiento'])
              : null,
      notificado: map['notificado'] ?? 0,
      proyectoId: map['proyectoId'],
    );
  }
}
