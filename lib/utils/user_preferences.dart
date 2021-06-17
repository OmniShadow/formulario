import 'dart:io';

import 'package:flutter/material.dart';
import 'package:formulario/model/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:formulario/HomePageScreen.dart';

class UserPreferences {
  static const myUser = User(
    imagePath: 'null',
    name: 'Formulario Team',
    email: "null",
    about: 'Logaritmi, esponenziali ecc.',
    isDarkMode: true,
  );
}
