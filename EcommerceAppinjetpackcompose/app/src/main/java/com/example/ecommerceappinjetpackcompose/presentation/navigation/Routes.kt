package com.example.ecommerceappinjetpackcompose.presentation.navigation

import kotlinx.serialization.Serializable


sealed class SubNavigation {

    @Serializable
    object LoginSignupScreen : SubNavigation()

    @Serializable
    object MainHomeScreen : SubNavigation()
}

sealed class Route{

    @Serializable
    object LoginScreen

    @Serializable
    object SignUpScreen

    @Serializable
    object HomeScreen

    @Serializable
    object SplashScreen

    @Serializable
    object WishlistScreen

    @Serializable
    object CartScreen

    @Serializable
    object ProfileScreen

    @Serializable
    data class CheckoutScreen(val productId: String)

    @Serializable
    object PayScreen

    @Serializable
    object SeeAllProductScreen

    @Serializable
    data class EachProductDetailScreen(val productId: String)

    @Serializable
    object AllCategoriesScreen

    @Serializable
    data class EachCategoryItemScreen(val categoryName: String)

}