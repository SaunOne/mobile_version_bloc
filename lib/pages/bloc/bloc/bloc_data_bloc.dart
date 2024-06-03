import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bloc_data_event.dart';
part 'bloc_data_state.dart';

class BlocDataBloc extends Bloc<BlocDataEvent, BlocDataState> {
  BlocDataBloc() : super(BlocDataInitial()) {
    on<BlocDataEvent>((event, emit) {
        
    });
  }
}
