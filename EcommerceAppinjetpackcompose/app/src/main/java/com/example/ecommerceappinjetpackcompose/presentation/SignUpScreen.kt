package com.example.ecommerceappinjetpackcompose.presentation

import android.widget.Toast
import androidx.compose.foundation.isSystemInDarkTheme
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Email
import androidx.compose.material.icons.filled.Lock
import androidx.compose.material.icons.filled.Person
import androidx.compose.material.icons.filled.Phone
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.Text
import androidx.compose.material3.TextButton
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.getValue
import androidx.compose.runtime.setValue
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavController
import androidx.navigation.NavHostController
import com.example.ecommerceappinjetpackcompose.domain.model.UserData
import com.example.ecommerceappinjetpackcompose.presentation.navigation.Route
import com.example.ecommerceappinjetpackcompose.presentation.navigation.SubNavigation
import com.example.ecommerceappinjetpackcompose.presentation.utils.CustomTextField
import com.example.ecommerceappinjetpackcompose.presentation.viewModels.SoppingAppViewModel

@Composable
fun SignUpScreen(navController: NavHostController,viewModel: SoppingAppViewModel = hiltViewModel()) {
    val context = LocalContext.current

    val state = viewModel.signUpScreenState.collectAsStateWithLifecycle()

    if(state.value.isLoading) {
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center){
            CircularProgressIndicator()
        }
    }else if(state.value.errorMessage !=null){
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center){
            Text(text = state.value.errorMessage!!)
        }
    }else if(state.value.userData !=null){
        navController.navigate(SubNavigation.MainHomeScreen)

    }else{
        var firstName by remember { mutableStateOf("") }
        var lastName by remember { mutableStateOf("") }
        var email by remember { mutableStateOf("") }
        var password by remember { mutableStateOf("") }
        var confirmPassword by remember { mutableStateOf("") }
        var phoneNumber by remember { mutableStateOf("") }

        Column(
            modifier = Modifier.fillMaxSize().padding(16.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {

            Text(
                text = "Sign Up",
                fontSize = 24.sp,
                style = TextStyle(fontWeight = FontWeight.Bold),
                modifier = Modifier.padding(vertical = 16.dp).align(Alignment.Start)
            )

            CustomTextField(
                value = firstName,
                onValueChange = {firstName=it},
                label = "First Name",
                leadingIcon = Icons.Default.Person,
                modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp)

            )
            CustomTextField(
                value = lastName,
                onValueChange = {lastName=it},
                label = "Last Name",
                leadingIcon = Icons.Default.Person,
                modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp)

            )
            CustomTextField(
                value = email,
                onValueChange = {email=it},
                label = "Email",
                leadingIcon = Icons.Default.Email,
                modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp)

            )
            CustomTextField(
                value = password,
                onValueChange = {password=it},
                label = "Password",
                leadingIcon = Icons.Default.Lock,
                modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp)

            )
            CustomTextField(
                value = confirmPassword,
                onValueChange = {confirmPassword=it},
                label = "Confirm Password",
                leadingIcon = Icons.Default.Lock,
                modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp)

            )
            CustomTextField(
                value = phoneNumber,
                onValueChange = {phoneNumber=it},
                label = "Phone Number",
                leadingIcon = Icons.Default.Phone,
                modifier = Modifier.fillMaxWidth().padding(vertical = 4.dp)

            )

            Spacer(modifier = Modifier.height(16.dp))
            OutlinedButton(
                modifier = Modifier.fillMaxWidth(),
                shape = RoundedCornerShape(16.dp),
                onClick = {

                    if (firstName.isNotEmpty() && lastName.isNotEmpty() && email.isNotEmpty() && password.isNotEmpty() && confirmPassword.isNotEmpty() && phoneNumber.isNotEmpty()){
                        if (password==confirmPassword){
                            val userData = UserData(
                                firstName = firstName,
                                lastName = lastName,
                                email = email,
                                password = password,
                                phoneNumber = phoneNumber,
                            )
                            viewModel.createUser(userData)
                        }else{
                            Toast.makeText(context, "Password does not match", Toast.LENGTH_SHORT).show()
                        }
                    }else{
                        Toast.makeText(context, "Please fill all the fields", Toast.LENGTH_SHORT).show()
                    }

                }
            ) {
                Text(text = "Sign up")
            }
            Row(
                modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp),
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.Center
            ) {
                Text(text = "Already have an account?")
                TextButton(onClick = {
                    navController.navigate(Route.LoginScreen)

                }) {
                    Text(text = "Sign in")
                }
            }

            Row(
                modifier = Modifier.fillMaxWidth().padding(vertical = 8.dp),
                verticalAlignment = Alignment.CenterVertically
            ) {
                HorizontalDivider(thickness = 1.dp, modifier = Modifier.weight(1f), color = if (isSystemInDarkTheme()) Color.White else Color.Black)
                Text(text = "OR", modifier = Modifier.padding(horizontal = 16.dp))
                HorizontalDivider(thickness = 1.dp, modifier = Modifier.weight(1f),color = if (isSystemInDarkTheme()) Color.White else Color.Black)
            }

            Spacer(modifier = Modifier.height(10.dp))
            Button(
                modifier = Modifier.fillMaxWidth(),
                shape = RoundedCornerShape(16.dp),
                colors = ButtonDefaults.buttonColors(
                    containerColor = Color.Magenta,
                    contentColor = Color.White
                ),
                onClick = {}
            ) {
                Text(text = "Login with Google")
            }

        }
    }

}