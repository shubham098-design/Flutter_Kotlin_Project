package com.example.ecommerceappinjetpackcompose.domain.usecase

import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.model.UserData
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class LoginUserUseCase @Inject constructor(private val repo: Repo)  {

    fun loginUserUseCase(userData: UserData) : Flow<ResultState<String>>{
        return repo.loginUserEmailAndPassword(userData)
    }
}