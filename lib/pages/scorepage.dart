import 'package:flutter/material.dart';

class MyScore extends StatefulWidget {
  @override
  _MyScoreState createState() => _MyScoreState();
}

class _MyScoreState extends State<MyScore> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
        selectedIconTheme: IconThemeData(opacity: 1),
        unselectedIconTheme: IconThemeData(opacity: .5),
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/bat.png"),
            ),
            title: Text("Batsmen"),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("images/ball.png"),
            ),
            title: Text("Blowers"),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange[200],
                borderRadius: BorderRadius.circular(20),
              ),
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "BD: 123/5 ",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Overs: 5 ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///last balls
            Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Center(
                          child: Text("Last : "),
                        ),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [],
                    )
                  ],
                ),
              ),
            ),

            ///calculator
            Padding(
              padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.deepOrange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              // Respond to button press
                            },
                            color: Colors.green,
                            child: Text("1"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              // Respond to button press
                            },
                            color: Colors.green,
                            child: Text("2"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              // Respond to button press
                            },
                            color: Colors.green,
                            child: Text("3"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              // Respond to button press
                            },
                            color: Colors.green,
                            child: Text("4"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              // Respond to button press
                            },
                            color: Colors.green,
                            child: Text("5"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              // Respond to button press
                            },
                            color: Colors.green,
                            child: Text("6"),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              // Respond to button press
                            },
                            color: Colors.green,
                            child: Text("7"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              // Respond to button press
                            },
                            color: Colors.green,
                            child: Text("0"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            textColor: Color(0xFF6200EE),
                            onPressed: () {
                              // Respond to button press
                            },
                            color: Colors.green,
                            child: Text("W"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
