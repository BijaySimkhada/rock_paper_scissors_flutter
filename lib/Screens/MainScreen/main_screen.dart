import 'package:flutter/material.dart';
import 'package:game_dev/Model/ComputerChoiceModel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _visible = false;
  bool _start = false;
  String _result = '';
  int computer_score = 0;
  int player_score = 0;

  final List<Image> _mainList = [
    Image.asset(
      'assets/images/rock.png',
      width: 100,
      height: 100,
    ),
    Image.asset(
      'assets/images/paper.png',
      width: 100,
      height: 100,
    ),
    Image.asset(
      'assets/images/scissors.png',
      width: 100,
      height: 100,
    ),
  ];
  final List<ComputerChoiceModel> _computer = [
    ComputerChoiceModel(
        'Rock',
        Image.asset(
          'assets/images/rock.png',
          width: 100,
          height: 100,
        )),
    ComputerChoiceModel(
        'Rock',
        Image.asset(
          'assets/images/paper.png',
          width: 100,
          height: 100,
        )),
    ComputerChoiceModel(
        'Scissors',
        Image.asset(
          'assets/images/scissors.png',
          width: 100,
          height: 100,
        )),
  ];

  _startGame(String choice) {
    setState(() {
      _start = true;
    });
    _computer.shuffle();
    if (_computer[0].name == choice) {
      _result = 'Draw';
    } else if (_computer[0].name == 'Rock' && choice == 'Paper') {
      _result = 'Player Wins';
    } else if (_computer[0].name == 'Paper' && choice == 'Rock') {
      _result = 'Computer Wins';
    } else if (_computer[0].name == 'Paper' && choice == 'Scissors') {
      _result = 'Player Wins';
    } else if (_computer[0].name == 'Scissors' && choice == 'Paper') {
      _result = 'Computer Wins';
    } else if (_computer[0].name == 'Scissors' && choice == 'Rock') {
      _result = 'Player Wins';
    } else if (_computer[0].name == 'Rock' && choice == 'Scissors') {
      _result = 'Computer Wins';
    }

    if (_result == 'Computer Wins') {
      setState(() {
        computer_score++;
      });
    } else if (_result == 'Player Wins') {
      setState(() {
        player_score++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rock Paper Scissors"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height - 30,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _mainList,
            ),
            const Divider(
              height: 10,
              color: Colors.black54,
            ),
            Visibility(
              visible: !_visible,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _visible = true;
                  });
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.purpleAccent,
                  radius: 50,
                  child: Icon(
                    Icons.play_arrow_outlined,
                    size: 50,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _visible,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Computer',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      _start == true
                          ? _computer[0].image
                          : const Text(
                              'Choose your option',
                              style: TextStyle(fontSize: 14),
                            )
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        'You',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: _mainList[0],
                            ),
                            onTap: () {
                              _startGame('Rock');
                            },
                          ),
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: _mainList[1],
                            ),
                            onTap: () {
                              _startGame('Paper');
                            },
                          ),
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: _mainList[2],
                            ),
                            onTap: () {
                              _startGame('Scissors');
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const Icon(
              Icons.safety_divider,
            ),
            const Text(
              'Scores',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(
              height: 10,
              color: Colors.black54,
            ),
            _start == true
                ? Container(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Computer',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text('$computer_score')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text(
                              'Player',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 16),
                            ),
                            Text('$player_score')
                          ],
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
            const Divider(
              height: 5,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
