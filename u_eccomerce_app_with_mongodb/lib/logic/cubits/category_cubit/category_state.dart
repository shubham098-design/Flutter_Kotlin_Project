import 'package:u_eccomerce_app_with_mongodb/data/model/category/category_model.dart';

abstract class CategoryState{

  final List<CategoryModel> categories;
  CategoryState(this.categories);
}

class CategoryIntitialState extends CategoryState{
  CategoryIntitialState() : super([]);
}

class CategoryLoadingState extends CategoryState{
  CategoryLoadingState(super.categories);
}

class CategoryErrorState extends CategoryState{
  final String message;
  CategoryErrorState(this.message, super.categories);
}

class CategoryLoadedState extends CategoryState{
  CategoryLoadedState(super.categories);
}

