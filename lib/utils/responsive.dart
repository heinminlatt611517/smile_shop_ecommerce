import 'package:flutter/material.dart';

class Responsive {
  final BuildContext context;
  
  Responsive(this.context);

  static const double phoneMaxWidth = 600;
  static const double tabletMaxWidth = 1200;

  bool get isPhone => MediaQuery.of(context).size.width < phoneMaxWidth;
  
  bool get isTablet => MediaQuery.of(context).size.width >= phoneMaxWidth &&
                        MediaQuery.of(context).size.width < tabletMaxWidth;
  
  bool get isWeb => MediaQuery.of(context).size.width >= tabletMaxWidth;
}
