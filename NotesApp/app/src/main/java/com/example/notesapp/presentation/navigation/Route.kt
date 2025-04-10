package com.example.notesapp.presentation.navigation

import android.net.Uri


sealed class Route(val route: String) {
    object LoginScreenRoute : Route("login")
    object SignUpScreenRoute : Route("signup")
    object HomeScreenRoute : Route("home")
    // Dynamic arguments: title and content
    object NoteDetailScreenRoute : Route("note_detail/{title}/{content}/{note_id}/{user_id}") {
        fun passArgs(title: String, content: String, noteId: Int, userId: Int): String {
            return "note_detail/${Uri.encode(title)}/${Uri.encode(content)}/$noteId/$userId"
        }
    }
    object updateNoteScreenRoute : Route("update_note/{title}/{content}/{note_id}/{user_id}") {
        fun passArgs(title: String, content: String, noteId: Int, userId: Int): String {
            return "update_note/${Uri.encode(title)}/${Uri.encode(content)}/$noteId/$userId"
        }
    }

    object AddScreenRoute : Route("add")

}