package com.example.ecommerceappinjetpackcompose.domain.usecase

import android.service.autofill.UserData
import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.model.UserDataParent
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class UpdateUserDataUseCase @Inject constructor(private val repo: Repo)  {

    fun updateUserDataUseCase(userDataParent: UserDataParent) : Flow<ResultState<String>>{
        return repo.updateUserData(userDataParent)
    }
}