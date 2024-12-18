import 'package:equatable/equatable.dart';

abstract class CategoryBaseState extends Equatable {
  final List<String> category;
  const CategoryBaseState(this.category);

  @override
  // TODO: implement props
  List<Object?> get props => [...category, DateTime.now()];
}

class CategoryInitialState extends CategoryBaseState {
  const CategoryInitialState(super.category);
}

class CategorySoftLoadingState extends CategoryBaseState {
  const CategorySoftLoadingState(super.category);
}

class CategoryLoadingState extends CategoryBaseState {
  const CategoryLoadingState(super.category);
}

class CategoryLoadedState extends CategoryBaseState {
  const CategoryLoadedState(super.category);
}

class CategoryErrorState extends CategoryBaseState {
  final String message;
  const CategoryErrorState(super.category, this.message);
  @override
  // TODO: implement props
  List<Object?> get props => [...category, DateTime.now(), message];
}
