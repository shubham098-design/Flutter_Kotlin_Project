package com.tech.mymedicalshopuser.ui_layer.screens.cart

import android.util.Log
import android.widget.Toast
import androidx.activity.compose.BackHandler
import androidx.compose.animation.AnimatedContent
import androidx.compose.animation.AnimatedVisibility
import androidx.compose.animation.SizeTransform
import androidx.compose.animation.fadeIn
import androidx.compose.animation.fadeOut
import androidx.compose.animation.slideInVertically
import androidx.compose.animation.slideOutVertically
import androidx.compose.animation.togetherWith
import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.interaction.MutableInteractionSource
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.KeyboardArrowLeft
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import com.airbnb.lottie.compose.LottieAnimation
import com.airbnb.lottie.compose.LottieCompositionSpec
import com.airbnb.lottie.compose.LottieConstants
import com.airbnb.lottie.compose.animateLottieCompositionAsState
import com.airbnb.lottie.compose.rememberLottieComposition
import com.tech.mymedicalshopuser.R
import com.tech.mymedicalshopuser.local.viewmodel.RoomCartViewModel
import com.tech.mymedicalshopuser.ui.theme.GreenColor
import com.tech.mymedicalshopuser.ui.theme.WhiteGreyColor
import com.tech.mymedicalshopuser.ui_layer.animation.AnimatedContentComponent
import com.tech.mymedicalshopuser.ui_layer.bottomNavigation.NavigationView
import com.tech.mymedicalshopuser.ui_layer.navigation.CartScreenRoute
import com.tech.mymedicalshopuser.ui_layer.navigation.CreateOrderScreenRoute
import com.tech.mymedicalshopuser.ui_layer.navigation.HomeScreenRoute
import com.tech.mymedicalshopuser.ui_layer.navigation.ProductDetailScreenRoute
import com.tech.mymedicalshopuser.utils.calculateDeliveryCharge
import com.tech.mymedicalshopuser.utils.calculateDiscount
import com.tech.mymedicalshopuser.utils.calculateTaxCharge
import com.tech.mymedicalshopuser.utils.totalPriceCalculate
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

@Composable
fun CartScreen(
    navController: NavHostController,
    roomCartViewmodel: RoomCartViewModel
) {
    var selectedItem by remember {
        mutableIntStateOf(2)
    }
    val cartList by roomCartViewmodel.cartList.collectAsState()
    val subTotalPrice by roomCartViewmodel.subTotalPrice.collectAsState()
    val context = LocalContext.current

    BackHandler {
        navController.navigate(HomeScreenRoute) {
            navController.graph.startDestinationRoute?.let { homeScreen ->
                popUpTo(homeScreen) {
                    saveState = true
                }
                restoreState = true
                launchSingleTop = true
                navController.popBackStack(
                    CartScreenRoute,
                    inclusive = true
                ) // Clear back stack and go to Screen1
            }
        }
    }
    Box(
        modifier = Modifier
            .padding()
            .fillMaxSize()
            .background(WhiteGreyColor),
        contentAlignment = Alignment.BottomCenter
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.White),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Top
        ) {
            Column(modifier = Modifier.fillMaxWidth()) {

                val previousRoute =
                    navController.previousBackStackEntry?.destination?.route

                Log.d("@prev", "CartScreen: $previousRoute")
                //when route comes from product detail screen then go for it other no need back button
                CartTopBar(
                    headerName = "Cart",
                    isBackButtonShow = previousRoute != null,
                    onClick = {
                        navController.navigateUp()
                    }
                )
            }
            Spacer(Modifier.height(8.dp))
            if (cartList.isNotEmpty()) {
                LazyColumn(
                    modifier = Modifier
                        .padding(8.dp)
                        .fillMaxWidth()
                        .height(450.dp)
                ) {
                    items(cartList) { product ->
                            CartItem(
                                count = product.product_count,
                                productItem = product,
                                itemOnClick = {
                                    navController.navigate(
                                        ProductDetailScreenRoute(
                                            productName = product.product_name,
                                            productImageId = product.product_image_id,
                                            productPrice = product.product_price,
                                            productRating = product.product_rating,
                                            productStock = product.product_stock,
                                            productDescription = product.product_description,
                                            productPower = product.product_power,
                                            productCategory = product.product_category,
                                            productExpiryDate = product.product_expiry_date,
                                            productId = product.product_id
                                        )
                                    )
                                }, onDelete = {
                                    roomCartViewmodel.deleteCartById(product.product_id)
                                }, increaseItem = {
                                    Log.d("@stock", "CartScreen: ${product.product_count}")
                                    Log.d("@stock", "CartScreen: ${product.product_stock}")
                                    if(product.product_stock > product.product_count){
                                        roomCartViewmodel.updateCartList(
                                            product.product_id,
                                            product.product_count + 1
                                        )
                                    }else{
                                        Toast.makeText(context, "Product Stock Limit Reached ${product.product_stock}", Toast.LENGTH_SHORT).show()
                                    }

                                }, decreaseItem = {
                                    if (product.product_count > 1)
                                        roomCartViewmodel.updateCartList(
                                            product.product_id,
                                            product.product_count - 1
                                        )
                                }
                            )
                    }
                }
            } else {
                val preloaderLottieComposition = rememberLottieComposition(
                    spec = LottieCompositionSpec.RawRes(
                        R.raw.empty_cart_lottie
                    )
                )

                val preloaderProgress = animateLottieCompositionAsState(
                    composition = preloaderLottieComposition.value,
                    iterations = LottieConstants.IterateForever,
                    isPlaying = true
                )
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    LottieAnimation(
                        composition = preloaderLottieComposition.value,
                        progress = preloaderProgress.value,
                        modifier = Modifier.fillMaxSize()
                    )
                }
            }

        }

        if (cartList.isNotEmpty()) {
            CartPriceCard(
                subTotalPrice
            ) {
                val itemCartListJson = Json.encodeToString(cartList.toList())
                navController.navigate(
                    CreateOrderScreenRoute(
                        cartList = itemCartListJson,
                        subTotalPrice = subTotalPrice
                    )
                )
            }
        }
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.BottomEnd) {
            NavigationView(
                navController,
                selectedItem = selectedItem,
                onSelectedItem = {
                    selectedItem = it
                }
            )
        }

    }

}

