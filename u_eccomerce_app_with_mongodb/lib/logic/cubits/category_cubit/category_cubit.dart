

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_eccomerce_app_with_mongodb/logic/cubits/category_cubit/category_state.dart';

import '../../../data/model/category/category_model.dart';
import '../../../data/repository/category_repository.dart';

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit() : super(CategoryIntitialState()){
    _initialize();
  }
  final _categoryRepository = CategoryRepository();

  void _initialize() async{
    emit(CategoryLoadingState(state.categories));
    try{
      List<CategoryModel> categories = await _categoryRepository.fetchAllCategories();
      emit(CategoryLoadedState(categories));
    }catch(ex){
      emit(CategoryErrorState(ex.toString(), state.categories));
    }
  }
}