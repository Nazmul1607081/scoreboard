import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:scoreboard/Animation/FadeAnimation.dart';
import 'package:scoreboard/pages/gamelist.dart';
import 'package:scoreboard/pages/signuppage.dart';

class MyLoginHead extends StatefulWidget {
  @override
  _MyLoginHeadState createState() => _MyLoginHeadState();
}

class _MyLoginHeadState extends State<MyLoginHead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }

  checkUser() async {
    if (await FirebaseAuth.instance.currentUser() != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyGameList()),
          (route) => false);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisibility = false;
  bool _valid = true;
  bool _isLoading = false;
  String _email = "";
  String _password = "";
  _login() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      FirebaseUser _user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: _email, password: _password))
          .user;
      if (_user != null) {
        Fluttertoast.showToast(
            msg: "Login Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.blueAccent,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyGameList()),
            (route) => false);
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("SomethingWrong."),
          ),
        );
        setState(() {
          _isLoading = false;
          _valid = false;
        });
        return;
      }
    } catch (e) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("SomethingWrong." + e.toString()),
        ),
      );
      setState(() {
        _isLoading = false;
        _valid = false;
      });
      return;
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.orange[900],
          Colors.orange[800],
          Colors.orange[400]
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FadeAnimation(
                        1,
                        Text(
                          "Login",
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                      Hero(
                        tag: "logo",
                        child: Image(
                          height: 60,
                          width: 60,
                          image: AssetImage('images/splashpage.png'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.4,
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(225, 95, 27, .3),
                                        blurRadius: 20,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        autofocus: false,
                                        focusNode: _emailFocusNode,
                                        onEditingComplete: () {
                                          FocusScope.of(context)
                                              .requestFocus(_passwordFocusNode);
                                        },
                                        onTap: () {
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
                                            _valid ? null : "Email :",
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: "Email or Phone number",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),

                                    ///password
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        autofocus: false,
                                        focusNode: _passwordFocusNode,
                                        onTap: () {
                                          setState(() {
                                            _valid = true;
                                          });
                                        },
                                        onChanged: (val) {
                                          _password = val;
                                        },
                                        onSaved: (val) {
                                          _password = val;
                                        },
                                        autovalidate: true,
                                        validator: (val) =>
                                            _valid ? null : "Password :",
                                        textInputAction: TextInputAction.done,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText: !_passwordVisibility,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _passwordVisibility =
                                                      !_passwordVisibility;
                                                });
                                              },
                                              icon: _passwordVisibility
                                                  ? Icon(Icons.visibility)
                                                  : Icon(Icons.visibility_off),
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            hintText: "Password",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            border: InputBorder.none),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.5,
                            Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.6,
                            InkWell(
                              onTap: _login,
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orange[900]),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeAnimation(
                            1.7,
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MySignUpHead()));
                              },
                              child: Text(
                                "Don't Register? SignUp",
                                style: TextStyle(color: Colors.grey),
                              ),
                            )),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
