package com.example.ecommerceappinjetpackcompose.presentation.screen


import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.compose.runtime.Composable
import androidx.navigation.NavController
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Notifications
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TextField
import androidx.compose.material3.TextFieldDefaults
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextDecoration
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import coil.compose.AsyncImage
import com.example.ecommerceappinjetpackcompose.domain.model.ProductDataModels
import com.example.ecommerceappinjetpackcompose.presentation.navigation.Route
import com.example.ecommerceappinjetpackcompose.presentation.utils.Banner
import com.example.ecommerceappinjetpackcompose.presentation.viewModels.SoppingAppViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun HomeScreenUi(
    navController: NavController,
    viewModel: SoppingAppViewModel = hiltViewModel()

) {

    val homeState = viewModel.homeScreenState.collectAsStateWithLifecycle()
    val getAllSuggestedProduct = viewModel.getAllSuggestedProductsScreenState.collectAsStateWithLifecycle()
    val getSuggestedProductData : List<ProductDataModels> = getAllSuggestedProduct.value.userData.orEmpty().filterNotNull()

    LaunchedEffect(
        key1 = Unit
    ){
        viewModel.getAllSuggestedProducts()
    }

    if (homeState.value.isLoading) {
        Box(
            modifier = Modifier.fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
           CircularProgressIndicator()
        }
    }
    else if (homeState.value.errorMessage!=null){
        Box(
            modifier = Modifier.fillMaxSize(),
            contentAlignment = Alignment.Center
        ) {
            Text(text = homeState.value.errorMessage.toString())
        }
    }
    else{
        Scaffold(

        ) {

            Column(
                modifier = Modifier
                    .fillMaxSize()
                    .padding(it)
                    .verticalScroll(rememberScrollState())
            ) {
                Row (
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(10.dp),
                    verticalAlignment = Alignment.CenterVertically

                ){
                    TextField(
                        value = "",
                        onValueChange = {},
                        modifier = Modifier
                            .weight(1f)
                            .height(50.dp),
                        placeholder = {
                            Text(text = "Search")
                        },
                        leadingIcon = {
                            Icon(
                                imageVector = Icons.Default.Search,
                                contentDescription = ""
                            )
                        },
                        colors = TextFieldDefaults.textFieldColors(
                            focusedIndicatorColor = Color.White,
                            unfocusedIndicatorColor = Color.Transparent
                        )
                    )

                    IconButton(
                        onClick = {}
                    ) {
                        Icon(Icons.Default.Notifications, contentDescription = "", modifier = Modifier.size(30.dp))
                    }

                }

                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = 10.dp, vertical = 8.dp),
                    horizontalArrangement = Arrangement.SpaceBetween
                ){
                    Text(
                        text = "Categories",
                        style = MaterialTheme.typography.titleMedium,
                        fontWeight = FontWeight.Bold
                    )
                    Text(
                        text = "View All",
                        color = Color.Green,
                        modifier = Modifier.clickable {
                            navController.navigate(Route.AllCategoriesScreen)
                        },
                        style = MaterialTheme.typography.bodyMedium
                    )
                }

                LazyRow(
                  modifier = Modifier.padding(horizontal = 16.dp),
                    contentPadding = PaddingValues(horizontal = 16.dp)
                ){
                    items(homeState.value.categories){
                        CategoryItem(
                            imageUri = it?.categoryImage ?: "",
                            category = it?.name ?: "",
                            onClick = {
                                navController.navigate(Route.EachCategoryItemScreen(it?.name ?: ""))
                            }
                        )
                    }
                }
            }

            homeState.value.banner.let { banners->
                Banner(banners =banners)
            }

            Column(

            ) {
                Row (
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(start = 16.dp,end = 16.dp, bottom = 8.dp),
                    horizontalArrangement = Arrangement.SpaceBetween
                ){
                    Text(
                        text = "Flash Sale",
                        style = MaterialTheme.typography.titleMedium,
                    )

                    Text(
                        text = "See More",
                        color = Color.Green,
                        modifier = Modifier.clickable {
                            navController.navigate(Route.SeeAllProductScreen)
                        },
                        style = MaterialTheme.typography.bodyMedium
                    )
                }
                LazyRow(
                    modifier = Modifier.fillMaxWidth(),
                    contentPadding = PaddingValues(horizontal = 16.dp),
                    horizontalArrangement = Arrangement.spacedBy(12.dp)
                ) {
                    items(homeState.value.products){
                        ProductCard(product = it!!, navController = navController)
                    }
                }
            }

            Column(
                modifier = Modifier.padding(top = 16.dp, bottom = 16.dp)
            ) {
                when{
                    getAllSuggestedProduct.value.isLoading->{
                        Box(
                            modifier = Modifier.fillMaxSize(),
                            contentAlignment = Alignment.Center
                        ) {
                            CircularProgressIndicator()
                        }
                    }
                    getAllSuggestedProduct.value.errorMessage!=null-> {
                        Box(
                            modifier = Modifier.fillMaxSize(),
                            contentAlignment = Alignment.Center
                        ) {
                            Text(text = getAllSuggestedProduct.value.errorMessage.toString())

                        }
                    }
                    getSuggestedProductData.isEmpty()->{
                        Box(
                            modifier = Modifier.fillMaxSize(),
                            contentAlignment = Alignment.Center
                        ) {
                            Text(text = "No Data Found")
                        }
                    }
                    else->{
                        Row (
                            modifier = Modifier
                                .fillMaxWidth()
                                .padding(start = 16.dp,end = 16.dp, bottom = 8.dp),
                            horizontalArrangement = Arrangement.SpaceBetween
                        ){
                            Text(
                                text = "Suggested Products",
                                style = MaterialTheme.typography.titleMedium,
                            )

                            Text(
                                text = "See More",
                                color = Color.Green,
                                modifier = Modifier.clickable {
                                    navController.navigate(Route.SeeAllProductScreen)
                                },
                                style = MaterialTheme.typography.bodyMedium
                            )
                        }
                        LazyRow(
                            modifier = Modifier.fillMaxWidth(),
                            contentPadding = PaddingValues(horizontal = 16.dp),
                            horizontalArrangement = Arrangement.spacedBy(12.dp)
                        ) {
                            items(getSuggestedProductData){
                                ProductCard(product = it, navController = navController)
                            }
                        }
                    }
                }
            }

        }
    }

}

