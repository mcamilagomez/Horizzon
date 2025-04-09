import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'settings': 'Settings',
          'change_language': 'Change Language',
          'select_language': 'Select a language',
          'notifications': 'Notifications',
          'notifications_msg': 'Notification settings will go here',
          'privacy': 'Privacy',
          'privacy_msg': 'Privacy settings will go here',
          'logout': 'Log Out',
          'logout_confirm': 'Are you sure you want to log out?',
          'yes': 'Yes',
          'cancel': 'Cancel',
          'primary_color': 'Primary Color',
          'dark_mode': 'Dark Mode',
          'light_mode': 'Light Mode',

          // Calendar / Agenda translations
          'calendar.title': 'Agenda',
          'calendar.subtitle': 'Check your upcoming events',
          'calendar.eventsFor': 'Events for :date',
          'calendar.noEvents': 'No events for this day.',
          'calendar.allEvents': 'All My Events',

          // Event Tracks / EventosPage
          'eventTracksTitle': 'Event Tracks',
          'allEvents': 'All Events',
          'subscribed': 'Subscribed',
          'subscribe': 'Subscribe',
          'showMore': 'Show More',
          'showLess': 'Show Less',
          'eventsLeft': 'more',

          // HomePage translations
          'app.title': 'Horizzon',
          'home.subtitle': "'A new event on the horizon'",
          'home.reminders': 'Reminders',
          'home.recommended': 'Recommended',
        },
        'es_ES': {
          'settings': 'Ajustes',
          'change_language': 'Cambiar Idioma',
          'select_language': 'Seleccionar Idioma',
          'notifications': 'Notificaciones',
          'notifications_msg': 'Configuración de notificaciones irá aquí',
          'privacy': 'Privacidad',
          'privacy_msg': 'Configuración de privacidad irá aquí',
          'logout': 'Cerrar Sesión',
          'logout_confirm': '¿Estás seguro de que quieres cerrar sesión?',
          'yes': 'Sí',
          'cancel': 'Cancelar',
          'primary_color': 'Color Primario',
          'dark_mode': 'Modo Oscuro',
          'light_mode': 'Modo Claro',

          // Calendario / Agenda
          'calendar.title': 'Agenda',
          'calendar.subtitle': 'Consulta tus eventos próximos',
          'calendar.eventsFor': 'Eventos para :date',
          'calendar.noEvents': 'No hay eventos para este día.',
          'calendar.allEvents': 'Todos Mis Eventos',

          // Event Tracks / EventosPage
          'eventTracksTitle': 'Líneas de Eventos',
          'allEvents': 'Todos los eventos',
          'subscribed': 'Suscrito',
          'subscribe': 'Suscribirse',
          'showMore': 'Mostrar más',
          'showLess': 'Mostrar menos',
          'eventsLeft': 'más',

          // HomePage traducciones
          'app.title': 'Horizzon',
          'home.subtitle': "'Un nuevo evento en el horizonte'",
          'home.reminders': 'Recordatorios',
          'home.recommended': 'Recomendados',
        },
      };
}
