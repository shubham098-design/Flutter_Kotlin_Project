package com.example.ecommerceappinjetpackcompose.presentation.screen

import android.net.Uri
import android.widget.Toast
import androidx.activity.compose.rememberLauncherForActivityResult
import androidx.activity.result.PickVisualMediaRequest
import androidx.activity.result.contract.ActivityResultContracts
import androidx.compose.foundation.background
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.ui.platform.LocalContext
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import androidx.navigation.NavController
import com.example.ecommerceappinjetpackcompose.presentation.navigation.Route
import com.example.ecommerceappinjetpackcompose.presentation.viewModels.SoppingAppViewModel
import com.google.firebase.auth.FirebaseAuth
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
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.KeyboardOptions
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material.icons.filled.FavoriteBorder
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.OutlinedButton
import androidx.compose.material3.OutlinedTextField
import androidx.compose.material3.OutlinedTextFieldDefaults
import androidx.compose.material3.RadioButton
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.material3.rememberTopAppBarState
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.saveable.rememberSaveable
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.nestedscroll.nestedScroll
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.input.KeyboardType
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.lifecycle.compose.collectAsStateWithLifecycle
import coil.compose.AsyncImage
import coil.compose.AsyncImagePainter
import coil.compose.SubcomposeAsyncImage
import coil.compose.SubcomposeAsyncImageContent
import com.example.ecommerceappinjetpackcompose.domain.model.UserData
import com.example.ecommerceappinjetpackcompose.domain.model.UserDataParent
import com.example.ecommerceappinjetpackcompose.presentation.navigation.SubNavigation
import com.example.ecommerceappinjetpackcompose.presentation.utils.LogoutAlertDialog

