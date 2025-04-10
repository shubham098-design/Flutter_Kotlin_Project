package com.example.notesapp.data.services

import com.example.notesapp.data.model.LoginSignupResponse
import com.example.notesapp.data.model.NoteCratedResponse
import com.example.notesapp.data.model.NoteDeleteResponse
import com.example.notesapp.data.model.NoteResponse
import com.example.notesapp.data.model.NoteUpdateResponse
import com.example.notesapp.data.request.LoginRequest
import com.example.notesapp.data.request.NoteRequest
import com.example.notesapp.data.request.NoteUpdateRequest
import com.example.notesapp.data.request.RegisterRequest
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.DELETE
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.PUT
import retrofit2.http.Path

interface ApiService {

    @GET("https://shubham09.pythonanywhere.com/notes/{id}")
    suspend fun getNotesByUserId(
        @Path("id") userId: Int
    ): Response<List<NoteResponse>>

    @POST("https://shubham09.pythonanywhere.com/signup")
    suspend fun signup(
        @Body request: RegisterRequest
    ) : LoginSignupResponse

    @POST("https://shubham09.pythonanywhere.com/login")
    suspend fun login(
        @Body request: LoginRequest
    ) : LoginSignupResponse

    @POST("https://shubham09.pythonanywhere.com/notes")
    suspend fun createNote(
        @Body request: NoteRequest
    ) : Response<NoteCratedResponse>

    @DELETE("https://shubham09.pythonanywhere.com/note/{id}")
    suspend fun deleteNote(
        @Path("id") noteId: Int
    ): Response<NoteDeleteResponse>

    @PUT("https://shubham09.pythonanywhere.com/note/{id}")
    suspend fun updateNote(
        @Path("id") noteId: Int,
        @Body request: NoteUpdateRequest
    ) : Response<NoteUpdateResponse>
}