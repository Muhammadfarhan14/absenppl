part of 'camera_cubit.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object> get props => [];
}

class CameraInitial extends CameraState {}

class CameraLoading extends CameraState {}

class CameraReady extends CameraState {
  final CameraController controller;

  const CameraReady(this.controller);

  @override
  List<Object> get props => [controller];
}

class CameraTakePicture extends CameraState {
  final String imagePath;

  const CameraTakePicture(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

class CameraError extends CameraState {
  final String message;

  const CameraError(this.message);

  @override
  List<Object> get props => [message];
}
