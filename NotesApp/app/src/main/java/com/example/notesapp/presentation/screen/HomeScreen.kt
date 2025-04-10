package com.example.notesapp.presentation.screen

import android.util.Log
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.wrapContentHeight
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Add
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.LaunchedEffect
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import com.example.notesapp.presentation.navigation.Route
import com.example.notesapp.presentation.viewmodel.NoteViewModel

@Composable
fun HomeScreen(navController: NavController,viewModel: NoteViewModel = hiltViewModel()) {
    val getAllNoteState = viewModel.getAllNotesState.collectAsState()
    val user_id = viewModel.user_id.collectAsState().value
    val notes = getAllNoteState.value.data

    LaunchedEffect(user_id) {
        if (user_id != 0) {
            viewModel.getNotes(user_id)
            Log.d("userId ----LaunchedEffect----->", user_id.toString())
        }
    }

    when {
        getAllNoteState.value.isLoading -> {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center){
                CircularProgressIndicator()
            }
        }
        getAllNoteState.value.error != null -> {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center){
                Text(text = getAllNoteState.value.error!!)
            }
        }
        notes.isEmpty() -> {
            Box(modifier = Modifier.fillMaxSize(), contentAlignment = Alignment.Center){
                Text(text = "No notes found")
            }
        }
        else -> {
            Scaffold(
                floatingActionButton = {
                    FloatingActionButton(
                        onClick = {
                            navController.navigate(Route.AddScreenRoute.route)
                        }
                    ) {
                        Icon(
                            imageVector = Icons.Default.Add,
                            contentDescription = "Add Note"
                        )
                    }
                }
            ) { paddingValues ->
                LazyColumn(
                    modifier = Modifier
                        .fillMaxSize()
                        .padding(paddingValues) // Scaffold ke padding ko consider karna zaruri hai
                        .padding(16.dp)
                ) {
                    items(notes) { note ->
                        NoteCard(
                            title = note?.title ?: "No title",
                            content = note?.content ?: "No content",
                            onClickListener = {
                                navController.navigate(
                                    Route.NoteDetailScreenRoute.passArgs(
                                        note?.title ?: "No title",
                                        note?.content ?: "No content",
                                        note?.note_id ?: 0,
                                        note?.user_id ?: 0
                                    )
                                )
                            }
                        )
                        Spacer(modifier = Modifier.height(12.dp))
                    }
                }
            }
        }
    }


}


@Composable
fun NoteCard(title: String, content: String,onClickListener: () -> Unit) {
    Card(
        modifier = Modifier.clickable { onClickListener() }
            .fillMaxWidth()
            .wrapContentHeight(),
        colors = CardDefaults.cardColors(containerColor = Color(0xFFFAFAFA)),
        shape = RoundedCornerShape(16.dp),
        elevation = CardDefaults.cardElevation(6.dp)
    ) {
        Column(modifier = Modifier.padding(16.dp)) {
            Text(
                text = title,
                style = MaterialTheme.typography.titleMedium.copy(
                    fontWeight = FontWeight.Bold,
                    color = Color(0xFF1A1A1A)
                ),
                maxLines = 1,
                overflow = TextOverflow.Ellipsis
            )

            Spacer(modifier = Modifier.height(8.dp))

            Text(
                text = content,
                style = MaterialTheme.typography.bodyMedium.copy(
                    color = Color(0xFF555555)
                ),
                maxLines = 3,
                overflow = TextOverflow.Ellipsis
            )
        }
    }
}
