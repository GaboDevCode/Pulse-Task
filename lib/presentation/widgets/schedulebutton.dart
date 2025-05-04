import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pulse_task/configuration/notifications/notification_remember.dart';

class ScheduleButton extends StatefulWidget {
  const ScheduleButton({super.key});

  @override
  State<ScheduleButton> createState() => _ScheduleButtonState();
}

class _ScheduleButtonState extends State<ScheduleButton> {
  bool _isScheduled = false;

  Future<void> _scheduleNotifications() async {
    try {
      // 1. Solicitar permisos (solo en Android 13+)
      final bool? permissionGranted = await _checkPermissions();

      if (permissionGranted ?? false) {
        // 2. Programar notificaciones
        await NotificationRemember.scheduleWeeklyNotifications(
          idBase: 100,
          title: "¡Hora de PulseTask!",
          body: "Revisa tus proyectos y tareas pendientes",
          weekdays: [
            DateTime.monday,
            DateTime.wednesday,
            DateTime.friday,
            DateTime.sunday,
          ],
          time: const TimeOfDay(hour: 9, minute: 30),
        );

        setState(() => _isScheduled = true);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notificaciones programadas correctamente'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
    }
  }

  Future<bool?> _checkPermissions() async {
    // Accede al plugin a través de NotificationRemember
    if (await Permission.notification.isGranted) {
      return true;
    } else {
      final status = await Permission.notification.request();
      return status.isGranted || status.isDenied;
    }
    // return await NotificationRemember.notificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //       AndroidFlutterLocalNotificationsPlugin
    //     >()
    //     ?.requestNotificationsPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => _scheduleNotifications(),
            backgroundColor: Colors.blue,
            icon: Icons.notifications_active,
            label: 'Programar',
          ),
        ],
      ),
      child: Card(
        color: Colors.blueGrey.shade800, // Fondo oscuro para contraste
        child: ListTile(
          leading: Icon(
            _isScheduled ? Icons.notifications : Icons.notifications_off,
            color: Colors.white,
          ),
          title: Text(
            _isScheduled ? 'Recordatorios activados' : 'Activar recordatorios',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
