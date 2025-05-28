package com.tech.mymedicalshopuser.ui_layer.screens.profile

import android.content.Intent
import android.net.Uri
import android.util.Log
import android.widget.Toast
import androidx.activity.compose.BackHandler
import androidx.annotation.DrawableRes
import androidx.compose.foundation.Image
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
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.automirrored.filled.KeyboardArrowRight
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.Icon
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.shadow
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.platform.LocalContext
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.net.toUri
import androidx.navigation.NavController
import coil.compose.rememberAsyncImagePainter
import com.tech.mymedicalshopuser.R
import com.tech.mymedicalshopuser.domain.model.ClientChoiceModelEntity
import com.tech.mymedicalshopuser.ui.theme.GreenColor
import com.tech.mymedicalshopuser.ui.theme.WhiteGreyColor
import com.tech.mymedicalshopuser.ui_layer.bottomNavigation.NavigationView
import com.tech.mymedicalshopuser.ui_layer.component.AsyncImageComponent
import com.tech.mymedicalshopuser.ui_layer.navigation.HomeScreenRoute
import com.tech.mymedicalshopuser.ui_layer.navigation.MyAccountScreenRoute
import com.tech.mymedicalshopuser.ui_layer.navigation.AllOrderScreenRoute
import com.tech.mymedicalshopuser.ui_layer.navigation.CreateOrderScreenRoute
import com.tech.mymedicalshopuser.ui_layer.navigation.ProfileScreenRoute
import com.tech.mymedicalshopuser.ui_layer.navigation.SignInRoute
import com.tech.mymedicalshopuser.ui_layer.screens.cart.CartTopBar
import com.tech.mymedicalshopuser.utils.GET_IMG_URL
import com.tech.mymedicalshopuser.utils.PreferenceManager
import com.tech.mymedicalshopuser.viewmodel.ProfileViewmodel
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

