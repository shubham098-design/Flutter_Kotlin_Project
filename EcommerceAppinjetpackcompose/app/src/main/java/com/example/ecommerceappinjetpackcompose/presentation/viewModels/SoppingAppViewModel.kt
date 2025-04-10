package com.example.ecommerceappinjetpackcompose.presentation.viewModels

import android.net.Uri
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.domain.model.BannerDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.CartDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.CategoryDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.ProductDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.UserData
import com.example.ecommerceappinjetpackcompose.domain.model.UserDataParent
import com.example.ecommerceappinjetpackcompose.domain.usecase.AddToCartUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.AddToFavUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.CreateUserUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetAllCategoryUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetAllFavUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetAllProductUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetAllSuggestedProductUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetBannerUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetCartUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetCategoryInLimitUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetCheckoutUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetProductById
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetProductsInLimitUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetSpecificCategoryItems
import com.example.ecommerceappinjetpackcompose.domain.usecase.GetUserUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.LoginUserUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.UpdateUserDataUseCase
import com.example.ecommerceappinjetpackcompose.domain.usecase.UserProfileImageUseCase
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.collectLatest
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class SoppingAppViewModel @Inject constructor(
    private val createUserUseCase: CreateUserUseCase,
    private val loginUseCase: LoginUserUseCase,
    private val getUserUseCase: GetUserUseCase,
    private val updateUserDataUseCase: UpdateUserDataUseCase,
    private val userProfileImageUseCase: UserProfileImageUseCase,
    private val getCategoriesInLimitedUseCase: GetCategoryInLimitUseCase,
    private val getProductsInLimitedUseCase: GetProductsInLimitUseCase,
    private val getAllProductsUseCase: GetAllProductUseCase,
    private val getProductByIdUseCase: GetProductById,
    private val addToCartUseCase: AddToCartUseCase,
    private val addToFavUseCase: AddToFavUseCase,
    private val getAllFavUseCase: GetAllFavUseCase,
    private val getCartUseCase: GetCartUseCase,
    private val getAllCategoriesUseCase: GetAllCategoryUseCase,
    private val getCheckoutUseCase: GetCheckoutUseCase,
    private val getSpecificCategoryItemsUseCase: GetSpecificCategoryItems,
    private val getAllSuggestedProductsUseCase: GetAllSuggestedProductUseCase,
    private val getBannerUseCase: GetBannerUseCase


) : ViewModel() {

    private val _signUpScreenState = MutableStateFlow(SignUpScreenState())
    val signUpScreenState = _signUpScreenState.asStateFlow()

    private val _loginScreenState = MutableStateFlow(LoginScreenState())
    val loginScreenState = _loginScreenState.asStateFlow()

    private val _profileScreenState = MutableStateFlow(ProfileScreenState())
    val profileScreenState = _profileScreenState.asStateFlow()

    private val _updateScreenState = MutableStateFlow(UpdateScreenState())
    val updateScreenState = _updateScreenState.asStateFlow()

    private val _uploadUserProfileImageScreenState = MutableStateFlow(UploadUserProfileImageScreenState())
    val uploadUserProfileImageScreenState = _uploadUserProfileImageScreenState.asStateFlow()

    private val _addToCartScreenState = MutableStateFlow(AddToCartScreenState())
    val addToCartScreenState = _addToCartScreenState.asStateFlow()

    private val _getProductByIdScreenState = MutableStateFlow(GetProductByIdScreenState())
    val getProductByIdScreenState = _getProductByIdScreenState.asStateFlow()

    private val _addToFavScreenState = MutableStateFlow(AddToFavScreenState())
    val addToFavScreenState = _addToFavScreenState.asStateFlow()

    private val _getAllFavScreenState = MutableStateFlow(GetAllFavScreenState())
    val getFavScreenState = _getAllFavScreenState.asStateFlow()

    private val _getCartScreenState = MutableStateFlow(GetCartScreenState())
    val getCartScreenState = _getCartScreenState.asStateFlow()

    private val _getAllCategoriesScreenState = MutableStateFlow(GetAllCategoriesScreenState())
    val getAllCategoriesScreenState = _getAllCategoriesScreenState.asStateFlow()

    private val _getCheckoutScreenState = MutableStateFlow(GetCheckoutScreenState())
    val getCheckoutScreenState = _getCheckoutScreenState.asStateFlow()

    private val _getSpecificCategoryItemsScreenState = MutableStateFlow(GetSpecificCategoryItemsScreenState())
    val getSpecificCategoryItemsScreenState = _getSpecificCategoryItemsScreenState.asStateFlow()

    private val _getAllSuggestedProductsScreenState = MutableStateFlow(GetAllSuggestedProductsScreenState())
    val getAllSuggestedProductsScreenState = _getAllSuggestedProductsScreenState.asStateFlow()

    private val _getAllProductsScreenState = MutableStateFlow(GetAllProductsScreenState())
    val getAllProductsScreenState = _getAllProductsScreenState.asStateFlow()

    private val _getBannerScreenState = MutableStateFlow(GetBannerScreenState())
    val getBannerScreenState = _getBannerScreenState.asStateFlow()

    private val _homeScreenState = MutableStateFlow(HomeScreenScreenState())
    val homeScreenState = _homeScreenState.asStateFlow()

    fun getSpecificCategoryItem(categoryName : String) {
        viewModelScope.launch {
            getSpecificCategoryItemsUseCase.getSpecificCategoryItems(categoryName).collect {
                when(it){
                    is ResultState.Error -> {
                        _getSpecificCategoryItemsScreenState.value = _getSpecificCategoryItemsScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }

                    is ResultState.Loading -> {
                        _getSpecificCategoryItemsScreenState.value = _getSpecificCategoryItemsScreenState.value.copy(
                            isLoading = true
                        )
                    }

                    is ResultState.Success -> {
                        _getSpecificCategoryItemsScreenState.value = _getSpecificCategoryItemsScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }
                }
            }
        }
    }

    fun getCheckout(productId : String) {
        viewModelScope.launch {
            getCheckoutUseCase.getCheckoutUseCase(productId).collect {
                when(it){
                    is ResultState.Error -> {
                        _getCheckoutScreenState.value = _getCheckoutScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }

                    is ResultState.Loading -> {
                        _getCheckoutScreenState.value = _getCheckoutScreenState.value.copy(
                            isLoading = true
                        )
                    }

                    is ResultState.Success -> {
                        _getCheckoutScreenState.value = _getCheckoutScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }

                }
            }
        }
    }

    fun getAllCategories() {
        viewModelScope.launch {
            getAllCategoriesUseCase.getAllCategory().collect {
                when (it) {
                    is ResultState.Error -> {
                        _getAllCategoriesScreenState.value =
                            _getAllCategoriesScreenState.value.copy(
                                isLoading = false,
                                errorMessage = it.message
                            )
                    }

                    is ResultState.Loading -> {
                        _getAllCategoriesScreenState.value =
                            _getAllCategoriesScreenState.value.copy(
                                isLoading = true
                            )
                    }

                    is ResultState.Success -> {
                        _getAllCategoriesScreenState.value =
                            _getAllCategoriesScreenState.value.copy(
                                isLoading = false,
                            )
                    }
                }
            }
        }
    }

    fun getCart(){
        viewModelScope.launch {
            getCartUseCase.getCartUseCase().collectLatest {
                when(it){
                    is ResultState.Error -> {
                        _getCartScreenState.value = _getCartScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }

                    is ResultState.Loading -> {
                        _getCartScreenState.value = _getCartScreenState.value.copy(
                            isLoading = true
                        )
                    }

                    is ResultState.Success -> {
                        _getCartScreenState.value = _getCartScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }
                }
            }
        }
    }

    fun getAllProducts() {
        viewModelScope.launch {
            getAllProductsUseCase.getAllProduct().collect {
                when(it){
                    is ResultState.Error -> {
                        _getAllProductsScreenState.value = _getAllProductsScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }

                    is ResultState.Loading -> {
                        _getAllProductsScreenState.value = _getAllProductsScreenState.value.copy(
                            isLoading = true
                        )
                    }

                    is ResultState.Success -> {
                        _getAllProductsScreenState.value = _getAllProductsScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }

                }
            }
        }
    }

    fun getAllFav(){
        viewModelScope.launch {
            getAllFavUseCase.getAllFav().collectLatest {
                when(it){
                    is ResultState.Error -> {
                        _getAllFavScreenState.value = _getAllFavScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }

                    is ResultState.Loading -> {
                        _getAllFavScreenState.value = _getAllFavScreenState.value.copy(
                            isLoading = true
                        )
                    }

                    is ResultState.Success -> {
                        _getAllFavScreenState.value = _getAllFavScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }
                }
            }
        }
    }

    fun addToFav(productDataModels: ProductDataModels) {
        viewModelScope.launch {
            addToFavUseCase.addToFav(productDataModels).collectLatest {
                when (it) {
                    is ResultState.Error -> {
                        _addToFavScreenState.value = _addToFavScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }

                    is ResultState.Loading -> {
                        _addToFavScreenState.value = _addToFavScreenState.value.copy(
                            isLoading = true
                        )
                    }

                    is ResultState.Success -> {
                        _addToFavScreenState.value = _addToFavScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }
                }
            }
        }
    }

    fun getProductById(productId : String) {
        viewModelScope.launch {
            getProductByIdUseCase.getProductId(productId).collectLatest {
                when(it){
                    is ResultState.Error -> {
                        _getProductByIdScreenState.value = _getProductByIdScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }
                    is ResultState.Loading -> {
                        _getProductByIdScreenState.value = _getProductByIdScreenState.value.copy(
                            isLoading = true
                        )
                    }
                    is ResultState.Success -> {
                        _getProductByIdScreenState.value = _getProductByIdScreenState.value.copy(
                            isLoading = false,
                            product = it.data
                        )
                    }
                }
            }
        }
    }

    fun addToCart(cartDataModels: CartDataModels) {
        viewModelScope.launch {
            addToCartUseCase.addToCart(cartDataModels).collectLatest {
                when(it){
                    is ResultState.Error -> {
                        _addToCartScreenState.value = _addToCartScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }
                    is ResultState.Loading -> {
                        _addToCartScreenState.value = _addToCartScreenState.value.copy(
                            isLoading = true
                        )
                    }
                    is ResultState.Success -> {
                        _addToCartScreenState.value = _addToCartScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }
                }
            }
        }
    }

    init {
        loadingHomeScreenData()
    }

    fun loadingHomeScreenData(){
        viewModelScope.launch {
            combine(
                getCategoriesInLimitedUseCase.getCategoryInLimitUseCase(),
                getProductsInLimitedUseCase.getProductsInLimit(),
                getBannerUseCase.getBannerUseCase()
            ){ category, product, banner ->
                when{
                    category is ResultState.Error -> {
                        HomeScreenScreenState(
                            isLoading = false,
                            errorMessage = category.message
                        )
                    }
                    product is ResultState.Error -> {
                        HomeScreenScreenState(
                            isLoading = false,
                            errorMessage = product.message
                        )
                    }
                    banner is ResultState.Error -> {
                        HomeScreenScreenState(
                            isLoading = false,
                            errorMessage = banner.message
                        )
                    }

                    category is ResultState.Success && product is ResultState.Success && banner is ResultState.Success -> {
                        HomeScreenScreenState(
                            isLoading = false,
                            categories = category.data,
                            products = product.data,
                            banner = banner.data
                        )
                    }
                    else -> {
                        HomeScreenScreenState(
                            isLoading = true
                        )
                    }
                }
            }.collect{
                state -> _homeScreenState.value = state
            }
        }
    }


    fun upLoadUserProfileImage(uri: Uri){
        viewModelScope.launch {
            userProfileImageUseCase.userProfileImageUseCase(uri).collectLatest {
                when(it){
                    is ResultState.Error -> {
                        _uploadUserProfileImageScreenState.value =
                            _uploadUserProfileImageScreenState.value.copy(
                                isLoading = false,
                                errorMessage = it.message
                            )
                    }
                    is ResultState.Loading -> {
                        _uploadUserProfileImageScreenState.value =
                            _uploadUserProfileImageScreenState.value.copy(
                                isLoading = true
                            )
                    }
                    is ResultState.Success -> {
                        _uploadUserProfileImageScreenState.value =
                            _uploadUserProfileImageScreenState.value.copy(
                                isLoading = false,
                                imageUrl = it.data
                            )
                    }

                }
            }
        }
    }

    fun upDateUserData(userDataParent: UserDataParent) {
        viewModelScope.launch {
            updateUserDataUseCase.updateUserDataUseCase(userDataParent).collectLatest {
                when(it){
                    is ResultState.Error -> {
                        _updateScreenState.value = _updateScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }
                    is ResultState.Loading -> {
                        _updateScreenState.value = _updateScreenState.value.copy(
                            isLoading = true
                        )
                    }
                    is ResultState.Success -> {
                        _updateScreenState.value = _updateScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }
                }
            }
        }
    }

    fun createUser(userData: UserData){
        viewModelScope.launch {
            createUserUseCase.createUser(userData).collectLatest {
                when(it){
                    is ResultState.Error -> {
                        _signUpScreenState.value = _signUpScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }
                    is ResultState.Loading -> {
                        _signUpScreenState.value = _signUpScreenState.value.copy(
                            isLoading = true
                        )
                    }
                    is ResultState.Success -> {
                        _signUpScreenState.value = _signUpScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }
                }
            }
        }
    }

    fun loginUser(userData: UserData){
        viewModelScope.launch {
            loginUseCase.loginUserUseCase(userData).collectLatest {
                when (it) {
                    is ResultState.Error -> {
                        _loginScreenState.value = _loginScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }

                    is ResultState.Loading -> {
                        _loginScreenState.value = _loginScreenState.value.copy(
                            isLoading = true
                        )
                    }

                    is ResultState.Success -> {
                        _loginScreenState.value = _loginScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }
                }
            }
        }
    }

    fun getUserById(uid : String){
        viewModelScope.launch {
            getUserUseCase.getUserById(uid).collectLatest {
                when (it) {
                    is ResultState.Error -> {
                        _profileScreenState.value = _profileScreenState.value.copy(
                            isLoading = false,
                            errorMessage = it.message
                        )
                    }

                    is ResultState.Loading -> {
                        _profileScreenState.value = _profileScreenState.value.copy(
                            isLoading = true
                        )
                    }

                    is ResultState.Success -> {
                        _profileScreenState.value = _profileScreenState.value.copy(
                            isLoading = false,
                            userData = it.data
                        )
                    }
                }
            }
        }
    }

    fun getAllSuggestedProducts(){
        viewModelScope.launch {
            getAllSuggestedProductsUseCase.getAllSuggestedProduct().collectLatest {
                when(it){
                    is ResultState.Error -> {
                        _getAllSuggestedProductsScreenState.value =
                            _getAllSuggestedProductsScreenState.value.copy(
                                isLoading = false,
                                errorMessage = it.message
                            )
                    }
                    is ResultState.Loading -> {
                        _getAllSuggestedProductsScreenState.value =
                            _getAllSuggestedProductsScreenState.value.copy(
                                isLoading = true
                            )
                    }
                    is ResultState.Success -> {
                        _getAllSuggestedProductsScreenState.value =
                            _getAllSuggestedProductsScreenState.value.copy(
                                isLoading = false,
                                userData = it.data
                            )
                    }
                }
            }
        }
    }
}

