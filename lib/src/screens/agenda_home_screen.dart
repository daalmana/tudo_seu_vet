import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tudo_seu_vet/src/models/consults.dart';
import 'package:tudo_seu_vet/src/providers/consult_provider.dart';
import 'package:tudo_seu_vet/src/screens/consult_add_screen.dart';
import 'package:tudo_seu_vet/src/widgets/loading_spinner.dart';

class AgendaHomeScreen extends StatefulWidget {
  static const routeName = '/agenda-home';
  @override
  _AgendaHomeScreenState createState() => _AgendaHomeScreenState();
}

class _AgendaHomeScreenState extends State<AgendaHomeScreen> {
  CalendarController _calendarController = CalendarController();
  Map<DateTime, List<Consult>> _groupedEvents;

  _groupEvents(List<Consult> events) {
    _groupedEvents = {};
    events.forEach((event) {
      DateTime date =
          DateTime.utc(event.date.year, event.date.month, event.date.day, 12);
      if (_groupedEvents[date] == null) _groupedEvents[date] = [];
      _groupedEvents[date].add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat("dd-MM-yyyy / HH:mm");
    final consultProvider = Provider.of<ConsultProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Agenda',
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<Consult>>(
          stream: consultProvider.consults,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final events = snapshot.data;
              _groupEvents(events);
              DateTime selectedDate = _calendarController.selectedDay;
              final _selectedEvents = _groupedEvents[selectedDate] ?? [];
              return Column(
                children: [
                  Card(
                    margin: EdgeInsets.all(8.0),
                    child: TableCalendar(
                      calendarController: _calendarController,
                      events: _groupedEvents,
                      onDaySelected: (date, events, holiday) {
                        setState(() {});
                      },
                      locale: 'pt_BR',
                      startingDayOfWeek: StartingDayOfWeek.monday,
                    ),
                  ),
                  ListView.separated(
                    padding: EdgeInsets.all(
                      8.0,
                    ),
                    shrinkWrap: true,
                    itemCount: _selectedEvents.length,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      thickness: 1.3,
                    ),
                    itemBuilder: (context, index) {
                      Consult event = _selectedEvents[index];
                      return ListTile(
                        title: Text(event.contactId),
                        subtitle: Text(
                          formatter.format(
                            event.date,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddConsultScreen(
                                consult: _selectedEvents[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            }
            return LoadingSpinner(Colors.green);
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: FaIcon(
          FontAwesomeIcons.plus,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AddConsultScreen.routeName);
        },
      ),
    );
  }
}
