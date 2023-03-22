import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get mediaSize => mediaQuery.size;
}
