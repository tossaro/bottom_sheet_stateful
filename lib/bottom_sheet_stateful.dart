library bottom_sheet_stateful;

import 'package:flutter/material.dart';

typedef Callback = void Function(double width, double height);

BoxDecoration decorationDefault = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(17),
    topRight: Radius.circular(17),
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black,
      blurRadius: 1,
    ),
  ],
);

var headWidgetDefault = Center(
  child: Container(
  margin: EdgeInsets.only(top: 15),
  child: Padding(
    padding: EdgeInsets.all(15),
    child: Text("Swipe up to start", style: TextStyle(fontSize: 11))),
  ),
);

class BSAttribute {
  final EdgeInsets margin;
  final BoxDecoration decoration;
  final double peekHeight;
  final double peekWidth;
  final double maxHeight;
  final int smoothness;
  final bool closeOnSwipeDown;
  final Widget headWidget;
  final Widget bodyWidget;
  final bool showHead;
  final bool showBody;

  BSAttribute(
      {BoxDecoration decoration,
        EdgeInsets margin,
        double peekHeight,
        double peekWidth,
        double maxHeight,
        bool closeOnSwipeDown,
        int smoothness,
        Widget headWidget,
        Widget bodyWidget,
        bool showHead,
        bool showBody})
      : this.decoration = decoration ?? decorationDefault,
        this.margin = margin ?? null,
        this.peekHeight = peekHeight ?? null,
        this.peekWidth = peekWidth ?? null,
        this.maxHeight = maxHeight ?? null,
        this.closeOnSwipeDown = closeOnSwipeDown ?? true,
        this.smoothness = smoothness ?? 400,
        this.headWidget = headWidget ?? headWidgetDefault,
        this.bodyWidget = bodyWidget ?? null,
        this.showHead = showHead ?? false,
        this.showBody = showBody ?? false;
}

class BottomSheetStateful extends StatefulWidget {
  final Callback callback;
  final BSAttribute attribute;
  final Widget body;

  BottomSheetStateful({Callback callback, BSAttribute attribute, @required Widget body})
      : this.callback = callback ?? null,
        this.attribute = attribute ?? BSAttribute(),
        this.body = body ?? null;

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheetStateful> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var bsState;
  bool visible;
  bool currentShowHead;
  bool currentShowBody;
  BuildContext bsContext;
  EdgeInsets currentMargin;
  BoxDecoration currentDecoration;
  double lockHeight;
  double lockWidth;
  bool closeOnSwipeDown;
  double currentPeekHeight;
  double currentPeekWidth;
  double currentMaxHeight;
  double currentHeight;
  double currentWidth;
  int currentSmoothness;
  double headOpacity;
  double bodyOpacity;
  Widget currentHeadWidget;
  Widget currentBodyWidget;

  @override
  void initState() {
    super.initState();
    visible = false;
    headOpacity = 1;
    bodyOpacity = 0;
    currentBodyWidget = Container();
    _refreshUI();
  }

