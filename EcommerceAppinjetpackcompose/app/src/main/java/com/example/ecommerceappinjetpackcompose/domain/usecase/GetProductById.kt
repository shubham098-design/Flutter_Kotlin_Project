package com.example.ecommerceappinjetpackcompose.domain.usecase

import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.model.ProductDataModels
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class GetProductById @Inject constructor(private val repo: Repo)  {

    fun getProductId(productId : String) : Flow<ResultState<ProductDataModels>>{
        return repo.getProductById(productId)
    }
}