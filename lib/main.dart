import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NavigationBar(),
    );
  }
}

class NavigationBar extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<NavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    SettingPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Моя музыкальная программа'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'О себе',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Главная'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 0;
                });
              },
            ),
            ListTile(
              title: Text('Настройки'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            ListTile(
              title: Text('Поиск'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _currentIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Настройки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Поиск',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Выборы 2020'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('В голосуете за Токаева'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Да'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Нет'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text('Button 1'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Это твой рабочий стол'),
                  duration: Duration(seconds: 5),
                ),
              );
            },
            child: Text('Button 2'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
              Future.delayed(Duration(seconds: 3), () {
                setState(() {
                  _isLoading = false;
                });
              });
            },
            child: Text('Загрузка'),
          ),
          SizedBox(height: 10),
          _isLoading
              ? CircularProgressIndicator()
              : Container(),
        ],
      ),
    );
  }
}

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? isFemale;
  List<String> hobbies = [];

  void _updateHobbies(String hobby, bool? isChecked) {
    setState(() {
      if (isChecked ?? false) {
        hobbies.add(hobby);
      } else {
        hobbies.remove(hobby);
      }
    });
  }

  void _updateGender(bool? isFemaleSelected) {
    setState(() {
      isFemale = isFemaleSelected ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Выбери свое хобби:',
                style: TextStyle(fontSize: 18),
              ),
              CheckboxListTile(
                title: Text('Танцы'),
                value: hobbies.contains('Танцы'),
                onChanged: (isChecked) => _updateHobbies('Танцы', isChecked),
              ),
              CheckboxListTile(
                title: Text('Шахматы'),
                value: hobbies.contains('Шахматы'),
                onChanged: (isChecked) => _updateHobbies('Шахматы', isChecked),
              ),
              CheckboxListTile(
                title: Text('Киберспорт'),
                value: hobbies.contains('Киберспорт'),
                onChanged: (isChecked) => _updateHobbies('Киберспорт', isChecked),
              ),
              CheckboxListTile(
                title: Text('Рисование'),
                value: hobbies.contains('Рисование'),
                onChanged: (isChecked) =>
                    _updateHobbies('Рисование', isChecked),
              ),
              CheckboxListTile(
                title: Text('Охота'),
                value: hobbies.contains('Охота'),
                onChanged: (isChecked) => _updateHobbies('Охота', isChecked),
              ),
              SizedBox(height: 10),
              Text(
                'Хобби: ${hobbies.join(", ")}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Выбери свой пол:',
                style: TextStyle(fontSize: 16),
              ),
              RadioListTile<bool>(
                title: Text('Женский'),
                value: true,
                groupValue: isFemale ?? false,
                onChanged: _updateGender,
              ),
              RadioListTile<bool>(
                title: Text('Мужской'),
                value: false,
                groupValue: isFemale ?? false,
                onChanged: _updateGender,
              ),
              SizedBox(height: 30),
              Text(
                'Hello: ${isFemale == true ? "Женский" : "Мужской"}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.album),
                    title: Text('Галерея'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Телефон'),
                  ),
                  ListTile(
                    leading: Icon(Icons.contacts),
                    title: Text('Контакты'),
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Настройки'),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: Colors.yellow,
                            title: Row(
                              children: [
                                Icon(Icons.album),
                                SizedBox(width: 8),
                                Text('Скриптонит'),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Самый лучший музыкант Скриптонит'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Запустить'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Остановить'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Text('Игрок'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(child: Text('Музыка')),
                            ),
                            TableCell(
                              child: Center(child: Text('Певец')),
                            ),
                            TableCell(
                              child: Center(child: Text('Год')),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(child: Text('Это любовь')),
                            ),
                            TableCell(
                              child: Center(child: Text('Скриптонит')),
                            ),
                            TableCell(
                              child: Center(child: Text('2015')),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(child: Text('О ней')),
                            ),
                            TableCell(
                              child: Center(child: Text('Farik')),
                            ),
                            TableCell(
                              child: Center(child: Text('2016')),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(child: Text('Жар-Жар')),
                            ),
                            TableCell(
                              child: Center(child: Text('Досмукасан')),
                            ),
                            TableCell(
                              child: Center(child: Text('1997')),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
