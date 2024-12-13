import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier{

  List<String> services = [];

  void addService(String service)
  {
    services.add(service);
    notifyListeners();
  }

  void removeService(int index)
  {
    services.removeAt(index);
    notifyListeners();
  }

  List<String> getServices () => services;

  bool checkServiceExists(String service)
  {
    for(int i=0;i<services.length;i++)
    {
      if(services[i]==service)
      {
        return true;
      }
    }
    return false;
  }

}

