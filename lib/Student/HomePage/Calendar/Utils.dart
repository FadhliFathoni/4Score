// Import statements...

import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

// Initialize 'kEvents' as an empty map
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
);

List<num> eventIndices = [];
List<Event> events = [Event("Coming soon")];
List<Event>? today = [];

Future<void> fetchDataFromFirestore() async {
  kEvents.clear();
  _kEventSource.clear();

  FirebaseFirestore.instance.collection("event").get().then((value) {
    value.docs.forEach((element) {
      var date = (element['date'] as Timestamp).toDate();
      var eventTitle = element['event'] as String;

      // Check if the date is already in 'kEvents', if not, add it
      if (!kEvents.containsKey(date)) {
        kEvents[date] = [];
      }

      // Add the event for the corresponding date
      kEvents[date]!.add(Event(eventTitle));
    });
  });

  // Fetch data from each collection and add events to 'kEvents'

  // Initialize '_kEventSource' based on 'kEvents' data
  kEvents.forEach((date, events) {
    _kEventSource[date] = events;
  });

  // Update 'today' list based on the current day events
  today = kEvents[DateTime.now()];

  // If 'today' is null (no events for today), set it as an empty list
  today ??= [];
}

final _kEventSource = <DateTime, List<Event>>{};

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(2023);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
