package com.example.ecommerceappinjetpackcompose.domain.usecase

import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.model.BannerDataModels
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class GetBannerUseCase @Inject constructor(private val repo: Repo)  {
    fun getBannerUseCase() : Flow<ResultState<List<BannerDataModels>>>{
        return repo.getBanner()
    }
}