@Composable
fun CategoryItem(
    imageUri: String,
    category: String,
    onClick: () -> Unit
) {
    Column(
        modifier = Modifier
            .padding(end = 16.dp)
            .clickable {
                onClick.invoke()
            },
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Box(
            modifier = Modifier
                .size(60.dp)
                .background(Color.LightGray, shape = CircleShape)
        ) {
            AsyncImage(
                model = imageUri,
                contentDescription = "",
                modifier = Modifier
                    .size(60.dp)
                    .clip(CircleShape),
                contentScale = ContentScale.Crop
            )

        }

        Text(text = category, style = MaterialTheme.typography.bodyMedium)
    }
}


@Composable
fun ProductCard(product: ProductDataModels, navController: NavController) {

    Card(
        modifier = Modifier
            .width(150.dp)
            .clickable {
                navController.navigate(Route.EachProductDetailScreen(product.productId))
            }
            .aspectRatio(0.7f),
        elevation = CardDefaults.cardElevation(defaultElevation = 4.dp)
    ) {
        Column {
            AsyncImage(
                model = product.image,
                contentDescription = "",
                modifier = Modifier
                    .fillMaxWidth()
                    .height(150.dp)
                    .width(100.dp)
                    .clip(
                        RoundedCornerShape(8.dp)
                    ),
                contentScale = ContentScale.Crop
            )

            Column(
                modifier = Modifier.padding(8.dp)
            ) {
                Text(
                    text = product.name,
                    maxLines = 1,
                    style = MaterialTheme.typography.bodyMedium,
                    overflow = TextOverflow.Ellipsis
                )
                Row(
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text(
                        text = "Rs.${product.finalPrice}",
                        style = MaterialTheme.typography.titleSmall,
                        fontWeight = FontWeight.Bold
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text(
                        text = "Rs.${product.price}",
                        style = MaterialTheme.typography.bodySmall,
                        textDecoration = TextDecoration.LineThrough,
                        color = Color.Gray
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text(
                        text = "${product.availableUnits} left",
                        style = MaterialTheme.typography.bodySmall,
                        color = Color.Gray
                    )


                }
            }
        }
    }
}