  void _showBottomSheet() {
    _scaffoldKey.currentState
        .showBottomSheet<void>((BuildContext context) {
      bsContext = context;
      return StatefulBuilder(
        builder: (context, setState) {
          bsState = setState;
          return GestureDetector(
            onVerticalDragUpdate: (DragUpdateDetails details) {
              if (currentPeekHeight == null) {
                var box = bsContext.findRenderObject() as RenderBox;
                currentPeekHeight = box.size.height;
                currentHeight = currentPeekHeight;
                lockHeight = currentHeight;
              }
              double h = MediaQuery.of(context).size.height -
                  details.globalPosition.dy;
              if (currentWidth != null) {
                if (currentHeight > h)
                  currentWidth--;
                else
                  currentWidth++;
              }
              setState(() {
                currentHeight = (h != null && h > 0) ? h : currentHeight;
                if (currentWidth != null)
                  currentWidth =
                  (currentWidth < MediaQuery.of(context).size.width)
                      ? currentWidth
                      : MediaQuery.of(context).size.width;
              });
            },
            onVerticalDragEnd: (DragEndDetails details) {
              currentMaxHeight = (currentMaxHeight != null)
                  ? currentMaxHeight
                  : currentPeekHeight;
              if (closeOnSwipeDown && currentHeight <= lockHeight / 2) {
                currentPeekHeight = 0;
                currentShowHead = false;
                currentShowBody = false;
              }
              setState(() {
                currentHeight = (currentHeight <= lockHeight)
                    ? currentPeekHeight
                    : currentMaxHeight;
                lockHeight = currentHeight;
                currentShowBody = currentHeight == currentMaxHeight;
                if (currentWidth != null)
                  currentWidth = (currentHeight == currentMaxHeight)
                      ? MediaQuery.of(context).size.width
                      : lockWidth;
              });
              _swap_head_body();
            },
            child: AnimatedContainer(
              duration: Duration(
                  milliseconds: (currentHeight != lockHeight)
                      ? 50
                      : currentSmoothness),
              margin: currentMargin,
              decoration: currentDecoration,
              height: currentHeight,
              width: currentWidth,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: headOpacity,
                      duration: Duration(milliseconds: currentSmoothness),
                      child: currentHeadWidget,
                    ),
                    AnimatedOpacity(
                      opacity: bodyOpacity,
                      duration: Duration(milliseconds: currentSmoothness),
                      child: currentBodyWidget,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    })
        .closed
        .whenComplete(() {
      if (mounted && !closeOnSwipeDown) {
        currentShowHead = true;
        currentShowBody = false;
        _swap_head_body();
      } else {
        currentShowHead = false;
        currentShowBody = false;
        visible = false;
      }
    });
  }

  void _showHead() {
    headOpacity = 1;
    bodyOpacity = 0;
    currentHeadWidget = widget.attribute.headWidget;
    currentBodyWidget = Container();
    currentHeight = currentPeekHeight;
  }

  void _showBody() {
    headOpacity = 0;
    bodyOpacity = 1;
    currentHeadWidget = Container();
    currentBodyWidget = widget.attribute.bodyWidget;
    currentHeight = currentMaxHeight;
  }

  void _swap_head_body() {
    if (widget.attribute.bodyWidget != null) {
      if (!currentShowBody) {
        _showHead();
        if (bsState!=null) bsState(() => _showHead());
      } else if (currentShowBody) {
        _showBody();
        if (bsState!=null) bsState(() => _showBody());
      }
    }
    if (widget.callback != null) widget.callback(currentHeight, currentWidth);
    if (currentShowHead && !visible) {
      visible = true;
      _showBottomSheet();
    } else if (!currentShowHead && visible) {
      Navigator.pop(context);
    }
  }

  void _refreshUI() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentShowHead = widget.attribute.showHead ?? false;
      currentShowBody = widget.attribute.showBody ?? false;
      currentDecoration = widget.attribute.decoration ?? decorationDefault;
      currentHeadWidget = widget.attribute.headWidget ?? headWidgetDefault;
      currentBodyWidget = widget.attribute.bodyWidget ?? Container();
      closeOnSwipeDown = widget.attribute.closeOnSwipeDown;
      currentSmoothness = widget.attribute.smoothness ?? 400;
      currentMargin = widget.attribute.margin;
      currentMaxHeight = widget.attribute.maxHeight;
      currentPeekHeight = widget.attribute.peekHeight;
      currentHeight = currentPeekHeight;
      lockHeight = currentHeight;
      currentPeekWidth = widget.attribute.peekWidth;
      currentWidth = currentPeekWidth;
      lockWidth = currentWidth;
      _swap_head_body();
    });
  }

  @override
  void didUpdateWidget(BottomSheetStateful oldWidget) {
    super.didUpdateWidget(oldWidget);
    _refreshUI();
  }

  @override
  Widget build(BuildContext defaultContext) {
    return Scaffold(key: _scaffoldKey, body: widget.body);
  }
}
