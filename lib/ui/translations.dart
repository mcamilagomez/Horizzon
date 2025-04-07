import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'es_ES': {
          'settings': 'Ajustes',
          'change_language': 'Cambiar idioma',
          'theme': 'Tema',
          'dark_mode': 'Modo oscuro',
          'light_mode': 'Modo claro',
          'select_language': 'Selecciona un idioma',
          'notifications': 'Notificaciones',
          'privacy': 'Privacidad',
          'logout': 'Cerrar sesión',
          'logout_confirm': '¿Estás seguro de que quieres salir?',
          'yes': 'Sí',
          'cancel': 'Cancelar',
        },
        'en_US': {
          'settings': 'Settings',
          'change_language': 'Change Language',
          'theme': 'Theme',
          'dark_mode': 'Dark Mode',
          'light_mode': 'Light Mode',
          'select_language': 'Select a language',
          'notifications': 'Notifications',
          'privacy': 'Privacy',
          'logout': 'Log Out',
          'logout_confirm': 'Are you sure you want to log out?',
          'yes': 'Yes',
          'cancel': 'Cancel',
        },
      };
}