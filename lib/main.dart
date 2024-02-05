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
            icon: Icon(Icons.macro_off),
            label: 'Предупрежение',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sailing),
            label: 'Данные',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.radio),
            label: 'Музыки',
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
                    title: Text('Завтра концерт'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Вам купить билет?'),
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
                  content: Text('Это ваши данные'),
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
                'В какой стране были вы:',
                style: TextStyle(fontSize: 18),
              ),
              CheckboxListTile(
                title: Text('Россия'),
                value: hobbies.contains('Россия'),
                onChanged: (isChecked) => _updateHobbies('Россия', isChecked),
              ),
              CheckboxListTile(
                title: Text('Тайланд'),
                value: hobbies.contains('Тайланд'),
                onChanged: (isChecked) => _updateHobbies('Тайланд', isChecked),
              ),
              CheckboxListTile(
                title: Text('Франция'),
                value: hobbies.contains('Франция'),
                onChanged: (isChecked) => _updateHobbies('Франция', isChecked),
              ),
              CheckboxListTile(
                title: Text('Италия'),
                value: hobbies.contains('Италия'),
                onChanged: (isChecked) =>
                    _updateHobbies('Италия', isChecked),
              ),
              CheckboxListTile(
                title: Text('Америка'),
                value: hobbies.contains('Америка'),
                onChanged: (isChecked) => _updateHobbies('Америка', isChecked),
              ),
              SizedBox(height: 10),
              Text(
                'Страны где я была: ${hobbies.join(", ")}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Text(
                'Выбери свой статус:',
                style: TextStyle(fontSize: 16),
              ),
              RadioListTile<bool>(
                title: Text('Замужем\Женат'),
                value: true,
                groupValue: isFemale ?? false,
                onChanged: _updateGender,
              ),
              RadioListTile<bool>(
                title: Text('свобона\свободен'),
                value: false,
                groupValue: isFemale ?? false,
                onChanged: _updateGender,
              ),
              SizedBox(height: 30),
              
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
                    leading: Icon(Icons.shop),
                    title: Text('Онлай магазин'),
                  ),
                  ListTile(
                    leading: Icon(Icons.store),
                    title: Text('Плеймаркет'),
                  ),
                  ListTile(
                    leading: Icon(Icons.library_add),
                    title: Text('Заметки'),
                  ),
                  ListTile(
                    leading: Icon(Icons.play_arrow_outlined),
                    title: Text('Игры'),
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
                                Text('френк'),
                              ],
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Самый лучший Игрок'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('посмотреть'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('закрыть'),
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
                              child: Center(child: Text('Игры')),
                            ),
                            TableCell(
                              child: Center(child: Text('Игрок')),
                            ),
                            TableCell(
                              child: Center(child: Text('Награды')),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(child: Text('SubwayS')),
                            ),
                            TableCell(
                              child: Center(child: Text('Lessy')),
                            ),
                            TableCell(
                              child: Center(child: Text('27')),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(child: Text('Royalmatch')),
                            ),
                            TableCell(
                              child: Center(child: Text('Nazyken')),
                            ),
                            TableCell(
                              child: Center(child: Text('33')),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            TableCell(
                              child: Center(child: Text('Fishes')),
                            ),
                            TableCell(
                              child: Center(child: Text('Nazerke')),
                            ),
                            TableCell(
                              child: Center(child: Text('19')),
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


