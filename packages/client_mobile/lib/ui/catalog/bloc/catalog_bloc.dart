import 'package:shared/imports.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';
part 'catalog_bloc.freezed.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(const CatalogState.initial()) {
    on<CatalogEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
