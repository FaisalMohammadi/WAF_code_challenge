import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@singleton
class ShoppingCardService with ChangeNotifier {
  int _shoppingCardCounter = 0;
  int get shoppingCardCounter => _shoppingCardCounter;

  int getCounter() {
   //_getPrefsItems();
   return _shoppingCardCounter;
 }
}
