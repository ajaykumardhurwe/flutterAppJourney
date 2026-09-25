// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo App by Ajay',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: .fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page By Ajay'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: .center,
//           children: [
//             const Text('You have pushed the button this many times By Ajay: '),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }













import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------
// ENTRY POINT
// -----------------------------------------------------------------------------
void main() {
  runApp(const McqQuizApp());
}

class McqQuizApp extends StatefulWidget {
  const McqQuizApp({Key? key}) : super(key: key);

  @override
  State<McqQuizApp> createState() => _McqQuizAppState();
}

class _McqQuizAppState extends State<McqQuizApp> {
  bool _isDarkMode = true;

  void _toggleTheme(bool value) {
    setState(() => _isDarkMode = value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MCQ Quiz',
      debugShowCheckedModeBanner: false,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: MainTabNavigation(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// 5-TAB NAVIGATION CONTAINER
// -----------------------------------------------------------------------------
class MainTabNavigation extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const MainTabNavigation({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<MainTabNavigation> createState() => _MainTabNavigationState();
}

class _MainTabNavigationState extends State<MainTabNavigation> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(onStartPractice: () => _onTabTapped(1)),
      const PracticeQuizScreen(),
      const DailyChallengeScreen(),
      const LeaderboardScreen(),
      ProfileSettingsScreen(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack preserves state across tabs
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz_rounded),
            label: 'Practice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_rounded),
            label: 'Daily',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard_rounded),
            label: 'Ranks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// TAB 1: HOME SCREEN
// -----------------------------------------------------------------------------
class HomeScreen extends StatelessWidget {
  final VoidCallback onStartPractice;

  const HomeScreen({Key? key, required this.onStartPractice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Welcome Back 👋', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  Text('Alex Johnson', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              const CircleAvatar(child: Text('AJ')),
            ],
          ),
          const SizedBox(height: 16),

          // Banner
          Card(
            color: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Quick Practice', style: TextStyle(color: Colors.white70)),
                      Text('Flutter Core MCQ', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: onStartPractice,
                    child: const Text('Start'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// TAB 2: PRACTICE QUIZ SCREEN (STATEFUL QUIZ LOGIC)
// -----------------------------------------------------------------------------
class PracticeQuizScreen extends StatefulWidget {
  const PracticeQuizScreen({Key? key}) : super(key: key);

  @override
  State<PracticeQuizScreen> createState() => _PracticeQuizScreenState();
}

class _PracticeQuizScreenState extends State<PracticeQuizScreen> {
  int _currentQuestion = 0;
  int? _selectedOption;
  int _score = 0;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Which widget builds non-scrollable vertical layouts?',
      'options': ['Row', 'Column', 'ListView', 'Stack'],
      'answer': 1,
    },
    {
      'question': 'Which function triggers a UI rebuild in a StatefulWidget?',
      'options': ['rebuild()', 'setState()', 'updateUI()', 'notify()'],
      'answer': 1,
    },
  ];

  void _selectOption(int index) {
    setState(() {
      _selectedOption = index;
    });
  }

  void _nextQuestion() {
    if (_selectedOption == _questions[_currentQuestion]['answer']) {
      _score += 10;
    }
    setState(() {
      if (_currentQuestion < _questions.length - 1) {
        _currentQuestion++;
        _selectedOption = null;
      } else {
        // Quiz completed dialog
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Quiz Completed! 🎉'),
            content: Text('Your Score: $_score'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  setState(() {
                    _currentQuestion = 0;
                    _selectedOption = null;
                    _score = 0;
                  });
                },
                child: const Text('Restart'),
              )
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_currentQuestion];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Question ${_currentQuestion + 1} / ${_questions.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(q['question'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 16),

            ...List.generate((q['options'] as List).length, (i) {
              final option = q['options'][i];
              final isSelected = _selectedOption == i;
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: isSelected ? Colors.blue.withOpacity(0.2) : null,
                  ),
                  onPressed: () => _selectOption(i),
                  child: Text(option),
                ),
              );
            }),

            const Spacer(),
            ElevatedButton(
              onPressed: _selectedOption != null ? _nextQuestion : null,
              child: const Text('Next Question'),
            )
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// TAB 3: DAILY CHALLENGE SCREEN
// -----------------------------------------------------------------------------
class DailyChallengeScreen extends StatelessWidget {
  const DailyChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.emoji_events, size: 64, color: Colors.amber),
          SizedBox(height: 12),
          Text('Daily Challenge Screen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// TAB 4: LEADERBOARD SCREEN
// -----------------------------------------------------------------------------
class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.leaderboard, size: 64, color: Colors.purple),
          SizedBox(height: 12),
          Text('Leaderboard & Rankings Screen', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// TAB 5: PROFILE & SETTINGS SCREEN
// -----------------------------------------------------------------------------
class ProfileSettingsScreen extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const ProfileSettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const CircleAvatar(radius: 36, child: Text('AJ', style: TextStyle(fontSize: 24))),
          const SizedBox(height: 8),
          const Center(child: Text('Alex Johnson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          const SizedBox(height: 24),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDarkMode,
            onChanged: onThemeChanged,
          ),
        ],
      ),
    );
  }
}
          