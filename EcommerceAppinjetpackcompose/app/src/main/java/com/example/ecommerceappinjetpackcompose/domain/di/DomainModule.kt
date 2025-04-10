package com.example.ecommerceappinjetpackcompose.domain.di

import com.example.ecommerceappinjetpackcompose.data.repo.RepoImpl
import com.example.ecommerceappinjetpackcompose.domain.repo.Repo
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.firestore.FirebaseFirestore
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object DomainModule {

    @Provides
    fun provideRepo(firebaseAuth: FirebaseAuth,firebaseFirestore: FirebaseFirestore) :Repo{
        return RepoImpl(firebaseAuth,firebaseFirestore)
    }

}