# Bottom Sheet Stateful

This widget is implemented smooth stateful bottom sheet dragable with peek height and full height

## Screenshoot

![Screenshot](/example/imgHeadView.png =250x)  ![Screenshot](/example/imgBodyView.png =250x)

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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: 'Bottom Sheet Stateful',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                canvasColor: Colors.transparent,
            ),
            home: IntroPage()
        );
    }
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final formKey = new GlobalKey<FormState>();

class IntroPage extends StatefulWidget {
    @override
    IntroState createState() => IntroState();
}

class IntroState extends State<IntroPage> {
    final double peekHeight = 100;
    double bsMaxHeight;
    double currentHeight;
    var currentBodyWidget;

    @override
    void initState() {
        super.initState();
        //bsMaxHeight = MediaQuery.of(context).size.height; //for fullscreen
        bsMaxHeight = 450;
        WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
                currentHeight = peekHeight;
            });
        });
    }

    @override
    Widget build(BuildContext context) {

        var bsCallback = (double height) {
            print(height);
            if (height<=peekHeight) {
            const iconUp = "assets/icons/ic_up.png";
            const iconDown = "assets/icons/ic_down.png";
            if (headChildWidget.length==1) {
                headChildWidget.add(Image.asset(
                (height == peekHeight) ? iconUp : iconDown, scale: 1.0,
                    width: 25,
                    height: 25));
                    headChildWidget.add(Padding(
                    padding: EdgeInsets.all(15),
                    child: Text("Swipe up to start", style: TextStyle(fontSize: 11))
                ));
                currentBodyWidget = Container();
                }
            } else if (height==bsMaxHeight) {
                if (headChildWidget.length==3) headChildWidget.removeRange(1,3);
                currentBodyWidget = bodyWidget;
            }
            setState(() {
                currentHeight = height;
            });
        };

        return Scaffold(
            key: _scaffoldKey,
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/bg.png"),
                        fit: BoxFit.cover,
                    ),
                ),
                child: BottomSheetStateful(
                    Center(child: Column(children: headChildWidget)), //headWidget
                    currentBodyWidget, //bodyWidget
                    peekHeight, //peekHeight
                    bsMaxHeight, //maxHeight
                    0, //marginTop
                    17, //topRadius
                    bsCallback
                ),
            ),
        );
    }
}

var headChildWidget = <Widget>[
    Container(
        margin: EdgeInsets.only(bottom: 15),
        width: 100,
        height: 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black12,
        ),
    ),
];

var bodyWidget = Center(
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
                margin: EdgeInsets.only(top:25),
                alignment: new FractionalOffset(0.5, 0.5),
                width: 330,
                child: Column(
                    children: <Widget>[
                        Form(
                            key: formKey,
                            child: Column(
                                children: <Widget>[
                                    inputEmailWidget,
                                    Padding(padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 25.0, right: 25.0)),
                                    inputPasswordWidget,
                                ],
                            ),
                        ),
                        forgotPasswordWidget,
                        submitButtonWidget,
                    ],
                ),
            ),
        ],
    ),
);

var inputEmailWidget = Container(
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
                    fontFamily: "WorkSansSemiBold", fontSize: 13.0
                ),
                hintText: "Email"
            ),
        )
    )
);

var inputPasswordWidget = Container(
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
                    fontFamily: "WorkSansSemiBold", fontSize: 13.0
                ),
                hintText: "Password"
            ),
        )
    )
);

var forgotPasswordWidget = Align(
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
                color: Colors.red
            ),
        ),
    ),
);

var submitButtonWidget = Align(
    alignment: Alignment.bottomRight,
    child: Container(
        margin: EdgeInsets.only(top: 15),
        child: GestureDetector(
            child:Image(
                width: 60.0,
                height: 60.0,
                fit: BoxFit.fill,
                image: new AssetImage('assets/images/btn_login.png')
            ),
        ),
    ),
);
```
