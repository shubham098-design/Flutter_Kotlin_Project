package com.example.ecommerceappinjetpackcompose.domain.usecase

import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.model.CartDataModels
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class GetCartUseCase @Inject constructor(private val repo: Repo)  {

    fun getCartUseCase() : Flow<ResultState<List<CartDataModels>>>{
        return repo.getCart()

    }
}