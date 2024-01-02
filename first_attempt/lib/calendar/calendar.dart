import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  final String description;
  final DateTime date;

  Event(this.title, this.description) : date = DateTime.now();
}

class Calendar extends StatefulWidget {
  const Calendar({super.key});
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;

  Map<DateTime, List<Event>> mySelectedEvents = {};

  final titleController = TextEditingController();
  final descpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;

    // Example events
    mySelectedEvents = {
      DateTime(2023, 1, 1): [
        Event('Event Title 1', 'Event Description 1'),
        Event('Event Title 2', 'Event Description 2'),
      ],
      // Add more events as needed
    };
  }

  List<Event> _getEventsForDay(DateTime day) {
    return mySelectedEvents[day] ?? [];
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Event',
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descpController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            child: const Text('Add Event'),
            onPressed: () {
              if (titleController.text.isEmpty &&
                  descpController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Required title and description'),
                    duration: Duration(seconds: 2),
                  ),
                );
                return;
              } else {
                setState(() {
                  final selectedDay = _selectedDate ?? DateTime.now();
                  final eventDay = DateTime(
                      selectedDay.year, selectedDay.month, selectedDay.day);

                  if (mySelectedEvents[eventDay] != null) {
                    mySelectedEvents[eventDay]?.add(
                      Event(
                        titleController.text,
                        descpController.text,
                      ),
                    );
                  } else {
                    mySelectedEvents[eventDay] = [
                      Event(
                        titleController.text,
                        descpController.text,
                      ),
                    ];
                  }
                });

                print("New Event: ${mySelectedEvents[_selectedDate!]}");
                titleController.clear();
                descpController.clear();
                Navigator.pop(context);
                return;
              }
            },
          )
        ],
      ),
    );
  }

  // Calculate remaining days for an event
  int calculateRemainingDays(DateTime eventDate) {
    final now = DateTime.now();
    final difference = eventDate.difference(now);
    return difference.inDays;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        title: const Center(child: Text('Event Calendar')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showAddEventDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.utc(2080),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDate, day);
            },
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isNotEmpty) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 62, 93, 74),
                    ),
                    width: 8.0,
                    height: 8.0,
                  );
                }
                return Container();
              },
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddEventDialog,
        label: const Text('Add Event'),
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDate ?? DateTime.now());
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        final remainingDays = calculateRemainingDays(event.date);

        return Card(
          margin: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Event Title: ${event.title}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text('Description:${event.description}'),
                const SizedBox(
                  height: 8,
                ),
                Text('Remaining Days:$remainingDays'),
              ],
            ),
          ),
        );
      },
    );
  }
}
