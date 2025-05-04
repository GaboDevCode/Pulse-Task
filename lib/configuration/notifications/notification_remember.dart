import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class NotificationRemember {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    try {
      // Inicialización de timezone
      tz_data.initializeTimeZones();

      // Configuración para Android
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('alarmaicon');

      // Inicialización de notificaciones
      await notificationsPlugin.initialize(
        const InitializationSettings(android: androidSettings),
      );

      // Crear canales de notificación
      await _createNotificationChannels();
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
    }
  }

  static Future<void> _createNotificationChannels() async {
    // Crear canal para Android
    const AndroidNotificationChannel androidChannel =
        AndroidNotificationChannel(
          'weekly_channel_id',
          'Recordatorios semanales',
          description: 'Notificaciones programadas',
          importance: Importance.max,
        );

    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(androidChannel);
  }

  static Future<void> sendNow(String title, String message) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'instant_channel',
            'Notificaciones inmediatas',
            importance: Importance.high,
            priority: Priority.high,
          );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      await notificationsPlugin.show(
        0,
        title,
        message,
        const NotificationDetails(android: androidDetails, iOS: iosDetails),
      );
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
    }
  }

  static Future<void> scheduleWeeklyNotifications({
    required int idBase,
    required String title,
    required String body,
    required List<int> weekdays,
    required TimeOfDay time,
  }) async {
    try {
      assert(
        weekdays.every((day) => day >= 1 && day <= 7),
        'Días inválidos. Usa valores del 1 al 7',
      );

      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'weekly_channel_id',
            'Recordatorios semanales',
            importance: Importance.max,
            priority: Priority.high,
          );

      for (final weekday in weekdays) {
        final id = idBase * 10 + weekday;
        final scheduledDate = _nextInstanceOfWeekday(weekday, time);

        await notificationsPlugin.zonedSchedule(
          id,
          title,
          body,
          scheduledDate,
          const NotificationDetails(android: androidDetails),
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        );
      }
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
    }
  }

  static Future<void> cancelScheduledNotification(int id) async {
    await notificationsPlugin.cancel(id);
  }

  // Helpers
  static tz.TZDateTime _nextInstanceOfWeekday(int weekday, TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    while (scheduledDate.weekday != weekday) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }
}
