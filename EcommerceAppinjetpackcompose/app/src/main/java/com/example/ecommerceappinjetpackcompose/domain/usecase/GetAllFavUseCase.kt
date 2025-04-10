package com.example.ecommerceappinjetpackcompose.domain.usecase

import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.model.ProductDataModels
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class GetAllFavUseCase @Inject constructor(private val repo: Repo) {
    fun getAllFav() : Flow<ResultState<List<ProductDataModels>>>{
        return repo.getAllFav()
    }
}