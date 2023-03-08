import 'dart:io';

import 'package:flutter/foundation.dart';

final isGoogleSignInAvailable = kIsWeb || !Platform.isMacOS;
final isAppleSignInAvailable = !kIsWeb && (Platform.isIOS || Platform.isMacOS);
