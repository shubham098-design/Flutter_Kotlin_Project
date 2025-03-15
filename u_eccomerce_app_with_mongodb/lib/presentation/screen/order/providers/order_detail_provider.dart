import 'package:flutter/cupertino.dart';

class OrderDetailProvider extends ChangeNotifier{
  String? paymentMethod = "pay-now";

  void changePaymentMethod(String? value) {
    paymentMethod = value;
    notifyListeners();
  }
}