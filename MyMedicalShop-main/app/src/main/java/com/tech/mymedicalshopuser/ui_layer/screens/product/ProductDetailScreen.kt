package com.tech.mymedicalshopuser.ui_layer.screens.product

import android.util.Log
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
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
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.navigation.NavHostController
import com.tech.mymedicalshopuser.R
import com.tech.mymedicalshopuser.domain.model.ClientChoiceModelEntity
import com.tech.mymedicalshopuser.local.viewmodel.RoomCartViewModel
import com.tech.mymedicalshopuser.ui.theme.GreenColor
import com.tech.mymedicalshopuser.ui_layer.navigation.CartScreenRoute
import com.tech.mymedicalshopuser.ui_layer.screens.product.component.PowerEachRow
import com.tech.mymedicalshopuser.ui_layer.screens.product.component.ProductThumbnail

@Composable
fun ProductDetailScreen(
    navController: NavHostController,
    productItem: ClientChoiceModelEntity,
    roomCartViewmodel: RoomCartViewModel,
) {

    val addToCart by remember {
        mutableStateOf(false)
    }
    Log.d("@@id", "ProductDetailScreen: ${productItem.product_id}")
    Box(
        modifier = Modifier.fillMaxSize(),
        contentAlignment = Alignment.BottomCenter
    ) {
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.White)
        ) {
            item {
                ProductThumbnail(
                    productImageId = productItem.product_image_id
                ) {
                    // Handle back navigation
                    navController.navigateUp()
                }
            }
            item {

                Column(
                    modifier = Modifier
                        .fillMaxSize()
                        .padding(top = 16.dp, start = 16.dp, end = 16.dp)
                        .padding(bottom = 80.dp), // Add padding to avoid overlap with the button
                    horizontalAlignment = Alignment.CenterHorizontally,
                    verticalArrangement = Arrangement.Bottom
                ) {
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Text(
                            text = productItem.product_name, style = TextStyle(
                                color = Color.Black,
                                fontSize = 24.sp,
                                fontWeight = FontWeight.Medium,
                                fontFamily = FontFamily(Font(R.font.roboto_medium))
                            )
                        )
                        Text(
                            text = productItem.product_price.toString(), style = TextStyle(
                                color = Color.Black,
                                fontSize = 24.sp,
                                fontWeight = FontWeight.Medium,
                                fontFamily = FontFamily(Font(R.font.roboto_medium))
                            )
                        )
                    }
                    Spacer(Modifier.height(8.dp))
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Text(
                            text = productItem.product_category, style = TextStyle(
                                color = Color.Black,
                                fontSize = 22.sp,
                                fontWeight = FontWeight.Normal,
                                fontFamily = FontFamily(Font(R.font.roboto_regular))
                            )
                        )
                        Text(
                            text = productItem.product_power, style = TextStyle(
                                color = Color.Black,
                                fontSize = 22.sp,
                                fontWeight = FontWeight.Normal,
                                fontFamily = FontFamily(Font(R.font.roboto_regular))
                            )
                        )
                    }
                    Spacer(Modifier.height(12.dp))
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        verticalAlignment = Alignment.CenterVertically,
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Text(
                            text = "Select Power", style = TextStyle(
                                color = Color.Black,
                                fontSize = 16.sp,
                                fontWeight = FontWeight.Medium,
                                fontFamily = FontFamily(Font(R.font.roboto_medium))
                            )
                        )
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            verticalAlignment = Alignment.CenterVertically,
                            horizontalArrangement = Arrangement.End
                        ) {
                            Image(
                                painter = painterResource(id = R.drawable.star), // Replace with your image resource
                                contentDescription = null,
                                modifier = Modifier.size(15.dp) // Adjust size as needed
                            )
                            Spacer(modifier = Modifier.width(8.dp)) // Space between image and text
                            Text(
                                text = productItem.product_rating.toString(), style = TextStyle(
                                    color = Color.Black,
                                    fontSize = 16.sp,
                                    fontWeight = FontWeight.Medium,
                                    fontFamily = FontFamily(Font(R.font.roboto_medium))
                                )
                            )
                        }
                    }
                    Spacer(Modifier.height(8.dp))

                    var selectedIndex by remember { mutableIntStateOf(-1) } // -1 means no item is selected

                    LazyRow(
                        modifier = Modifier.fillMaxWidth(),
                    ) {
                        items(10) { index ->
                            PowerEachRow(isSelectedPower = selectedIndex == index) {
                                // Update selectedIndex to the clicked item's index
                                selectedIndex = index
                            }
                        }
                    }
                    Spacer(Modifier.height(8.dp))

                    Text(
                        text = productItem.product_description,
                        style = TextStyle(
                            color = Color.Black,
                            fontSize = 16.sp,
                            fontWeight = FontWeight.Normal,
                            fontFamily = FontFamily(Font(R.font.roboto_regular))
                        )
                    )
                }
            }
        }
        AddToCartButton(
            modifier = Modifier
                .padding(start = 16.dp, end = 16.dp, bottom = 32.dp)
                .align(Alignment.BottomCenter),
            addToCart = if (roomCartViewmodel.findProductById(productItem.product_id) != null) !addToCart else addToCart
        ) {

            if (roomCartViewmodel.findProductById(productItem.product_id) != null) {
                navController.navigate(CartScreenRoute)
            } else {
                roomCartViewmodel.insertCartList(
                    productItem
                )
            }
        }
    }
}

@Composable
fun AddToCartButton(
    modifier: Modifier = Modifier,
    addToCart: Boolean,
    onClick: () -> Unit
) {

    Row(
        modifier = modifier.fillMaxWidth(),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Button(
            onClick = {
                onClick()
            },
            colors = ButtonDefaults.buttonColors(
                containerColor = GreenColor,
                contentColor = Color.White
            ),
            modifier = Modifier.fillMaxWidth(0.8f),
            elevation = ButtonDefaults.buttonElevation(4.dp)

        ) {
            Text(
                text = if (addToCart) "Go to Cart" else "Add to Cart", style = TextStyle(
                    color = Color.White,
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Medium,
                    fontFamily = FontFamily(Font(R.font.roboto_medium))
                ), modifier = Modifier.padding(4.dp)
            )
        }
        Card(
            modifier = Modifier
                .padding(4.dp)
                .size(50.dp),
            elevation = CardDefaults.cardElevation(4.dp),
            shape = CircleShape
        ) {
            Box(
                contentAlignment = Alignment.Center, // Center the content
                modifier = Modifier.fillMaxSize() // Fill the entire Card
            ) {
                Image(
                    painter = painterResource(id = if (addToCart) R.drawable.baseline_shopping_cart_checkout_24 else R.drawable.outline_shopping_cart_24), // Replace with your image resource
                    contentDescription = null,
                    modifier = Modifier
                        .size(45.dp)
                        .padding(4.dp) // Adjust size as needed
                )
            }
        }

    }

}