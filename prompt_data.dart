import 'package:flutter/material.dart';

class PromptData with ChangeNotifier {
  String _mosquitoAround = "";
  String _useNets = "";

  String _category = "";
  String _pregnantWomenQuestion = "";

  List<String> _selectedSymptoms = [];
  String _userAge = "";
  String _pregnancyAge = "";
  bool _antenatalClinicVisits = false;

  String get mosquitoAround => _mosquitoAround;
  String get useNets => _useNets;

  String get category => _category;
  String get pregnantWomenQuestion => _pregnantWomenQuestion;

  List<String> get selectedSymptoms => _selectedSymptoms;
  String get userAge => _userAge;
  String get pregnancyAge => _pregnancyAge;
  bool get antenatalClinicVisits => _antenatalClinicVisits;

  void updateMosquitoAround(String value) {
    _mosquitoAround = value;
    notifyListeners();
  }

  void updateUseNets(String value) {
    _useNets = value;
    notifyListeners();
  }

  void updateCategory(String value) {
    _category = value;
    notifyListeners();
  }

  void updatePregnantWomenQuestion(String value) {
    _pregnantWomenQuestion = value;
    notifyListeners();
  }

  void updateSelectedSymptoms(List<String> symptoms) {
    _selectedSymptoms = symptoms;
    notifyListeners();
  }

  void updateUserAge(String age) {
    _userAge = age;
    notifyListeners();
  }

  void updatePregnancyAge(String age) {
    _pregnancyAge = age;
    notifyListeners();
  }

  void updateAntenatalClinicVisits(bool visited) {
    _antenatalClinicVisits = visited;
    notifyListeners();
  }
}
