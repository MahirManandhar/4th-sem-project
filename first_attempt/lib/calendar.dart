import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final String title;
  Event({
    required this.title,
  });
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

  late final ValueNotifier<List<Event>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedDate = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDate!));
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return mySelectedEvents[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 90),
          child: Text(
            'CALENDAR',
            style: TextStyle(fontFamily: 'FiraSans'),
          ),
        ),
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
                _selectedEvents.value = _getEventsForDay(selectedDay);
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
          const Divider(
            thickness: 5,
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () => debugPrint(""),
                            title: Text(value[index].title),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddEventDialog,
        backgroundColor: const Color.fromRGBO(131, 151, 136, 1),
        label: const Text(
          '+ Add Event',
          style: TextStyle(fontFamily: 'FiraSans'),
        ),
      ),
    );
  }

  _showAddEventDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Event',
          style: TextStyle(fontFamily: 'FiraSans'),
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
                  labelStyle: TextStyle(fontFamily: 'FiraSans'),
                  hintText: 'Title',
                  hintStyle: TextStyle(fontFamily: 'FiraSans')),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(131, 151, 136, 1)),
            child: const Text(
              'Cancel',
              style: TextStyle(fontFamily: 'FiraSans'),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(131, 151, 136, 1)),
            child: const Text(
              'Add Event',
              style: TextStyle(fontFamily: 'FiraSans'),
            ),
            onPressed: () {
              if (titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Center(
                        child: Text(
                      'Required title',
                      style: TextStyle(fontFamily: 'FiraSans'),
                    )),
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                mySelectedEvents.addAll({
                  _selectedDate!: [
                    Event(
                      title: titleController.text,
                    )
                  ]
                });
                Navigator.of(context).pop();
                _selectedEvents.value = _getEventsForDay(_selectedDate!);
              }
            },
          )
        ],
      ),
    );
  }
}
