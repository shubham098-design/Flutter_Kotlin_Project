package com.example.ecommerceappinjetpackcompose.domain.model

import kotlinx.serialization.Serializable

@Serializable
data class ProductDataModels(
    val name: String = "",
    val description: String = "",
    val image: String = "",
    val price: String = "",
    val finalPrice: String = "",
    val availableUnits: String = "",
    var productId: String = "",
    var category: String = "",
)
