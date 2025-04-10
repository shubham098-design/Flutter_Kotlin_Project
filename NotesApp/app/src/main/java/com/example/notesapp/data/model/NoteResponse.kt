package com.example.notesapp.data.model

data class NoteResponse(
    val content: String,
    val note_id: Int,
    val title: String,
    val user_id: Int
)
