package com.example.ecommerceappinjetpackcompose.presentation.screen

import androidx.compose.foundation.border
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
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavController
import coil.compose.AsyncImage
import com.example.ecommerceappinjetpackcompose.presentation.viewModels.SoppingAppViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun CheckoutScreenUi(
    navController: NavController,
    productId: String,
    viewModel: SoppingAppViewModel = hiltViewModel()
) {
    val context = LocalContext.current

    val state = viewModel.getCheckoutScreenState.collectAsStateWithLifecycle()
    val productData = state.value.userData

    var firstName by remember { mutableStateOf("") }
    var lastName by remember { mutableStateOf("") }
    var email by remember { mutableStateOf("") }
    var country by remember { mutableStateOf("") }
    var address by remember { mutableStateOf("") }
    var city by remember { mutableStateOf("") }
    var postalCode by remember { mutableStateOf("") }
    var selectedMethod by remember { mutableStateOf("") }

    LaunchedEffect(key1 = Unit) {
        viewModel.getProductById(productId)
    }

    Scaffold(
        topBar = {
            TopAppBar(
                title = {
                    Text(text = "Shipping")
                },
                navigationIcon = {
                    IconButton(onClick = {}) {
                        Icon(imageVector = Icons.Default.ArrowBack, contentDescription = "")
                    }
                }
            )
        }
    ) {
        it

        when {
            state.value.isLoading -> {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    CircularProgressIndicator()
                }
            }

            state.value.errorMessage != null -> {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text(text = state.value.errorMessage!!)
                }
            }

            state.value.userData == null -> {
                Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                    Text(text = "No Product Available")
                }
            }

            else -> {
                Column(
                    modifier = Modifier
                        .fillMaxSize()
                        .padding(it)
                        .verticalScroll(rememberScrollState())
                        .padding(16.dp)
                ) {
                    Row(
                        verticalAlignment = Alignment.CenterVertically
                    ) {
                        AsyncImage(
                            model = state.value.userData!!.image,
                            contentDescription = "",
                            modifier = Modifier
                                .size(80.dp)
                                .border(1.dp, Color.Gray)
                        )
                        Spacer(modifier = Modifier.width(16.dp))
                        Column {
                            Text(
                                text = state.value.userData!!.name,
                                style = MaterialTheme.typography.bodyLarge
                            )
                            Text(
                                text = "$${state.value.userData!!.finalPrice}",
                                style = MaterialTheme.typography.bodyLarge,
                                fontWeight = FontWeight.Bold
                            )
                        }
                    }

                    Spacer(modifier = Modifier.height(16.dp))

                    Column(

                    ) {
                        Text(
                            text = "Contact Information",
                            style = MaterialTheme.typography.bodyLarge
                        )
                        Spacer(modifier = Modifier.height(8.dp))
                        OutlinedTextField(
                            value = email,
                            onValueChange = { email = it },
                            modifier = Modifier.fillMaxWidth(),
                            label = { Text(text = "Email") },
                            keyboardOptions = KeyboardOptions(keyboardType = KeyboardType.Email)
                        )
                        Spacer(modifier = Modifier.height(16.dp))

                        Column {
                            Text(
                                text = "Shipping Address",
                                style = MaterialTheme.typography.bodyLarge
                            )
                            Spacer(modifier = Modifier.height(8.dp))
                            OutlinedTextField(
                                value = country,
                                onValueChange = { country = it },
                                modifier = Modifier.fillMaxWidth(),
                                label = { Text(text = "Country/Region") },
                            )
                            Spacer(modifier = Modifier.height(8.dp))

                            Row {
                                OutlinedTextField(
                                    value = firstName,
                                    onValueChange = { firstName = it },
                                    modifier = Modifier.weight(1f),
                                    label = { Text(text = "First Name") },
                                )
                                OutlinedTextField(
                                    value = lastName,
                                    onValueChange = { lastName = it },
                                    modifier = Modifier.weight(1f).padding(end = 8.dp),
                                    label = { Text(text = "First Name") },
                                )
                            }
                            Spacer(modifier = Modifier.height(8.dp))
                            OutlinedTextField(
                                value = address,
                                onValueChange = { address = it },
                                modifier = Modifier.fillMaxWidth(),
                                label = { Text(text = "Address") },
                            )
                            Spacer(modifier = Modifier.height(8.dp))
                            Row {
                                OutlinedTextField(
                                    value = city,
                                    onValueChange = { city = it },
                                    modifier = Modifier.weight(1f),
                                    label = { Text(text = "City") },
                                )
                                OutlinedTextField(
                                    value = postalCode,
                                    onValueChange = { postalCode = it },
                                    modifier = Modifier.weight(1f).padding(end = 8.dp),
                                    label = { Text(text = "Postal Code") },
                                )
                            }
                            Spacer(modifier = Modifier.height(16.dp))
                            Column {
                                Text(
                                    text = "Shipping Method",
                                    style = MaterialTheme.typography.bodyLarge
                                )
                                Spacer(modifier = Modifier.height(16.dp))
                                Row(
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    RadioButton(
                                        selected = selectedMethod == "Standard Free delivery over Rs. 4500",
                                        onClick = {
                                            selectedMethod == "Standard Free delivery over 4500"
                                        }
                                    )
                                    Spacer(modifier = Modifier.width(8.dp))
                                    Text(text = "Standard Free delivery over Rs. 4500")
                                }

                                Row(
                                    verticalAlignment = Alignment.CenterVertically
                                ) {
                                    RadioButton(
                                        selected = selectedMethod == "Cash on delivery Rs.50",
                                        onClick = {
                                            selectedMethod == "Cash on delivery Rs.50"
                                        }
                                    )
                                    Spacer(modifier = Modifier.width(8.dp))
                                    Text(text = "Cash on delivery Rs.50")
                                }
                            }
                            Spacer(modifier = Modifier.height(16.dp))
                            Button(
                                onClick = {},
                                modifier = Modifier.fillMaxWidth(),
                                colors = ButtonDefaults.buttonColors(
                                    containerColor = Color.Green,
                                    contentColor = Color.White
                                )
                            ) {
                                Text(text = "")
                            }
                        }

                    }
                }
            }
        }
    }

}