@Composable
fun CartPriceCard(
    subTotalPrice: Float,
    checkOutClick: () -> Unit
) {
    Card(
        modifier = Modifier
            .padding(top = 5.dp, start = 5.dp, end = 5.dp, bottom = 70.dp)
            .fillMaxWidth()
            .height(220.dp)
            .background(Color.White, shape = RoundedCornerShape(8.dp)),
        elevation = CardDefaults.cardElevation(4.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .background(WhiteGreyColor)
                .padding(20.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.SpaceBetween
        ) {
            val totalPrice = totalPriceCalculate(subTotalPrice)

            TextRow(priceName = "Sub-Total", price = subTotalPrice.toString())
            TextRow(
                priceName = "Delivery Charge",
                price = if (calculateDeliveryCharge(subTotalPrice) > 0) calculateDeliveryCharge(
                    subTotalPrice
                ).toString() else "Free"
            )
            TextRow(
                priceName = "Tax Charge 18%",
                price = calculateTaxCharge(subTotalPrice).toString()
            )
            TextRow(priceName = "Discount 5%", price = calculateDiscount(subTotalPrice).toString())

            Spacer(modifier = Modifier.height(10.dp))

            HorizontalDivider()
            Spacer(modifier = Modifier.height(10.dp))

            TextRow(priceName = "Total Price", price = totalPrice.toString())

            Spacer(modifier = Modifier.height(10.dp))
            CheckoutButton {
                checkOutClick()
            }
        }
    }
}

@Composable
fun CheckoutButton(
    onClick: () -> Unit
) {

    Row(
        modifier = Modifier.fillMaxWidth(),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.Center
    ) {
        Button(
            onClick = {
                onClick()
            },
            colors = ButtonDefaults.buttonColors(
                containerColor = GreenColor,
                contentColor = Color.White
            ),
            modifier = Modifier.fillMaxWidth(),
            elevation = ButtonDefaults.buttonElevation(4.dp)

        ) {
            Text(
                text = "Checkout", style = TextStyle(
                    color = Color.White,
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Medium,
                    fontFamily = FontFamily(Font(R.font.roboto_medium))
                )
            )
        }
    }

}

@Composable
fun TextRow(priceName: String, price: String) {
    Row(
        modifier = Modifier.fillMaxWidth(),
        horizontalArrangement = Arrangement.SpaceBetween,
        verticalAlignment = Alignment.CenterVertically
    ) {
        Text(
            text = priceName, style = TextStyle(
                fontSize = 18.sp,
                fontFamily = FontFamily(Font(R.font.roboto_regular)),
                color = Color.Black
            )
        )

        AnimatedContentComponent(
            targetState = price,
        ) { targetPrice ->
            Text(
                text = stringResource(R.string.cart_rs, targetPrice), style = TextStyle(
                    fontSize = 18.sp,
                    fontFamily = FontFamily(Font(R.font.roboto_bold)),
                    color = GreenColor
                )
            )
        }
    }
}

@Composable
fun CartTopBar(
    headerName: String,
    isBackButtonShow: Boolean,
    onClick: () -> Unit = {}
) {

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .background(
                GreenColor,
                shape = RoundedCornerShape(bottomStart = 32.dp, bottomEnd = 32.dp)
            )
    ) {

        Column(
            modifier = Modifier
                .padding(start = 16.dp, end = 16.dp, bottom = 16.dp)
                .fillMaxWidth()
                .background(
                    GreenColor
                )
                .padding(top = 8.dp),
            horizontalAlignment = Alignment.Start,
            verticalArrangement = Arrangement.Center
        ) {
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.Start,
                verticalAlignment = Alignment.CenterVertically
            ) {
                if (isBackButtonShow) {
                    Icon(
                        imageVector = Icons.AutoMirrored.Filled.KeyboardArrowLeft,
                        contentDescription = null,
                        tint = Color.White,
                        modifier = Modifier
                            .size(36.dp)
                            .clickable(
                                interactionSource = remember { MutableInteractionSource() },
                                indication = null
                            ) {
                                onClick()
                            }
                    )
                    Spacer(Modifier.width(8.dp))
                }
                Text(
                    text = headerName, style = TextStyle(
                        color = Color.White,
                        fontSize = 24.sp,
                        fontWeight = FontWeight.Bold,
                        fontFamily = FontFamily(Font(R.font.roboto_bold))
                    )
                )
            }
        }
    }
}

