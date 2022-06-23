import 'package:flutter/material.dart';
import 'package:uza_sales/app/retailer/widget/colors.dart';
import 'package:uza_sales/app/sales/utils/arrow_clipper.dart';

class SimpleAccountMenu extends StatefulWidget {
  final List<Widget> strings;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final Color iconColor;
  final ValueChanged<int> onChange;

  const SimpleAccountMenu({
    Key key,
    this.strings,
    this.borderRadius,
    this.backgroundColor = const Color(0xFFFFFFFFF),
    this.iconColor = Colors.black,
    this.onChange,
  })  : assert(strings != null),
        super(key: key);
  @override
  _SimpleAccountMenuState createState() => _SimpleAccountMenuState();
}

class _SimpleAccountMenuState extends State<SimpleAccountMenu>
    with SingleTickerProviderStateMixin {
  GlobalKey _key;
  bool isMenuOpen = false;
  Offset buttonPosition;
  Size buttonSize;
  OverlayEntry _overlayEntry;
  BorderRadius _borderRadius;
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _borderRadius = widget.borderRadius ?? BorderRadius.circular(8);
    _key = LabeledGlobalKey("button_icon");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  findButton() {
    RenderBox renderBox = _key.currentContext.findRenderObject();
    buttonSize = renderBox.size;
    buttonPosition = renderBox.localToGlobal(Offset.zero);
  }

  void closeMenu() {
    _overlayEntry.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openMenu() {
    findButton();
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isMenuOpen) {
          closeMenu();
        } else {
          openMenu();
        }
      },
      child: Container(
        key: _key,
        height: 38,
        width: 70,
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.preBase),
            borderRadius: _borderRadius),
        child: Center(
            child: Text(
          "More",
          style: TextStyle(fontSize: 16),
        )),
      ),
    );

    // Container(
    //   key: _key,
    //   decoration: BoxDecoration(
    //     color: Colors.green,
    //     borderRadius: _borderRadius,
    //   ),
    //   child: IconButton(
    //     icon: AnimatedIcon(
    //       icon: AnimatedIcons.menu_close,
    //       progress: _animationController,
    //     ),
    //     color: Colors.white,
    //     onPressed: () {
    //       if (isMenuOpen) {
    //         closeMenu();
    //       } else {
    //         openMenu();
    //       }
    //     },
    //   ),
    // );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          top: buttonPosition.dy + buttonSize.height,
          left: 180,
          width: 200,
          height: 360,
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 150.0),
                  child: ClipPath(
                    clipper: ArrowClipper(),
                    child: Container(
                      width: 17,
                      height: 17,
                      color: widget.backgroundColor ?? Color(0xFFF),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Container(
                    height: widget.strings.length * buttonSize.height,
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: _borderRadius,
                    ),
                    child: Theme(
                      data: ThemeData(
                        iconTheme: IconThemeData(
                          color: widget.iconColor,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children:
                            List.generate(this.widget.strings.length, (index) {
                          return GestureDetector(
                            onTap: () {
                              print("click $index");
                              widget.onChange(index);

                              closeMenu();
                            },
                            child: Container(
                              width: 200,
                              height: 25,
                              child: Center(child: widget.strings[index]),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
