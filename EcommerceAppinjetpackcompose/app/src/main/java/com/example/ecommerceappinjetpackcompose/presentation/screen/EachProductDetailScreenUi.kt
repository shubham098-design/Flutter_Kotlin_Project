package com.example.ecommerceappinjetpackcompose.presentation.screen

import androidx.compose.foundation.border
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
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.FavoriteBorder
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.rememberTopAppBarState
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.example.ecommerceappinjetpackcompose.domain.model.CartDataModels
import com.example.ecommerceappinjetpackcompose.presentation.navigation.Route
import com.example.ecommerceappinjetpackcompose.presentation.viewModels.SoppingAppViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun EachProductDetailUi(
    navController: NavController,
    productId: String,
    viewModel: SoppingAppViewModel = hiltViewModel()
) {


    var getProductById = viewModel.getProductByIdScreenState.collectAsStateWithLifecycle()
    var scrollBehavior = TopAppBarDefaults.enterAlwaysScrollBehavior(rememberTopAppBarState())
    var context = LocalContext.current
    var selectedSize by remember { mutableStateOf("") }
    var quantity by remember { mutableStateOf(0) }
    var isFavorite by remember { mutableStateOf(false) }

    LaunchedEffect(key1 = Unit) {
        viewModel.getProductById(productId)
    }

    Scaffold(
        modifier = Modifier
            .fillMaxSize()
            .nestedScroll(scrollBehavior.nestedScrollConnection),
        topBar = {
            TopAppBar(
                title = {Text(text = "Product Detail")},
                navigationIcon = {
                    IconButton(
                        onClick = {}
                    ) {
                        Icon(imageVector = Icons.Default.ArrowBack, contentDescription = "Back")
                    }
                },
                scrollBehavior = scrollBehavior
            )
        }
    ) { innerPadding ->

        when {
            getProductById.value.isLoading -> {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    CircularProgressIndicator()
                }
            }

            getProductById.value.errorMessage != null -> {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text(text = getProductById.value.errorMessage!!)
                }
            }

            getProductById.value.product != null -> {
                val product = getProductById.value.product!!.copy(productId = productId)

                Column(
                    modifier = Modifier
                        .fillMaxSize()
                        .padding(innerPadding)
                        .verticalScroll(rememberScrollState())
                        .padding(16.dp)
                ) {
                    Box(
                        modifier = Modifier.height(300.dp)
                    ) {
                        AsyncImage(
                            model = product.image,
                            contentDescription = "",
                            modifier = Modifier.fillMaxSize(),
                            contentScale = ContentScale.Crop
                        )

                        Column(
                            modifier = Modifier.padding(16.dp),
                        ) {
                            Text(
                                text = product.name,
                                style = MaterialTheme.typography.bodyLarge,
                                fontWeight = FontWeight.Bold
                            )
                            Text(
                                text = "Rs. ${product.finalPrice}",
                                style = MaterialTheme.typography.headlineSmall,
                                color = MaterialTheme.colorScheme.primary,
                                modifier = Modifier.padding(vertical = 16.dp)
                            )
                            Spacer(modifier = Modifier.height(16.dp))
                            Text(
                                text = "Size",
                                style = MaterialTheme.typography.labelLarge,
                                modifier = Modifier.padding(bottom = 8.dp, top = 16.dp)
                            )
                            Row (
                                horizontalArrangement = Arrangement.spacedBy(8.dp)
                            ){
                                listOf("S", "M", "L", "XL").forEach { size ->
                                    OutlinedButton(
                                        onClick = { selectedSize = size },
                                        shape = MaterialTheme.shapes.medium,
                                        colors = if (selectedSize == size) {
                                            ButtonDefaults.buttonColors(
                                                containerColor = MaterialTheme.colorScheme.primary,
                                                contentColor = Color.White
                                            )
                                        } else {
                                            ButtonDefaults.buttonColors(
                                                containerColor = Color.White,
                                                contentColor = MaterialTheme.colorScheme.primary
                                            )
                                        }
                                    ) {
                                        Text(text = size)
                                    }
                                }
                            }
                            Spacer(modifier = Modifier.height(16.dp))
                            Text(
                                text = "Quantity",
                                style = MaterialTheme.typography.labelLarge,
                                modifier = Modifier.padding(bottom = 8.dp, top = 16.dp)
                            )
                           Row (
                               horizontalArrangement = Arrangement.spacedBy(8.dp),
                               verticalAlignment = Alignment.CenterVertically
                           ){
                               IconButton(
                                   onClick = {
                                       if (quantity>1){
                                           quantity--
                                       }
                                   }
                               ){
                                   Text(text = "-", style = MaterialTheme.typography.headlineSmall)
                               }
                               Text(text = "$quantity", style = MaterialTheme.typography.bodyLarge)
                               IconButton(
                                   onClick = {
                                       quantity++
                                   }
                               ){
                                   Text(text = "+", style = MaterialTheme.typography.headlineSmall)
                               }
                           }
                            Text(
                                text = "Description",
                                style = MaterialTheme.typography.labelLarge,
                                modifier = Modifier.padding(bottom = 8.dp, top = 16.dp)
                            )
                            Text(
                                text = product.description,
                                style = MaterialTheme.typography.bodyMedium
                            )

                            Button(
                                modifier = Modifier
                                    .fillMaxWidth(),
                                colors = ButtonDefaults.buttonColors(
                                    containerColor = Color.Green,
                                    contentColor = Color.White
                                ),
                                onClick = {
                                    val cartDataModels = CartDataModels(
                                        name = product.name,
                                        image = product.image,
                                        productId = product.productId,
                                        price = product.finalPrice,
                                        quantity = quantity.toString(),
                                        size = selectedSize,
                                        description = product.description,
                                        category = product.category
                                    )
                                    viewModel.addToCart(cartDataModels)
                                }
                            ) {
                                Text(text = "Add to Cart")
                            }

                            Button(
                                modifier = Modifier
                                    .fillMaxWidth(),
                                colors = ButtonDefaults.buttonColors(
                                    containerColor = Color.Red,
                                    contentColor = Color.White
                                ),
                                onClick = {
                                    navController.navigate(
                                        Route.CheckoutScreen(productId)
                                    )
                                }
                            ) {
                                Text(text = "Buy Now")
                            }
                            OutlinedButton(
                                modifier = Modifier.fillMaxWidth().padding(8.dp),
                                onClick = {
                                    isFavorite =!isFavorite
                                    viewModel.addToFav(product)
                                }
                            ) {
                                Row {
                                    if (isFavorite){
                                        Icon(
                                            imageVector = Icons.Default.Favorite,
                                            contentDescription = "Favorite",
                                        )
                                    }else{
                                        Icon(
                                            imageVector = Icons.Default.FavoriteBorder,
                                            contentDescription = "Favorite",
                                        )
                                    }
                                    Spacer(modifier = Modifier.width(8.dp))
                                    Text(text = "Add to Whishlist")
                                }
                            }
                        }

                    }
                }
            }

        }
    }


}