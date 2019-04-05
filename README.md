# Bottom Sheet Stateful

This widget is implemented smooth stateful bottom sheet dragable with peek height and full height

## Screenshoot

<img src="https://raw.githubusercontent.com/tossaro/bottom_sheet_stateful/master/example/imgHeadView.png" width="200"/> <img src="https://raw.githubusercontent.com/tossaro/bottom_sheet_stateful/master/example/imgWidthView.png" width="200"/> <img src="https://raw.githubusercontent.com/tossaro/bottom_sheet_stateful/master/example/imgExtendView.png" width="200"/> <img src="https://raw.githubusercontent.com/tossaro/bottom_sheet_stateful/master/example/imgDecorationView.png" width="200"/> <img src="https://raw.githubusercontent.com/tossaro/bottom_sheet_stateful/master/example/imgMarginView.png" width="200"/>

## Getting Started

### 1. Add this to your package's pubspec.yaml file:

```
dependencies:
    bottom_sheet_stateful: ^0.0.3
```

### 2. You can install packages from the command line:

```
$ flutter packages get
```

### 3. Now in your Dart code, you can use:

```
import 'package:bottom_sheet_stateful/bottom_sheet_stateful.dart';
```

## Example

```
import 'package:flutter/material.dart';
import 'package:bottom_sheet_stateful/bottom_sheet_stateful.dart';
import 'package:flutter/cupertino.dart';

class IntroPage extends StatefulWidget {
  @override
  IntroState createState() => IntroState();
}

class IntroState extends State<IntroPage> {

  final _formKey = new GlobalKey<FormState>();

  BSAttribute bs1Attr;

  @override
  void initState() {
    super.initState();
    bs1Attr = BSAttribute();
  }

  void _bs1Callback(double width, double height) {
    print("bs1 callback-> width: ${width.toString()}, height: ${height.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    var login = Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 70),
              child: Text('Login',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontFamily: "GTWalsheim-Medium",
                      fontSize: 30.0,
                      color: Colors.black
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25),
              alignment: new FractionalOffset(0.5, 0.5),
              width: 330,
              child: Column(
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: Theme(
                                data: new ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black
                                  ),
                                  decoration: new InputDecoration(
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(25.0),
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        CupertinoIcons.person,
                                        size: 22.0,
                                        color: Colors.black,
                                      ),
                                      hintStyle: TextStyle(
                                          color: Colors.blueGrey,
                                          fontFamily: "WorkSansSemiBold", fontSize: 17.0
                                      ),
                                      hintText: "Email"
                                  ),
                                )
                            )
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 25.0, right: 25.0)),
                        Container(
                            child: Theme(
                                data: new ThemeData(
                                  primaryColor: Colors.redAccent,
                                  primaryColorDark: Colors.red,
                                ),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontFamily: "WorkSansSemiBold",
                                      fontSize: 16.0,
                                      color: Colors.black
                                  ),
                                  decoration: new InputDecoration(
                                      border: new OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(25.0),
                                        ),
                                      ),
                                      prefixIcon: Icon(
                                        CupertinoIcons.padlock,
                                        size: 22.0,
                                        color: Colors.black,
                                      ),
                                      hintStyle: TextStyle(
                                          color: Colors.blueGrey,
                                          fontFamily: "WorkSansSemiBold", fontSize: 17.0
                                      ),
                                      hintText: "Password"
                                  ),
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                          'Forget Password?',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: "GTWalsheim-Medium",
                              fontSize: 15.0,
                              color: Colors.red)
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: GestureDetector(
                        onTap: () {},
                        child: Image(width: 60.0, height: 60.0, fit: BoxFit.fill, image: AssetImage('assets/images/btn_login.png')
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return BottomSheetStateful(
        callback: _bs1Callback,
        attribute: bs1Attr,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 130),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        width: 170,
                        height: 70,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              bs1Attr = BSAttribute(
                                  headWidget: login,
                                  show: true
                              );
                            });
                          },
                          child: Text("Default Modal",style: TextStyle(fontSize: 21)),
                        )
                    ),
                    Container(
                        width: 170,
                        height: 70,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              bs1Attr = BSAttribute(show: false);
                            });
                          },
                          child: Text("Close Modal",style: TextStyle(fontSize: 21)),
                        )
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        width: 170,
                        height: 70,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              bs1Attr = BSAttribute(
                                  headWidget: login,
                                  closeOnSwipeDown: false,
                                  show: true
                              );
                            });
                          },
                          child: Text("Fix Modal",style: TextStyle(fontSize: 21)),
                        )
                    ),
                    Container(
                        width: 170,
                        height: 70,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              bs1Attr = BSAttribute(
                                  bodyWidget: login,
                                  closeOnSwipeDown: false,
                                  peekHeight: 100,
                                  maxHeight: 700,
                                  show: true
                              );
                            });
                          },
                          child: Text("Extendable Modal",style: TextStyle(fontSize: 21)),
                        )
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        width: 170,
                        height: 70,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              bs1Attr = BSAttribute(
                                  decoration: BoxDecoration(color: Colors.lightBlue),
                                  peekHeight: 100,
                                  show: true
                              );
                            });
                          },
                          child: Text("Decoration Modal",style: TextStyle(fontSize: 21)),
                        )
                    ),
                    Container(
                        width: 170,
                        height: 70,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              bs1Attr = BSAttribute(
                                  bodyWidget: login,
                                  smoothness: 700,
                                  peekHeight: 250,
                                  maxHeight: MediaQuery.of(context).size.height,
                                  show: true
                              );
                            });
                          },
                          child: Text("Smoothness Modal",style: TextStyle(fontSize: 21)),
                        )
                    )
                  ],
                ),
                Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                        width: 170,
                        height: 70,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              bs1Attr = BSAttribute(
                                  margin: EdgeInsets.only(bottom: 100),
                                  bodyWidget: login,
                                  smoothness: 700,
                                  peekHeight: 300,
                                  maxHeight: MediaQuery.of(context).size.height - 50,
                                  show: true
                              );
                            });
                          },
                          child: Text("Margin Modal",style: TextStyle(fontSize: 21)),
                        )
                    ),
                    Container(
                        width: 170,
                        height: 70,
                        child: RaisedButton(
                          onPressed: () {
                            setState(() {
                              bs1Attr = BSAttribute(
                                  headWidget: login,
                                  closeOnSwipeDown: false,
                                  peekHeight: 400,
                                  peekWidth: MediaQuery.of(context).size.width - 100,
                                  maxHeight: MediaQuery.of(context).size.height - 100,
                                  show: true
                              );
                            });
                          },
                          child: Text("Width Modal",style: TextStyle(fontSize: 21)),
                        )
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
```
