import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:dti_digital/serialize.dart';
import 'package:dti_digital/reminder.dart';
import 'package:dti_digital/data.dart';
import 'package:dti_digital/home_content.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF456189),
      systemNavigationBarColor: Colors.white,
    ),
  );
  initializeDateFormatting('pt_BR', null);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: const DtiDigital(),
    ),
  );
}

class AppState extends ChangeNotifier {
  int clickedID = 0;

  void updateClickedID(int id) {
    clickedID = id;
    notifyListeners();
  }

  String clickedName = "";

  void setClickedName(String name) {
    clickedName = name;
  }

  DateTime currentDate = DateTime(2023, 11, 26);

  void setDate(DateTime newDate) {
    currentDate = newDate;
  }

  late List<EventData> events;
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Calendar();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'Create',
          builder: (BuildContext context, GoRouterState state) {
            return const NewReminder();
          },
        ),
      ],
    ),
  ],
);

/// The main app.
class DtiDigital extends StatelessWidget {
  /// Constructs a [MyApp]
  const DtiDigital({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF456189)),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

/// The home screen
class _CalendarState extends State<Calendar> {
  DateTime _currentDate = DateTime.now();

  void _changeDate(DateTime newDate) {
    setState(() {
      _currentDate = newDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Column(
              children: [
                Text(
                  "dti",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Lembretes",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFF000000),
                  ),
                )
              ],
            ),
            Container(
              width: 50,
            ),
          ],
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black54,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .9,
                padding: const EdgeInsets.only(bottom: 5),
                child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        )),
                    child: Row(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          color: Colors.black54,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.white,
                              )),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          alignment: Alignment.center,
                          child: const Text(
                            "Exibindo todos os lembretes",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 1),
                color: Colors.black87,
                child: TableCalendar(
                  focusedDay: _currentDate,
                  firstDay: DateTime.now().subtract(const Duration(days: 365)),
                  lastDay: DateTime.now().add(const Duration(days: 365)),
                  calendarFormat: CalendarFormat.week,
                  locale: "pt_BR",
                  daysOfWeekVisible: true,
                  currentDay: _currentDate,
                  headerStyle: const HeaderStyle(
                    titleTextStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    formatButtonVisible: false,
                  ),
                  calendarStyle: const CalendarStyle(
                    defaultTextStyle: TextStyle(color: Colors.white),
                    isTodayHighlighted: true,
                    todayTextStyle: TextStyle(color: Colors.black),
                    weekendTextStyle: TextStyle(color: Colors.red),
                    todayDecoration: BoxDecoration(
                        color: Colors.white, shape: BoxShape.circle),
                  ),
                  daysOfWeekStyle: const DaysOfWeekStyle(
                    weekdayStyle: TextStyle(color: Colors.white),
                    weekendStyle: TextStyle(color: Colors.red),
                  ),
                  eventLoader: (date) => [],
                  onDaySelected: (selectedDay, focusedDay) {
                    _changeDate(DateTime(
                        selectedDay.year, selectedDay.month, selectedDay.day));
                    appState.setDate(DateTime(
                        selectedDay.year, selectedDay.month, selectedDay.day));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5.0),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9,
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.9),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: const Color(0xFF38C7DA),
                    padding: const EdgeInsets.all(5),
                    side: const BorderSide(
                      style: BorderStyle.none,
                    ),
                  ),
                  onPressed: () {
                    GoRouter.of(context).go('/Create');
                  },
                  child: const Text(
                    "Criar Novo Lembrete",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                  child: FutureBuilder<List<EventData>?>(
                future: fetchData(_currentDate),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final events = snapshot.data!;
                    //return EventList(events: events);
                    return KeyedSubtree(
                        key: UniqueKey(),
                        child: EventList(key: GlobalKey(), events: events));
                  } else {
                    return const Text('Nenhum dado disponível');
                  }
                },
              )),
            ]),
      ),
    );
  }
}
