import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:scoreboard/Animation/FadeAnimation.dart';
import 'package:scoreboard/pages/gamelist.dart';
import 'package:scoreboard/pages/loginpage.dart';
import 'package:string_validator/string_validator.dart';

class MySignUpHead extends StatefulWidget {
  @override
  _MySignUpHeadState createState() => _MySignUpHeadState();
}

class _MySignUpHeadState extends State<MySignUpHead> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MySignUpPage(),
    );
  }
}

class MySignUpPage extends StatefulWidget {
  @override
  _MySignUpPageState createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisibility = false;
  bool _confirmPasswordVisibility = false;
  bool _valid = true;
  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  bool _isLoading = false;

  _onSignUp() async {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });

    if (_confirmPassword != _password) {
      setState(() {
        _isLoading = false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Password didn't match."),
        ),
      );
      return;
    }
    try {
      FirebaseUser _user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: _email, password: _password))
          .user;
      setState(() {
        _isLoading = false;
      });
      if (_user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyLoginPage()));
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text("SomethingWrong."),
          ),
        );
        return;
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("SomethingWrong." + e.toString()),
        ),
      );
      return;
    }
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

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
                          "SignUp",
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
                                    ///email
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
                                        autovalidate: false,
                                        validator: (val) =>
                                            isEmail(val) && _valid
                                                ? null
                                                : "Email Format Fail",
                                        textInputAction: TextInputAction.next,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: "Email :",
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
                                        onEditingComplete: () {
                                          FocusScope.of(context).requestFocus(
                                              _confirmPasswordFocusNode);
                                        },
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
                                        autovalidate: false,
                                        validator: (val) =>
                                            val.length > 7 && _valid
                                                ? null
                                                : "Password at least length 8",
                                        textInputAction: TextInputAction.next,
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

                                    ///confirmPassword
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]))),
                                      child: TextFormField(
                                        autofocus: false,
                                        focusNode: _confirmPasswordFocusNode,
                                        onTap: () {
                                          setState(() {
                                            _valid = true;
                                          });
                                        },
                                        onChanged: (val) {
                                          _confirmPassword = val;
                                        },
                                        onSaved: (val) {
                                          _confirmPassword = val;
                                        },
                                        autovalidate: false,
                                        validator: (val) =>
                                            val == _password && _valid
                                                ? null
                                                : "Password should be match",
                                        textInputAction: TextInputAction.done,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        obscureText:
                                            !_confirmPasswordVisibility,
                                        decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  _confirmPasswordVisibility =
                                                      !_confirmPasswordVisibility;
                                                });
                                              },
                                              icon: _confirmPasswordVisibility
                                                  ? Icon(Icons.visibility)
                                                  : Icon(Icons.visibility_off),
                                              color: Theme.of(context)
                                                  .primaryColorDark,
                                            ),
                                            hintText: "Confirm Password",
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
                            1.6,
                            InkWell(
                              onTap: _onSignUp,
                              child: Container(
                                height: 50,
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.orange[900]),
                                child: Center(
                                  child: Text(
                                    "SignUp",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
