import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:bottom_sheet_stateful/bottom_sheet_stateful.dart';

void main() {
  test('call', () {
    var headWidget = Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 15),
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black12,
            ),
          ),
          Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                  "Geser ke atas untuk memulai", style: TextStyle(fontSize: 11))
          ),
        ],
      ),
    );

    var bodyWidget = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text('Login',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: "GTWalsheim-Medium",
                  fontSize: 30.0,
                  color: Colors.black
              )
          ),
        )
      ],
    );

    BottomSheetStateful(
        headWidget, //headWidget
        bodyWidget, //bodyWidget
        100, //peekHeight
        600, //maxHeight
        0, //marginTop
        17, //topRadius
        null
    );
  });
}
