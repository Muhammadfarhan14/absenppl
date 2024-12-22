import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(CameraInitial());

  late CameraController _controller;

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;

      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );

      await _controller.initialize();

      emit(CameraReady(_controller));
    } catch (e) {
      emit(CameraError(e.toString()));
    }
  }

  void takePicture() async {
    try {
      final image = await _controller.takePicture();

      emit(CameraTakePicture(image.path));
    } catch (e) {
      emit(CameraError(e.toString()));
    }
  }
}
