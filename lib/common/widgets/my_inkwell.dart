import 'package:flutter/material.dart';

class MyInKWell extends StatelessWidget {
  final Function onTap;
  final Widget child;

  const MyInKWell({Key key, this.onTap, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: child,
    );
  }
}

class MyInKWellCollored extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final Color color;

  const MyInKWellCollored(
      {Key key, this.onTap, this.child, this.color = const Color(0xffF3F5FF)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        focusColor: color,
        splashColor: color,
        hoverColor: color,
        highlightColor: color,
        child: child,
      ),
    );
  }
}