data class ProfileScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: UserDataParent? = null
)

data class SignUpScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: String? = null
)

data class LoginScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: String? = null
)

data class UpdateScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: String? = null
)

data class UploadUserProfileImageScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val imageUrl: String? = null
)

data class AddToCartScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: String? = null
)

data class GetProductByIdScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val product: ProductDataModels? = null
)

data class AddToFavScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: String? = null
)

data class GetAllFavScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: List<ProductDataModels?> = emptyList()
)

data class GetAllProductsScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: List<ProductDataModels?> = emptyList()
)

data class GetCartScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: List<CartDataModels?> = emptyList()
)

data class GetAllCategoriesScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: List<CategoryDataModels?> = emptyList()
)

data class GetCheckoutScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: ProductDataModels? = null
)

data class GetSpecificCategoryItemsScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: List<ProductDataModels?> = emptyList()
)

data class GetAllSuggestedProductsScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: List<ProductDataModels?> = emptyList()
)

data class GetBannerScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val userData: List<BannerDataModels?> = emptyList()
)

data class HomeScreenScreenState(
    val isLoading: Boolean = false,
    val errorMessage: String? = null,
    val categories: List<CategoryDataModels?> = emptyList(),
    val products: List<ProductDataModels?> = emptyList(),
    val banner: List<BannerDataModels?> = emptyList()
)

