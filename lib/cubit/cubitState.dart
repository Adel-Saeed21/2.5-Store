// ignore_for_file: camel_case_types, file_names

import 'dart:io';

abstract class cubitState {}

class TshirtChange extends cubitState {}
class TshirtSize extends cubitState{}
class BookedState extends cubitState{}
class UpdateContainerImageColor extends cubitState{}
class ButtonColor extends cubitState {}
class ImageInitial extends cubitState {}
class PasswordValidationState extends cubitState{}
class ImageLoaded extends cubitState {
  final File image;
  ImageLoaded(this.image);
}

class ImageError extends cubitState {
  final String message;
  ImageError(this.message);
}

