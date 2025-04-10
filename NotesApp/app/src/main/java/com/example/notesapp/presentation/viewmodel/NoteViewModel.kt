package com.example.notesapp.presentation.viewmodel


import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.notesapp.NoteState
import com.example.notesapp.data.model.LoginSignupResponse
import com.example.notesapp.data.model.NoteCratedResponse
import com.example.notesapp.data.model.NoteDeleteResponse
import com.example.notesapp.data.model.NoteResponse
import com.example.notesapp.data.model.NoteUpdateResponse
import com.example.notesapp.data.request.LoginRequest
import com.example.notesapp.data.request.NoteRequest
import com.example.notesapp.data.request.NoteUpdateRequest
import com.example.notesapp.data.request.RegisterRequest
import com.example.notesapp.domain.repo.NoteRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class NoteViewModel @Inject constructor(
    private val repository: NoteRepository
) : ViewModel() {

    // Get saved user ID from data store (default: 0)
    val user_id = repository.getUserId().stateIn(
        scope = viewModelScope,
        started = SharingStarted.WhileSubscribed(),
        initialValue = 0
    )

    // Save user ID into data store
    fun saveUserId(userId: Int) {
        viewModelScope.launch {
            try {
                repository.saveUserId(userId)
            } catch (e: Exception) {
                Log.e("saveUserId", "Failed to save user ID", e)
            }
        }
    }

    private val _signupScreenState = MutableStateFlow(SignupScreenState())
    val signupScreenState = _signupScreenState.asStateFlow()

    // Signup logic with flow collection
    fun signup(request: RegisterRequest) {
        viewModelScope.launch {
            repository.signup(request).collectLatest {
                when (it) {
                    is NoteState.Loading -> {
                        _signupScreenState.value = SignupScreenState(isLoading = true)
                    }

                    is NoteState.Success -> {
                        _signupScreenState.value = SignupScreenState(data = it.data)
                    }

                    is NoteState.Error -> {
                        _signupScreenState.value = SignupScreenState(error = it.message)
                    }
                }
            }
        }
    }

    private val _loginScreenState = MutableStateFlow(LoginScreenState())
    val loginScreenState = _loginScreenState.asStateFlow()

    fun login(request: LoginRequest) {
        viewModelScope.launch {
            repository.login(request).collectLatest {
                when (it) {
                    is NoteState.Loading -> {
                        _loginScreenState.value = LoginScreenState(isLoading = true)
                    }

                    is NoteState.Success -> {
                        _loginScreenState.value = LoginScreenState(data = it.data)
                    }

                    is NoteState.Error -> {
                        _loginScreenState.value = LoginScreenState(error = it.message)
                    }
                }
            }
        }
    }

    private val _getAllNotesState = MutableStateFlow(GetAllNotes())
    val getAllNotesState = _getAllNotesState.asStateFlow()


    fun getNotes(user_id: Int) {
        viewModelScope.launch {
            repository.getNotes(user_id).collectLatest { result ->
                when (result) {
                    is NoteState.Loading -> {
                        _getAllNotesState.value = GetAllNotes(isLoading = true)
                    }
                    is NoteState.Success -> {
                        result.data.body()?.let { notes ->
                            _getAllNotesState.value = GetAllNotes(data = notes)
                        } ?: run {
                            _getAllNotesState.value = GetAllNotes(error = "No data found")
                        }
                    }
                    is NoteState.Error -> {
                        _getAllNotesState.value = GetAllNotes(error = result.message)
                    }
                }
            }
        }
    }

    private val _createNoteScreenState = MutableStateFlow(CreateNoteScreenState())
    val createNoteScreenState = _createNoteScreenState.asStateFlow()
    fun createNote(request: NoteRequest){
        viewModelScope.launch {
            repository.createNote(request).collectLatest {
                when (it) {
                    is NoteState.Loading -> {
                        _createNoteScreenState.value = CreateNoteScreenState(isLoading = true)
                    }

                    is NoteState.Success -> {
                        _createNoteScreenState.value = CreateNoteScreenState(data = it.data.body())
                    }

                    is NoteState.Error -> {
                        _createNoteScreenState.value = CreateNoteScreenState(error = it.message)
                    }
                }
            }
        }
    }

    private val _deleteNoteScreenState = MutableStateFlow(NoteDeleteScreenState())
    val deleteNoteScreenState = _deleteNoteScreenState.asStateFlow()
    fun deleteNote(noteId: Int) {
        viewModelScope.launch {
            repository.deleteNote(noteId).collectLatest {
                when (it) {
                    is NoteState.Loading -> {
                        _deleteNoteScreenState.value = NoteDeleteScreenState(isLoading = true)
                    }

                    is NoteState.Success -> {
                        _deleteNoteScreenState.value = NoteDeleteScreenState(data = it.data.body())
                    }

                    is NoteState.Error -> {
                        _deleteNoteScreenState.value = NoteDeleteScreenState(error = it.message)
                    }
                }
            }
        }
    }

    private val _updateNoteScreenState = MutableStateFlow(NoteUpdateScreenState())
    val updateNoteScreenState = _updateNoteScreenState.asStateFlow()

    fun updateNote(noteId: Int, request: NoteUpdateRequest) {
        viewModelScope.launch {
            repository.updateNote(noteId, request).collectLatest {
                when (it) {
                    is NoteState.Loading -> {
                        _updateNoteScreenState.value = NoteUpdateScreenState(isLoading = true)
                    }

                    is NoteState.Success -> {
                        _updateNoteScreenState.value = NoteUpdateScreenState(data = it.data.body())
                    }

                    is NoteState.Error -> {
                        _updateNoteScreenState.value = NoteUpdateScreenState(error = it.message)
                    }
                }

            }
        }
    }

    fun resetLoginState() {
        _loginScreenState.value = LoginScreenState()
    }

    fun resetSignupState() {
        _signupScreenState.value = SignupScreenState()
    }

    fun resetCreateNoteState() {
        _createNoteScreenState.value = CreateNoteScreenState()
    }

    fun resetDeleteNoteState() {
        _deleteNoteScreenState.value = NoteDeleteScreenState()
    }

    fun resetUpdateNoteState() {
        _updateNoteScreenState.value = NoteUpdateScreenState()
    }


}

// For Notes listing screen (future use)
data class GetAllNotes(
    val isLoading: Boolean = false,
    val data: List<NoteResponse?> = emptyList(),
    val error: String? = null
)

// For Login/Signup screens
data class LoginScreenState(
    val isLoading: Boolean = false,
    val data: LoginSignupResponse? = null,
    val error: String? = null
)

data class SignupScreenState(
    val isLoading: Boolean = false,
    val data: LoginSignupResponse? = null,
    val error: String? = null
)

data class CreateNoteScreenState(
    val isLoading: Boolean = false,
    val data: NoteCratedResponse? = null,
    val error: String? = null
)

data class NoteDeleteScreenState(
    val isLoading: Boolean = false,
    val data: NoteDeleteResponse? = null,
    val error: String? = null
)

data class NoteUpdateScreenState(
    val isLoading: Boolean = false,
    val data: NoteUpdateResponse? = null,
    val error: String? = null
)