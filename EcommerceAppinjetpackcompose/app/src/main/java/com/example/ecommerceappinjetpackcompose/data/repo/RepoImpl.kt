    package com.example.ecommerceappinjetpackcompose.data.repo

import android.net.Uri
import com.example.ecommerceappinjetpackcompose.common.ADD_TO_CART
import com.example.ecommerceappinjetpackcompose.common.ADD_TO_FAV
import com.example.ecommerceappinjetpackcompose.common.PRODUCT_COLLECTION
import com.example.ecommerceappinjetpackcompose.common.ResultState
import com.example.ecommerceappinjetpackcompose.common.USER_COLLECTION
import com.example.ecommerceappinjetpackcompose.domain.model.BannerDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.CartDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.CategoryDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.ProductDataModels
import com.example.ecommerceappinjetpackcompose.domain.model.UserData
import com.example.ecommerceappinjetpackcompose.domain.model.UserDataParent
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.storage.FirebaseStorage
import kotlinx.coroutines.channels.awaitClose
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import javax.inject.Inject


class RepoImpl @Inject constructor(
    private val firebaseAuth: FirebaseAuth,
    private val firebaseFirestore: FirebaseFirestore
) : Repo{

    override fun registerUserEmailAndPassword(userData: UserData): Flow<ResultState<String>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseAuth.createUserWithEmailAndPassword(userData.email,userData.password).addOnCompleteListener {
                if (it.isSuccessful){
                    firebaseFirestore.collection(USER_COLLECTION).document(it.result.user?.uid.toString()).set(userData).addOnCompleteListener {
                        if (it.isSuccessful){
                            trySend(ResultState.Success("User Registered Successfully"))
                        }else{
                            trySend(ResultState.Error(it.exception.toString()))
                        }
                    }
                }else{
                    trySend(ResultState.Error(it.exception.toString()))
                }
            }
        } catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))

        }
        awaitClose {
            close()
        }
    }

    override fun loginUserEmailAndPassword(userData: UserData): Flow<ResultState<String>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseAuth.signInWithEmailAndPassword(userData.email,userData.password).addOnCompleteListener {
                if (it.isSuccessful){
                    trySend(ResultState.Success("User Logged In Successfully"))
                }else{
                    trySend(ResultState.Error(it.exception.toString()))
                }
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getUserById(uid: String): Flow<ResultState<UserDataParent>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection(USER_COLLECTION).document(uid).get().addOnCompleteListener {
                if (it.isSuccessful){
                    val userData = it.result.toObject(UserData::class.java)!!
                    val userDataParent = UserDataParent(it.result.id, data =  userData)
                    trySend(ResultState.Success(userDataParent))
                }else{
                    trySend(ResultState.Error(it.exception.toString()))
                }
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun updateUserData(userDataParent: UserDataParent): Flow<ResultState<String>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection(USER_COLLECTION).document(userDataParent.nodeId).update(userDataParent.data.toMap()).addOnCompleteListener {
                if (it.isSuccessful){
                    trySend(ResultState.Success("User Data Updated Successfully"))
                }else{
                    trySend(ResultState.Error(it.exception.toString()))
                }
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun userProfileImage(uri: Uri): Flow<ResultState<String>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            FirebaseStorage.getInstance().reference
                .child("userProfileImage/${System.currentTimeMillis()} + ${firebaseAuth.currentUser?.uid}")
                .putFile(uri).addOnCompleteListener { imageUri->
                    if (imageUri.isSuccessful){
                        imageUri.result.storage.downloadUrl.addOnCompleteListener {
                            if (it.isSuccessful){
                                trySend(ResultState.Success(it.result.toString()))
                                }else{
                                trySend(ResultState.Error(it.exception.toString()))
                            }
                        }
                    }else{
                        trySend(ResultState.Error(imageUri.exception.toString()))
                    }
                }

        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getCategoriesInLimited(): Flow<ResultState<List<CategoryDataModels>>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection("categories").limit(7).get().addOnSuccessListener{querySnapshot ->
                val categories = querySnapshot.documents.mapNotNull { document ->
                    document.toObject(CategoryDataModels::class.java)
                }
                trySend(ResultState.Success(categories))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getProductsInLimited(): Flow<ResultState<List<ProductDataModels>>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection("products").limit(10).get().addOnSuccessListener{querySnapshot ->
                val products = querySnapshot.documents.mapNotNull { document ->
                    document.toObject(ProductDataModels::class.java)?.apply {
                        productId = document.id
                    }
                }
                trySend(ResultState.Success(products))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getAllProducts(): Flow<ResultState<List<ProductDataModels>>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection("products").get().addOnSuccessListener{querySnapshot ->
                val products = querySnapshot.documents.mapNotNull { document ->
                    document.toObject(ProductDataModels::class.java)?.apply {
                        productId = document.id
                    }
                }
                trySend(ResultState.Success(products))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getProductById(productId: String): Flow<ResultState<ProductDataModels>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection(PRODUCT_COLLECTION).document(productId).get().addOnSuccessListener{
                val product = it.toObject(ProductDataModels::class.java)
                trySend(ResultState.Success(product!!))

            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun addToCart(cartDataModels: CartDataModels): Flow<ResultState<String>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection(ADD_TO_CART).document(firebaseAuth.currentUser!!.uid).collection("User_Cart").document().set(cartDataModels).addOnSuccessListener {
                trySend(ResultState.Success("Added to cart"))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun addToFav(cartDataModels: ProductDataModels): Flow<ResultState<String>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection(ADD_TO_FAV).document(firebaseAuth.currentUser!!.uid).collection("User_Fav").document().set(cartDataModels).addOnSuccessListener {
                trySend(ResultState.Success("Product Added to favorite"))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getAllFav(): Flow<ResultState<List<ProductDataModels>>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection(ADD_TO_FAV).document(firebaseAuth.currentUser!!.uid).collection("User_Fav").get().addOnSuccessListener{querySnapshot ->
                val products = querySnapshot.documents.mapNotNull { document ->
                    document.toObject(ProductDataModels::class.java)
                }
                trySend(ResultState.Success(products))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getCart(): Flow<ResultState<List<CartDataModels>>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection(ADD_TO_CART).document(firebaseAuth.currentUser!!.uid).collection("User_Cart").get().addOnSuccessListener{querySnapshot ->
                val products = querySnapshot.documents.mapNotNull { document ->
                    document.toObject(CartDataModels::class.java)?.apply {
                        cartId = document.id
                    }
                }
                trySend(ResultState.Success(products))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getAllCategories(): Flow<ResultState<List<CategoryDataModels>>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection("categories").get().addOnSuccessListener{querySnapshot ->
                val categories = querySnapshot.documents.mapNotNull { document ->
                    document.toObject(CategoryDataModels::class.java)
                }
                trySend(ResultState.Success(categories))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getCheckout(productId: String): Flow<ResultState<ProductDataModels>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection(PRODUCT_COLLECTION).document(productId).get().addOnSuccessListener{
                val product = it.toObject(ProductDataModels::class.java)
                trySend(ResultState.Success(product!!))

            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getBanner(): Flow<ResultState<List<BannerDataModels>>> = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection("banner").get().addOnSuccessListener{querySnapshot ->
                val banner = querySnapshot.documents.mapNotNull { document ->
                    document.toObject(BannerDataModels::class.java)
                }
                trySend(ResultState.Success(banner))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

    override fun getSpecificCategoryItems(categoryName: String): Flow<ResultState<List<ProductDataModels>>> = callbackFlow {
        try {
            firebaseFirestore.collection("products").whereEqualTo("category", categoryName).get().addOnSuccessListener {
                querySnapshot ->
                val products = querySnapshot.documents.mapNotNull { document ->
                    document.toObject(ProductDataModels::class.java)?.apply {
                        productId = document.id
                    }
                }
                trySend(ResultState.Success(products))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }
    override fun getAllSuggestedProducts(): Flow<ResultState<List<ProductDataModels>>>  = callbackFlow {
        try {
            trySend(ResultState.Loading)
            firebaseFirestore.collection(ADD_TO_FAV).document(firebaseAuth.currentUser!!.uid).collection("User_Fav").get().addOnSuccessListener{querySnapshot ->
                val products = querySnapshot.documents.mapNotNull { document ->
                    document.toObject(ProductDataModels::class.java)
                }
                trySend(ResultState.Success(products))
            }.addOnFailureListener {
                trySend(ResultState.Error(it.message.toString()))
            }
        }catch (e: Exception){
            trySend(ResultState.Error(e.message.toString()))
        }
        awaitClose {
            close()
        }
    }

}