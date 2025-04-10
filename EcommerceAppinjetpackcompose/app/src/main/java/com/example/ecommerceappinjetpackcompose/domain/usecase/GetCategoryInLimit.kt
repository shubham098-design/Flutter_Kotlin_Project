package com.example.ecommerceappinjetpackcompose.domain.usecase

import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.model.CategoryDataModels
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class GetCategoryInLimitUseCase @Inject constructor(private val repo: Repo)  {

    fun getCategoryInLimitUseCase() : Flow<ResultState<List<CategoryDataModels>>> {
        return repo.getCategoriesInLimited()
    }
}