
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//RECOMENDACION DE USO : CUANDO VAYAN A REUTILIZAR MUCHOS TEXTSTYLE
class APTextStyle {

static TextStyle get titleForm {
    return GoogleFonts.nunito(
        fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);
  }

static  TextStyle get titleInputText {
    return GoogleFonts.nunito(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold);
  }

static TextStyle get titleHaveAcount {
    return GoogleFonts.nunito(
        fontSize: 15, color: Color.fromARGB(255, 251, 252, 252), fontWeight: FontWeight.bold);
  }

static  TextStyle get titleInputButton {
    return GoogleFonts.nunito(
        fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
  }
}