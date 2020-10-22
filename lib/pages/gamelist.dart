import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:scoreboard/pages/scorepage.dart';

class MyGameList extends StatefulWidget {
  @override
  _MyGameListState createState() => _MyGameListState();
}

class _MyGameListState extends State<MyGameList> {
  int _currentIndex = 0;
  final FocusNode _nameFocusNode = FocusNode();

  Future<void> _enterMatchDialog() async {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Create a Match'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[200]))),
                        child: TextFormField(
                          autofocus: false,
                          focusNode: _nameFocusNode,
                          /*onEditingComplete: () {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },*/
                          /* onTap: () {
                            setState(() {
                              _valid = true;
                            });
                          },
                          onSaved: (val) {
                            _email = val;
                          },
                          onChanged: (val) {
                            _email = val;
                          },
                          autovalidate: true,
                          validator: (val) =>
                          _valid ? null : "Email :",*/
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Team Name :",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyScore()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          MySlider(),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "All Games",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
          ),
        ],
      ),
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
        backgroundColor: Colors.deepOrange,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.border_all),
            title: Text("All Matches"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.my_location),
            title: Text("My Matches"),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _enterMatchDialog();
        },
        tooltip: 'Create a Match',
        child: Icon(Icons.add),
        elevation: 2.0,
      ),
    );
  }
}

class MySlider extends StatefulWidget {
  @override
  _MySliderState createState() => _MySliderState();
}

class _MySliderState extends State<MySlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 160.0,
        autoPlayCurve: Curves.linear,
        autoPlay: true,
      ),
      items: [1, 2, 3, 4].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                    image: AssetImage("images/images.jpg"),
                    fit: BoxFit.cover,
                  )),
            );
          },
        );
      }).toList(),
    );
  }
}
