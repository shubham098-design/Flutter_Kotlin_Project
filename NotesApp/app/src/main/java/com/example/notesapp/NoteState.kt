package com.example.notesapp

sealed class NoteState<out T> {
    object Loading : NoteState<Nothing>()
    data class Success<out T>(val data: T) : NoteState<T>()
    data class Error<out T>(val message: String) : NoteState<T>()
}