@Composable
fun ProfileScreen(
    navController: NavController,
    profileViewmodel: ProfileViewmodel,
    preferenceManager: PreferenceManager
) {

    val context = LocalContext.current
    var selectedItem by remember {
        mutableIntStateOf(3)
    }
    LaunchedEffect(Unit) {
        profileViewmodel.getSpecificUser(preferenceManager.getLoginUserId()!!)
    }
    val getSpecificUser by profileViewmodel.getSpecificUser.collectAsState()
    val updatedProfileResponseState by profileViewmodel.updateProfileResponseState.collectAsState()
    val profileScreenStateUserData by profileViewmodel.profileScreenStateUserData.collectAsState()

    //get current user data
    when {
        getSpecificUser.isLoading -> {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                CircularProgressIndicator(color = GreenColor)
            }
        }

        getSpecificUser.data != null -> {
            profileScreenStateUserData.userName.value = getSpecificUser.data!![0].name
            profileScreenStateUserData.userPhone.value = getSpecificUser.data!![0].phone_number
            profileScreenStateUserData.userEmail.value = getSpecificUser.data!![0].email
            profileScreenStateUserData.pinCode.value = getSpecificUser.data!![0].pinCode
            profileScreenStateUserData.password.value = getSpecificUser.data!![0].password
            profileScreenStateUserData.address.value = getSpecificUser.data!![0].address
            profileScreenStateUserData.dateOfCreationAccount.value =
                getSpecificUser.data!![0].date_of_account_creation
            profileScreenStateUserData.userImageId.value = getSpecificUser.data!![0].user_image_id
        }

        getSpecificUser.error != null -> {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                Text(text = getSpecificUser.error!!)
            }
        }
    }

    //when user data updated response
    when {
        updatedProfileResponseState.isLoading -> {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center) {
                CircularProgressIndicator(color = GreenColor)
            }
        }

        updatedProfileResponseState.data != null -> {
            LaunchedEffect(updatedProfileResponseState.data!!.status) {
                if (updatedProfileResponseState.data!!.status == 200) {
                    profileViewmodel.resetProfileScreenStateData()
                    Toast.makeText(
                        context,
                        updatedProfileResponseState.data!!.message,
                        Toast.LENGTH_SHORT
                    ).show()
                }
            }
            Log.d(
                "@Acc",
                "ProfileScreen updated data: ${updatedProfileResponseState.data!!.message}"
            )

        }

        updatedProfileResponseState.error != null -> {
            Log.d("@Acc", "ProfileScreen updated Error: ${updatedProfileResponseState.error}")
            Toast.makeText(context, updatedProfileResponseState.error, Toast.LENGTH_SHORT).show()
        }
    }

    BackHandler {
        navController.navigate(HomeScreenRoute) {
            navController.graph.startDestinationRoute?.let { homeScreen ->
                popUpTo(homeScreen) {
                    saveState = true
                }
                restoreState = true
                launchSingleTop = true
                navController.popBackStack(
                    ProfileScreenRoute,
                    inclusive = true
                ) // Clear back stack and go to Screen1
            }
        }
    }
    Box(
        modifier = Modifier
            .fillMaxSize()
            .background(Color.White),
        contentAlignment = Alignment.BottomEnd
    ) {
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .background(Color.White),
            horizontalAlignment = Alignment.Start,
            verticalArrangement = Arrangement.Top
        ) {
            item {
                CartTopBar(
                    headerName = "Profile",
                    isBackButtonShow = false
                )
                Spacer(modifier = Modifier.height(8.dp))
                Column(
                    modifier = Modifier
                        .fillMaxSize()
                        .background(Color.White)
                        .padding(8.dp)
                ) {
                    PersonalDetail(
                        userName = profileScreenStateUserData.userName.value,
                        userImageId = profileScreenStateUserData.userImageId.value
                    ) {
                        navController.navigate(MyAccountScreenRoute)
                    }
                    Spacer(modifier = Modifier.height(16.dp))
                    Text(
                        text = "Orders", style = TextStyle(
                            color = Color.Black,
                            fontSize = 24.sp,
                            fontWeight = FontWeight.Medium,
                            fontFamily = FontFamily(Font(R.font.roboto_regular))
                        )
                    )
                    Spacer(modifier = Modifier.height(16.dp))
                    OrderSection(
                        icon = R.drawable.ic_all_orders,
                        title = "All Orders",
                        backgroundColor = Color.Blue
                    ) {
                        navController.navigate(AllOrderScreenRoute)
                    }
                    Spacer(modifier = Modifier.height(8.dp))
                    OrderSection(
                        icon = R.drawable.ic_billing,
                        title = "Billing",
                        backgroundColor = Color.Green
                    ) {
                        navController.navigate(
                            CreateOrderScreenRoute(
                                cartList = Json.encodeToString(listOf<ClientChoiceModelEntity>()),
                                subTotalPrice = 0.0f
                            )
                        )
                    }
                    Spacer(modifier = Modifier.height(16.dp))

                    Text(
                        text = "Logout", style = TextStyle(
                            color = Color.Black,
                            fontSize = 24.sp,
                            fontWeight = FontWeight.Medium,
                            fontFamily = FontFamily(Font(R.font.roboto_regular))
                        )
                    )
                    Spacer(modifier = Modifier.height(16.dp))
                    OrderSection(
                        icon = R.drawable.ic_logout,
                        title = "Logout",
                        backgroundColor = Color.Red
                    ) {
                        ///here to logout
                        preferenceManager.setLoginUserId("")
                        Log.d("@@Nav", "Profile: ${preferenceManager.getLoginUserId()}")
                        navController.navigate(SignInRoute) {
                            navController.graph.startDestinationRoute?.let { signInScreen ->
                                popUpTo(signInScreen) {
                                    saveState = true
                                }
                                launchSingleTop = true
                            }
                        }
                    }

                }
            }
        }


        Box(modifier = Modifier.fillMaxWidth(), contentAlignment = Alignment.BottomEnd) {

            Column(
                verticalArrangement = Arrangement.Center,
                horizontalAlignment = Alignment.CenterHorizontally
            ) {

                Row(
                    modifier = Modifier.padding(8.dp),
                    horizontalArrangement = Arrangement.Center,
                    verticalAlignment = Alignment.CenterVertically
                ) {

                    Icon(
                        painter = painterResource(R.drawable.linkedin),
                        contentDescription = null,
                        modifier = Modifier.size(20.dp),
                        tint = Color.Unspecified
                    )
                    Spacer(modifier = Modifier.width(4.dp))
                    Text(
                        text = "Connect with developer", style = TextStyle(
                            color = Color.Gray,
                            fontSize = 14.sp,
                            fontWeight = FontWeight.Light,
                            fontFamily = FontFamily(Font(R.font.roboto_regular))
                        ), modifier = Modifier.clickable {
                            val intent = Intent(
                                Intent.ACTION_VIEW,
                                Uri.parse("https://www.linkedin.com/in/aman-kumar-4aaa631b5/")
                            )
                            context.startActivity(intent)
                        }
                    )
                }
                Spacer(modifier = Modifier.height(45.dp))

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
}

//@Preview
@Composable
fun PersonalDetail(
    userName: String,
    userImageId: String,
    onClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .clickable(
                interactionSource = remember { MutableInteractionSource() },
                indication = null
            ) {
                onClick()
            }
            .fillMaxWidth()
            .shadow(
                elevation = 3.dp,
                shape = RoundedCornerShape(16.dp)
            )
            .background(Color.White)
            .padding(8.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        AsyncImageComponent(
            imageId = userImageId,
            modifier = Modifier
                .shadow(
                    elevation = 10.dp,
                    spotColor = Color.Black,
                    ambientColor = Color.Black,
                    shape = CircleShape
                ),
            imageSize = 50.dp,
            shape = CircleShape
        )
        Spacer(modifier = Modifier.width(16.dp))
        Column(
            modifier = Modifier.weight(.2f),
            horizontalAlignment = Alignment.Start,
            verticalArrangement = Arrangement.Center
        ) {
            Text(
                text = userName, style = TextStyle(
                    color = Color.Black,
                    fontSize = 24.sp,
                    fontWeight = FontWeight.Medium,
                    fontFamily = FontFamily(Font(R.font.roboto_medium))
                )
            )
            Text(
                text = "edit personal details", style = TextStyle(
                    color = Color.Gray,
                    fontSize = 14.sp,
                    fontWeight = FontWeight.Light,
                    fontFamily = FontFamily(Font(R.font.roboto_regular))
                )
            )
        }
        Icon(
            imageVector = Icons.AutoMirrored.Filled.KeyboardArrowRight,
            contentDescription = null,
            modifier = Modifier.size(24.dp),
            tint = Color.Gray
        )
    }
}

@Composable
fun OrderSection(
    @DrawableRes icon: Int,
    title: String,
    backgroundColor: Color,
    onClick: () -> Unit
) {
    Row(
        modifier = Modifier
            .clickable(
                interactionSource = remember { MutableInteractionSource() },
                indication = null
            ) {
                onClick()
            }
            .fillMaxWidth()
            .shadow(
                elevation = 3.dp,
                shape = RoundedCornerShape(16.dp)
            )
            .background(Color.White)
            .padding(8.dp),
        verticalAlignment = Alignment.CenterVertically,
        horizontalArrangement = Arrangement.SpaceBetween
    ) {
        Icon(
            painter = painterResource(id = icon),
            contentDescription = null,
            modifier = Modifier
                .shadow(
                    elevation = 2.dp,
                    shape = CircleShape
                )
                .background(backgroundColor)
                .padding(8.dp),
            tint = Color.White
        )
        Spacer(modifier = Modifier.width(8.dp))
        Text(
            text = title, style = TextStyle(
                color = Color.Black,
                fontSize = 24.sp,
                fontWeight = FontWeight.Normal,
                fontFamily = FontFamily(Font(R.font.roboto_regular)),
            ), modifier = Modifier.weight(2f)
        )
        Icon(
            imageVector = Icons.AutoMirrored.Filled.KeyboardArrowRight,
            contentDescription = null,
            modifier = Modifier.size(24.dp),
            tint = Color.Gray
        )
    }
}