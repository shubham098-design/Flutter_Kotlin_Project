package com.example.ecommerceappinjetpackcompose.presentation.screen


import androidx.hilt.navigation.compose.hiltViewModel
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Scaffold
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavController
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Search
import androidx.compose.material3.Card
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.unit.dp
import coil.compose.AsyncImage
import com.example.ecommerceappinjetpackcompose.domain.model.ProductDataModels
import com.example.ecommerceappinjetpackcompose.presentation.navigation.Route
import com.example.ecommerceappinjetpackcompose.presentation.utils.ProductItem
import com.example.ecommerceappinjetpackcompose.presentation.viewModels.SoppingAppViewModel


@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun GetAllFav(
    navController: NavController,
    viewModel: SoppingAppViewModel = hiltViewModel(),
) {

    val getAllFavState = viewModel.getFavScreenState.collectAsStateWithLifecycle()
    val getFavData : List<ProductDataModels> = getAllFavState.value.userData.orEmpty().filterNotNull()

    LaunchedEffect(
        key1 = Unit
    ) {
        viewModel.getAllFav()
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Text(
                        text = "Whishlis",
                        style = MaterialTheme.typography.headlineMedium,
                    )
                }
            )
        }

    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(it)
        ) {
            OutlinedTextField(
                value = "",
                onValueChange = {},
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(8.dp),
                placeholder = {
                    Text(text = "Search")
                },
                leadingIcon = {
                    Icon(
                        imageVector = Icons.Default.Search,
                        contentDescription = ""
                    )
                }
            )

            when{
                getAllFavState.value.isLoading -> {
                    Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                        CircularProgressIndicator()
                    }
                }
                getAllFavState.value.errorMessage != null -> {
                    Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                        getAllFavState.value.errorMessage?.let {
                            Text(text = it)
                        }
                    }
                }
                getFavData.isEmpty() -> {
                    Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                        Text(text = "No Whishlis Available")
                    }
                }
                else->{
                    LazyVerticalGrid(
                        columns = GridCells.Fixed(2),
                        contentPadding = PaddingValues(16.dp),
                        horizontalArrangement = Arrangement.spacedBy(16.dp),
                        verticalArrangement = Arrangement.spacedBy(16.dp)
                    ) {
                        items(getFavData){item->
                            ProductItem(product = item, onProductClick = {
                              navController.navigate(Route.EachProductDetailScreen(item.productId))
                            })
                        }
                    }
                }
            }


        }
    }
}

@Composable
fun ProductCard(item: ProductDataModels,onClick:()-> Unit) {

    Card(
        modifier = Modifier.fillMaxWidth(),
        onClick = onClick
    ) {
        Column {
            AsyncImage(
                model = item.image,
                contentDescription = "",
                modifier = Modifier.fillMaxWidth().height(200.dp),
                contentScale = ContentScale.Crop
            )

            Column(
                modifier = Modifier.padding(8.dp)
            ) {
                Text(
                    text = item.name,
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.primary
                )
            }
        }
    }

}