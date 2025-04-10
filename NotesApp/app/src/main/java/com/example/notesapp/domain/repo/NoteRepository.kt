package com.example.notesapp.domain.repo

import androidx.datastore.core.DataStore
import androidx.datastore.preferences.core.Preferences
import androidx.datastore.preferences.core.edit
import androidx.datastore.preferences.core.emptyPreferences
import com.example.notesapp.NoteState
import com.example.notesapp.common.USER_ID
import com.example.notesapp.data.model.LoginSignupResponse
import com.example.notesapp.data.model.NoteCratedResponse
import com.example.notesapp.data.model.NoteDeleteResponse
import com.example.notesapp.data.model.NoteResponse
import com.example.notesapp.data.model.NoteUpdateResponse
import com.example.notesapp.data.request.LoginRequest
import com.example.notesapp.data.request.NoteRequest
import com.example.notesapp.data.request.NoteUpdateRequest
import com.example.notesapp.data.request.RegisterRequest
import com.example.notesapp.data.services.ApiService
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.callbackFlow
import kotlinx.coroutines.flow.catch
import kotlinx.coroutines.flow.flow
import kotlinx.coroutines.flow.map
import retrofit2.Response
import javax.inject.Inject

class NoteRepository @Inject constructor(
    private val api: ApiService,
    private val dataStore: DataStore<Preferences>
) {

    fun getUserId() : Flow<Int> {
        return dataStore.data.catch { emit(emptyPreferences()) }.map {
            it[USER_ID] ?: 0
        }
    }

    suspend fun saveUserId(userId: Int) {
        dataStore.edit {
            it[USER_ID] = userId
        }
    }

    fun signup(request: RegisterRequest): Flow<NoteState<LoginSignupResponse>> = flow {
        emit(NoteState.Loading)
        try {
            val response = api.signup(request)
            emit(NoteState.Success(response))
        } catch (e: Exception) {
            emit(NoteState.Error(e.message ?: "Unknown error"))
        }
    }

    fun login(request: LoginRequest): Flow<NoteState<LoginSignupResponse>> = flow {
        emit(NoteState.Loading)
        try {
            val response = api.login(request)
            emit(NoteState.Success(response))
        } catch (e: Exception) {
            emit(NoteState.Error(e.message ?: "Unknown error"))
        }
    }

     fun getNotes(userId: Int): Flow<NoteState<Response<List<NoteResponse>>>> = flow {
        emit(NoteState.Loading)
        try {
            val response = api.getNotesByUserId(userId)
            emit(NoteState.Success(response))
        } catch (e: Exception) {
            emit(NoteState.Error(e.message ?: "Unknown error"))
        }

    }

    fun createNote(request: NoteRequest): Flow<NoteState<Response<NoteCratedResponse>>> = flow {
        emit(NoteState.Loading)
        try {
            val response = api.createNote(request)
            emit(NoteState.Success(response))
        } catch (e: Exception) {
            emit(NoteState.Error(e.message ?: "Unknown error"))
        }
    }

    fun deleteNote(noteId: Int): Flow<NoteState<Response<NoteDeleteResponse>>> = flow {
        emit(NoteState.Loading)
        try {
            val response = api.deleteNote(noteId)
            emit(NoteState.Success(response))
        } catch (e: Exception) {
            emit(NoteState.Error(e.message ?: "Unknown error"))
        }
    }

    fun updateNote(noteId: Int, request: NoteUpdateRequest): Flow<NoteState<Response<NoteUpdateResponse>>> = flow {
        emit(NoteState.Loading)
        try {
            val response = api.updateNote(noteId, request)
            emit(NoteState.Success(response))
        } catch (e: Exception) {
            emit(NoteState.Error(e.message ?: "Unknown error"))
        }
    }


}