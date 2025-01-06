import 'dart:io';

abstract class cubitState {}

class TshirtChange extends cubitState {}

class UpdateContainerColor extends cubitState{}
class ButtonColor extends cubitState {}
class ImageInitial extends cubitState {}

class ImageLoaded extends cubitState {
  final File image;
  ImageLoaded(this.image);
}

class ImageError extends cubitState {
  final String message;
  ImageError(this.message);
}