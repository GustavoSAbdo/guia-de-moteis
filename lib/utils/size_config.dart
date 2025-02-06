import 'package:flutter/material.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    
    // Dividindo a tela em 100 blocos para cálculos percentuais
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    
    // Tamanho padrão baseado na média das dimensões
    defaultSize = orientation == Orientation.landscape
        ? screenHeight * 0.024
        : screenWidth * 0.024;
  }

  // Métodos utilitários para dimensões responsivas
  static double getProportionateScreenHeight(double inputHeight) {
    return (inputHeight / 812.0) * screenHeight;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    return (inputWidth / 375.0) * screenWidth;
  }

  // Retorna uma dimensão responsiva baseada em porcentagem da largura da tela
  static double widthPercentage(double percentage) {
    return blockSizeHorizontal * percentage;
  }

  // Retorna uma dimensão responsiva baseada em porcentagem da altura da tela
  static double heightPercentage(double percentage) {
    return blockSizeVertical * percentage;
  }

  // Retorna um tamanho de fonte responsivo
  static double fontSize(double size) {
    return defaultSize * (size / 14.0);
  }
} 