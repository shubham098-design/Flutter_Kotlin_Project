package com.example.ecommerceappinjetpackcompose.common

import com.example.ecommerceappinjetpackcompose.domain.model.BannerDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.CategoryDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.ProductDataModels

data class HomeScreenState(
    val isLoading: Boolean = true,
    val errorMessage : String? = null,
    val categories : List<CategoryDataModels>? = null,
    val products : List<ProductDataModels>? = null,
    val banner : List<BannerDataModels>? = null

)