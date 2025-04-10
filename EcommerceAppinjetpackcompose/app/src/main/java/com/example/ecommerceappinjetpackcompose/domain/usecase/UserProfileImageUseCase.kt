package com.example.ecommerceappinjetpackcompose.domain.usecase

import android.net.Uri
import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import kotlinx.coroutines.flow.Flow
import javax.inject.Inject

class UserProfileImageUseCase @Inject constructor(private  val repo : Repo) {
    fun userProfileImageUseCase(uri : Uri) : Flow<ResultState<String>>{
        return repo.userProfileImage(uri)

    }
}