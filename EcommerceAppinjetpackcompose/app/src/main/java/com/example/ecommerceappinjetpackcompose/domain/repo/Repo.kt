package com.example.ecommerceappinjetpackcompose.domain.repo

import android.net.Uri
import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.model.BannerDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.CartDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.CategoryDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.ProductDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.UserData
import com.example.ecommerceappinjetpackcompose.domain.model.UserDataParent
import kotlinx.coroutines.flow.Flow

interface Repo {

    fun registerUserEmailAndPassword(userData: UserData) : Flow<ResultState<String>>
    fun loginUserEmailAndPassword(userData: UserData) : Flow<ResultState<String>>
    fun getUserById(uid : String) : Flow<ResultState<UserDataParent>>
    fun updateUserData(userDataParent: UserDataParent) : Flow<ResultState<String>>
    fun userProfileImage(uri: Uri) : Flow<ResultState<String>>
    fun getCategoriesInLimited() : Flow<ResultState<List<CategoryDataModels>>>
    fun getProductsInLimited() : Flow<ResultState<List<ProductDataModels>>>
    fun getAllProducts() : Flow<ResultState<List<ProductDataModels>>>
    fun getProductById(productId : String) : Flow<ResultState<ProductDataModels>>
    fun addToCart(cartDataModels: CartDataModels) : Flow<ResultState<String>>
    fun addToFav(cartDataModels: ProductDataModels) : Flow<ResultState<String>>
    fun getAllFav() : Flow<ResultState<List<ProductDataModels>>>
    fun getCart() : Flow<ResultState<List<CartDataModels>>>
    fun getAllCategories() : Flow<ResultState<List<CategoryDataModels>>>
    fun getCheckout(productId : String) : Flow<ResultState<ProductDataModels>>
    fun getBanner() : Flow<ResultState<List<BannerDataModels>>>
    fun getSpecificCategoryItems(categoryName : String) : Flow<ResultState<List<ProductDataModels>>>
    fun getAllSuggestedProducts() : Flow<ResultState<List<ProductDataModels>>>
}