// ignore_for_file: file_names

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storeapp/cubit/cubitState.dart';

class Cubitrun extends Cubit<cubitState> {
  Cubitrun() : super(TshirtChange());
  String imageChose = "";
  bool state1 = false;
  bool state2 = false;
  bool state3 = false;
  bool M_size = false;
  bool X_size2 = false;
  bool XL_size = false;
  int sizeIncreament = 1;

  String imageGalary = "";
  bool IsBooked = false;
  bool isPasswordValid = false;
  void changeImage(String x) {
    imageChose = x;
    emit(TshirtChange());
  }

  bool getStateByIndex(int index) {
    switch (index) {
      case 1:
        return state1;
      case 2:
        return state2;
      case 3:
        return state3;
      default:
        return false;
    }
  }

  void DetailsBookButton() {
    IsBooked = !IsBooked;
    emit(BookedState());
  }

  void changeContainerColor(int index) {
    state1 = index == 1;
    state2 = index == 2;
    state3 = index == 3;

    emit(UpdateContainerImageColor());
  }

  void setPasswordValidation(bool isValid) {
    isPasswordValid = isValid;
    emit(PasswordValidationState());
  }

  void Changeimages() {}

  void cartIncrement(bool isIncrement) {
    if (isIncrement) {
      if (sizeIncreament < 9) {
        sizeIncreament++;
        emit(CartIncrement());
      }
    } else {
      if (sizeIncreament > 1) {
        sizeIncreament--;
        emit(CartIncrement());
      }
    }
  }
}
