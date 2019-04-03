library bottom_sheet_stateful;
import 'package:flutter/material.dart';

typedef Callback = void Function(double height);

class BottomSheetStateful extends StatefulWidget {
  final double peekHeight;
  final double maxHeight;
  final double marginTop;
  final double topRadius;
  final Widget head;
  final Widget body;
  final Callback callback;

  BottomSheetStateful(this.head, this.body, this.peekHeight, this.maxHeight, this.marginTop, this.topRadius, this.callback);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheetStateful> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double lockHeight;
  double currentHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      setState(() {
        currentHeight = widget.peekHeight;
        lockHeight = currentHeight;
      });
      if (widget.callback != null) widget.callback(currentHeight);
      _showBottomSheet();
    });
  }

  void _showBottomSheet() {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details){
              setState(() {
                currentHeight = MediaQuery.of(context).size.height - details.globalPosition.dy;
              });
            },
            onVerticalDragEnd: (DragEndDetails details) {
              setState(() {
                currentHeight = (currentHeight<lockHeight) ? widget.peekHeight : widget.maxHeight - widget.marginTop;
                lockHeight = currentHeight;
              });
              if (widget.callback != null) widget.callback(currentHeight);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: (currentHeight!=lockHeight) ? 50 : 400),
              height: currentHeight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.topRadius),
                    topRight: Radius.circular(widget.topRadius),
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    widget.head,
                    widget.body
                  ],
                ),
              ),
            ),
          );
        },
      );
    }).closed.whenComplete(() {
      if (mounted) {
        setState(() {
          currentHeight = widget.peekHeight;
          lockHeight = currentHeight;
        });
        if (widget.callback != null) widget.callback(currentHeight);
        _showBottomSheet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        color: Colors.transparent
      ),
    );
  }
}