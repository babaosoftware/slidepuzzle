import 'package:flutter_bloc/flutter_bloc.dart';

class AutoPlayCubit extends Cubit<bool> {
  AutoPlayCubit() : super(false);
  void flip() => emit(!state);
}

final autoPlayCubit = AutoPlayCubit();