@Composable
fun ProfileScreenUi(
    navController: NavController,
    viewModel: SoppingAppViewModel = hiltViewModel(),
    firebaseAuth: FirebaseAuth
) {
    LaunchedEffect(key1 = Unit) {
        viewModel.getUserById(firebaseAuth.currentUser!!.uid)
    }

    val profileScreenState = viewModel.profileScreenState.collectAsStateWithLifecycle()
    val updateScreenState = viewModel.updateScreenState.collectAsStateWithLifecycle()
    val userProfileImageState = viewModel.uploadUserProfileImageScreenState.collectAsStateWithLifecycle()
    val context = LocalContext.current

    val isEditing = remember { mutableStateOf(false) }
    var showDialog by remember { mutableStateOf(false) }

//    val imageUri = rememberSaveable { mutableStateOf<Uri?>(null) }
    val imageUri = remember { mutableStateOf("") }

    val firstName = remember{mutableStateOf(profileScreenState.value.userData?.data?.firstName ?: "")}
    val lastName = remember{mutableStateOf(profileScreenState.value.userData?.data?.lastName ?: "")}
    val email = remember{mutableStateOf(profileScreenState.value.userData?.data?.email ?: "")}
    val phone = remember{mutableStateOf(profileScreenState.value.userData?.data?.phoneNumber ?: "")}
    val address = remember{mutableStateOf(profileScreenState.value.userData?.data?.address ?: "")}

    LaunchedEffect(profileScreenState.value.userData) {
        profileScreenState.value.userData?.data?.let {userData->
            firstName.value = userData.firstName?:""
            lastName.value = userData.lastName?:""
            email.value = userData.email?:""
            phone.value = userData.phoneNumber?:""
            address.value = userData.address?:""
            imageUri.value = userData.imageUrl?:""
        }
    }

    val pickMedia = rememberLauncherForActivityResult(contract = ActivityResultContracts.PickVisualMedia()) {uri: Uri? ->
        if (uri != null) {
            viewModel.upLoadUserProfileImage(uri)
            imageUri.value = uri.toString() // It is converted to String
        }

    }

    if (updateScreenState.value.userData != null) {
        Toast.makeText(context, "Updated Successfully", Toast.LENGTH_SHORT).show()
    }else if (updateScreenState.value.errorMessage != null) {
        Toast.makeText(context, updateScreenState.value.errorMessage, Toast.LENGTH_SHORT).show()
    }else if (updateScreenState.value.isLoading) {
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center){
            CircularProgressIndicator()
        }
    }

    if (userProfileImageState.value.imageUrl != null) {
        imageUri.value = userProfileImageState.value.imageUrl.toString()
    }else if (userProfileImageState.value.errorMessage != null) {
        Toast.makeText(context, userProfileImageState.value.errorMessage, Toast.LENGTH_SHORT).show()
    }else if (userProfileImageState.value.isLoading) {
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center){
            CircularProgressIndicator()
        }
    }

    if (profileScreenState.value.isLoading) {
        Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center){
            CircularProgressIndicator()
        }
    }else if (profileScreenState.value.errorMessage != null) {
        Text(text = profileScreenState.value.errorMessage!!)
    }else if (profileScreenState.value.userData != null) {
        Scaffold(

        ) {
            it
            Column(
                modifier = Modifier
                    .fillMaxSize().padding(it)
                    .padding(16.dp),
                verticalArrangement = Arrangement.Center,
            ){
                SubcomposeAsyncImage(
                    model = if (isEditing.value) imageUri.value else imageUri.value,
                    contentDescription = "Profile Pic",
                    contentScale = ContentScale.Crop,
                    modifier = Modifier
                        .clip(CircleShape)
                        .border(2.dp, color = Color.Green)
                ) {
                    when (painter.state) {
                        is AsyncImagePainter.State.Loading -> {
                            CircularProgressIndicator()
                        }
                        is AsyncImagePainter.State.Error -> {
                            Icon(imageVector = Icons.Default.Person, contentDescription = "Profile Pic")
                        }
                        else  -> {
                            SubcomposeAsyncImageContent()
                        }
                    }
                }

                if (isEditing.value){
                    IconButton(
                        onClick = {
                        pickMedia.launch(PickVisualMediaRequest(ActivityResultContracts.PickVisualMedia.ImageOnly))
                        },
                        modifier = Modifier.size(40.dp).align(Alignment.End).background(color = MaterialTheme.colorScheme.primary, shape = CircleShape)
                    ) {
                      Icon(Icons.Default.Add, contentDescription = "", tint = Color.White)
                    }
                }
            }

            Spacer(modifier = Modifier.size(16.dp))

            Row {
                OutlinedTextField(
                    value = firstName.value,
                    onValueChange = {firstName.value = it},
                    label = { Text(text = "First Name") },
                    modifier = Modifier.weight(1f),
                    readOnly = if (isEditing.value) false else true,
                    colors = OutlinedTextFieldDefaults.colors(
                        focusedBorderColor = Color.Green,
                        unfocusedBorderColor = Color.Green

                    ),
                    shape = RoundedCornerShape(10.dp)
                )

                Spacer(modifier = Modifier.height(16.dp))

                OutlinedTextField(
                    value = lastName.value,
                    onValueChange = {lastName.value = it},
                    label = { Text(text = "Last Name") },
                    modifier = Modifier.weight(1f),
                    readOnly = if (isEditing.value) false else true,
                    colors = OutlinedTextFieldDefaults.colors(
                        focusedBorderColor = Color.Green,
                        unfocusedBorderColor = Color.Green

                    ),
                    shape = RoundedCornerShape(10.dp)
                )
            }

            Spacer(modifier = Modifier.size(16.dp))

            OutlinedTextField(
                value = email.value,
                onValueChange = {email.value = it},
                label = { Text(text = "Email") },
                modifier = Modifier.fillMaxWidth(),
                readOnly = if (isEditing.value) false else true,
                colors = OutlinedTextFieldDefaults.colors(
                    focusedBorderColor = Color.Green,
                    unfocusedBorderColor = Color.Green
                )
            )

            Spacer(modifier = Modifier.size(16.dp))
            OutlinedTextField(
                value = phone.value,
                onValueChange = {phone.value = it},
                label = { Text(text = "Phone") },
                modifier = Modifier.fillMaxWidth(),
                readOnly = if (isEditing.value) false else true,
                colors = OutlinedTextFieldDefaults.colors(
                    focusedBorderColor = Color.Green,
                    unfocusedBorderColor = Color.Green
                )
            )

            Spacer(modifier = Modifier.size(16.dp))

            OutlinedTextField(
                value = address.value,
                onValueChange = {address.value = it},
                label = { Text(text = "Address") },
                modifier = Modifier.fillMaxWidth(),
                readOnly = if (isEditing.value) false else true,
                colors = OutlinedTextFieldDefaults.colors(
                    focusedBorderColor = Color.Green,
                    unfocusedBorderColor = Color.Green
                )
            )

            Spacer(modifier = Modifier.size(16.dp))

            OutlinedButton(
                onClick = {
                    showDialog = true
                },
                modifier = Modifier.fillMaxWidth(),
                shape = RoundedCornerShape(10.dp),
                colors = ButtonDefaults.outlinedButtonColors(
                    contentColor = Color.White,
                    containerColor = Color.Green
                )
            ) {
                Text(text = "Log out")
            }

            if (showDialog) {
                LogoutAlertDialog(
                    onDismiss = {
                        showDialog = false
                    },
                    onConfirm = {
                        firebaseAuth.signOut()
                        navController.navigate(SubNavigation.LoginSignupScreen)
                    }
                )
            }

            Spacer(modifier = Modifier.size(16.dp))

            if (isEditing.value==false){
                OutlinedButton(
                    onClick = {
                        isEditing.value = !isEditing.value
                    },
                    modifier = Modifier.fillMaxWidth(),
                    shape = RoundedCornerShape(10.dp),
                    colors = ButtonDefaults.outlinedButtonColors(
                        contentColor = Color.White,
                        containerColor = Color.Green
                    )
                ) {
                    Text(text = "Edit Profile")
                }
            }else{
                OutlinedButton(
                    onClick = {
                        val updatedUserData = UserData(
                            firstName = firstName.value,
                            lastName = lastName.value,
                            email = email.value,
                            phoneNumber = phone.value,
                            address = address.value,
                            imageUrl = imageUri.value
                        )

                        val userDataParent = UserDataParent(
                            nodeId = profileScreenState.value.userData!!.nodeId,
                        )
                        viewModel.upDateUserData(userDataParent)
                        isEditing.value = !isEditing.value
                    },
                    modifier = Modifier.fillMaxWidth(),
                    shape = RoundedCornerShape(10.dp),
                    colors = ButtonDefaults.outlinedButtonColors(
                        contentColor = Color.White,
                        containerColor = Color.Green
                    )
                ) {
                    Text(text = "Save Profile")
                }
            }
        }
    }

}