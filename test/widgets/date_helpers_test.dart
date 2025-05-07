// test/helpers/date_helpers_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:horizzon/domain/entities/event.dart';
import 'package:horizzon/ui/widgets/agenda_content/date_helpers.dart';

void main() {
  group('DateHelpers', () {
    group('isSameDay', () {
      test('devuelve true para el mismo día, mes y año', () {
        final date1 = DateTime(2023, 10, 15, 10, 30); // 15 Oct 2023, 10:30
        final date2 = DateTime(2023, 10, 15, 15, 45); // 15 Oct 2023, 15:45
        
        expect(DateHelpers.isSameDay(date1, date2), true);
      });

      test('devuelve false para días diferentes', () {
        final date1 = DateTime(2023, 10, 15);
        final date2 = DateTime(2023, 10, 16);
        
        expect(DateHelpers.isSameDay(date1, date2), false);
      });

      test('devuelve false para meses diferentes', () {
        final date1 = DateTime(2023, 10, 15);
        final date2 = DateTime(2023, 11, 15);
        
        expect(DateHelpers.isSameDay(date1, date2), false);
      });

      test('devuelve false para años diferentes', () {
        final date1 = DateTime(2023, 10, 15);
        final date2 = DateTime(2024, 10, 15);
        
        expect(DateHelpers.isSameDay(date1, date2), false);
      });
    });

    group('isEventOnDate', () {
      late Event singleDayEvent;
      late Event multiDayEvent;

      setUp(() {
        // Evento de un solo día
        singleDayEvent = Event(
          id: 1,
          name: 'Evento de un día',
          description: 'Descripción',
          longDescription: 'Descripción larga',
          eventTrackName: 'Track',
          eventTrackId: 1,
          location: 'Ubicación',
          initialDate: DateTime(2023, 10, 15, 9, 0), // 15 Oct 2023, 9:00
          finalDate: DateTime(2023, 10, 15, 17, 0),  // 15 Oct 2023, 17:00
          capacity: 100,
          availableSeats: 50,
          speakers: [],
          feedbacks: [],
          coverImageUrl: '',
          cardImageUrl: '',
        );

        // Evento de múltiples días
        multiDayEvent = Event(
          id: 2,
          name: 'Evento de múltiples días',
          description: 'Descripción',
          longDescription: 'Descripción larga',
          eventTrackName: 'Track',
          eventTrackId: 1,
          location: 'Ubicación',
          initialDate: DateTime(2023, 10, 15, 9, 0), // 15 Oct 2023, 9:00
          finalDate: DateTime(2023, 10, 17, 17, 0),  // 17 Oct 2023, 17:00
          capacity: 100,
          availableSeats: 50,
          speakers: [],
          feedbacks: [],
          coverImageUrl: '',
          cardImageUrl: '',
        );
      });

      test('devuelve true para la fecha de inicio del evento', () {
        final dateToCheck = DateTime(2023, 10, 15);
        expect(DateHelpers.isEventOnDate(singleDayEvent, dateToCheck), true);
        expect(DateHelpers.isEventOnDate(multiDayEvent, dateToCheck), true);
      });

      test('devuelve false para evento de un día en fecha diferente', () {
        final dateToCheck = DateTime(2023, 10, 16);
        expect(DateHelpers.isEventOnDate(singleDayEvent, dateToCheck), false);
      });

      test('devuelve true para fecha intermedia en evento de múltiples días', () {
        final dateToCheck = DateTime(2023, 10, 16);
        expect(DateHelpers.isEventOnDate(multiDayEvent, dateToCheck), true);
      });

      test('devuelve true para la fecha final en evento de múltiples días', () {
        final dateToCheck = DateTime(2023, 10, 17);
        expect(DateHelpers.isEventOnDate(multiDayEvent, dateToCheck), true);
      });

      test('devuelve false para fecha fuera del rango del evento', () {
        final beforeEvent = DateTime(2023, 10, 14);
        final afterEvent = DateTime(2023, 10, 18);
        
        expect(DateHelpers.isEventOnDate(multiDayEvent, beforeEvent), false);
        expect(DateHelpers.isEventOnDate(multiDayEvent, afterEvent), false);
      });
    });

    group('hasEvents', () {
      late List<Event> events;

      setUp(() {
        events = [
          Event(
            id: 1,
            name: 'Evento 1',
            description: 'Descripción',
            longDescription: 'Descripción larga',
            eventTrackName: 'Track',
            eventTrackId: 1,
            location: 'Ubicación',
            initialDate: DateTime(2023, 10, 15, 9, 0),
            finalDate: DateTime(2023, 10, 15, 17, 0),
            capacity: 100,
            availableSeats: 50,
            speakers: [],
            feedbacks: [],
            coverImageUrl: '',
            cardImageUrl: '',
          ),
          Event(
            id: 2,
            name: 'Evento 2',
            description: 'Descripción',
            longDescription: 'Descripción larga',
            eventTrackName: 'Track',
            eventTrackId: 1,
            location: 'Ubicación',
            initialDate: DateTime(2023, 10, 20, 9, 0),
            finalDate: DateTime(2023, 10, 22, 17, 0),
            capacity: 100,
            availableSeats: 50,
            speakers: [],
            feedbacks: [],
            coverImageUrl: '',
            cardImageUrl: '',
          ),
        ];
      });

      test('devuelve true si hay eventos en la fecha especificada', () {
        final date1 = DateTime(2023, 10, 15);
        final date2 = DateTime(2023, 10, 21);
        
        expect(DateHelpers.hasEvents(events, date1), true);
        expect(DateHelpers.hasEvents(events, date2), true);
      });

      test('devuelve false si no hay eventos en la fecha especificada', () {
        final date = DateTime(2023, 10, 18);
        expect(DateHelpers.hasEvents(events, date), false);
      });

      test('devuelve false para una lista vacía de eventos', () {
        final date = DateTime(2023, 10, 15);
        expect(DateHelpers.hasEvents([], date), false);
      });
    });

    group('calculateAverageRating', () {
      test('devuelve 0 para una lista vacía de feedbacks', () {
        expect(DateHelpers.calculateAverageRating([]), 0);
      });

      test('calcula correctamente el promedio para múltiples feedbacks', () {
        final feedbacks = [
          FeedbackbyUser(userId: '1', stars: 4, comment: 'Buen evento'),
          FeedbackbyUser(userId: '2', stars: 5, comment: 'Excelente'),
          FeedbackbyUser(userId: '3', stars: 3, comment: 'Regular'),
        ];
        
        // Promedio: (4 + 5 + 3) / 3 = 4
        expect(DateHelpers.calculateAverageRating(feedbacks), 4);
      });

      test('calcula correctamente el promedio con valores fraccionarios', () {
        final feedbacks = [
          FeedbackbyUser(userId: '1', stars: 3, comment: 'Regular'),
          FeedbackbyUser(userId: '2', stars: 4, comment: 'Bueno'),
        ];
        
        // Promedio: (3 + 4) / 2 = 3.5
        expect(DateHelpers.calculateAverageRating(feedbacks), 3.5);
      });

      test('maneja correctamente un único feedback', () {
        final feedbacks = [
          FeedbackbyUser(userId: '1', stars: 5, comment: 'Excelente'),
        ];
        
        expect(DateHelpers.calculateAverageRating(feedbacks), 5);
      });
    });
  });
}