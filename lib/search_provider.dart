import 'package:flutter/material.dart';

class SearchProvider with ChangeNotifier {

  final List<String> services = [
    'Plumber',
    'Carpenter',
    'Beautician',
    'Electrician',
    'AC Service',
    'Masonry Work',
    'Toilet Cleaning',
    'Homemaker',
    'Laundry',
    'Salon',
    'RMP (Registered Medical Practitioner)',
    'Rental House',
    'Puncture Repair',
    'Bike Mechanic',
    'Home Plans',
    'Vastu Consultant',
    'Engineer',
    'Home Loans',
    'Bike Finance',
    'Flat Mediator',
    'Priest',
    'Washer (Laundry Worker)',
    'Domestic Worker',
    'Marriage Mediator'
  ];

   List<String> _filteredServices = [
      'Plumber',
      'Carpenter',
      'Beautician',
      'Electrician',
      'AC Service',
      'Masonry Work',
      'Toilet Cleaning',
      'Homemaker',
      'Laundry',
      'Salon',
      'RMP (Registered Medical Practitioner)',
      'Rental House',
      'Puncture Repair',
      'Bike Mechanic',
      'Home Plans',
      'Vastu Consultant',
      'Engineer',
      'Home Loans',
      'Bike Finance',
      'Flat Mediator',
      'Priest',
      'Washer (Laundry Worker)',
      'Domestic Worker',
      'Marriage Mediator'
    ];

   List<String> get filteredServices =>   _filteredServices;

   void filter(String query){
    if(query.isEmpty){
      _filteredServices = services;
    }
    else{
      _filteredServices = services.where((service) => service.toLowerCase().contains(query.toLowerCase())).toList();
    }
    notifyListeners();
   }

}