package com.example.notesapp.presentation.screen

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Delete
import androidx.compose.material.icons.filled.Edit
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavController
import com.example.notesapp.presentation.navigation.Route
import com.example.notesapp.presentation.viewmodel.NoteViewModel

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun NoteDetailScreen(
    navController: NavController,
    title: String,
    content: String,
    noteId: Int,
    userId: Int,
    viewModel: NoteViewModel = hiltViewModel()
) {

    val deleteNoteState = viewModel.deleteNoteScreenState.collectAsState()

    Scaffold(
        topBar = {
            TopAppBar(
                title = { Text("Note Detail") },
                colors = TopAppBarDefaults.mediumTopAppBarColors(
                    containerColor = MaterialTheme.colorScheme.primary
                )
            )
        },
        bottomBar = {
            Row(
                modifier = Modifier
                    .fillMaxWidth()
                    .padding(16.dp),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                Button(
                    onClick = {
                        navController.navigate(Route.updateNoteScreenRoute.passArgs(title, content, noteId, userId))
                    },
                    modifier = Modifier
                        .weight(1f)
                        .padding(end = 8.dp),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFF4CAF50))
                ) {
                    Icon(imageVector = Icons.Default.Edit, contentDescription = "Edit")
                    Spacer(modifier = Modifier.width(8.dp))
                    Text("Update")
                }

                Button(
                    onClick = {
                        viewModel.deleteNote(
                            noteId = noteId,
                        )
                        navController.popBackStack()
                    },
                    modifier = Modifier
                        .weight(1f)
                        .padding(start = 8.dp),
                    colors = ButtonDefaults.buttonColors(containerColor = Color(0xFFF44336))
                ) {
                    Icon(imageVector = Icons.Default.Delete, contentDescription = "Delete")
                    Spacer(modifier = Modifier.width(8.dp))
                    if (deleteNoteState.value.isLoading) Text("Deleting...") else Text("Delete")
                }
            }
        }
    ) { innerPadding ->
        Column(
            modifier = Modifier
                .padding(innerPadding)
                .padding(16.dp)
                .fillMaxSize()
        ) {
            Text(
                text = title,
                style = MaterialTheme.typography.headlineSmall.copy(fontWeight = FontWeight.Bold),
                color = Color(0xFF1A1A1A)
            )

            Spacer(modifier = Modifier.height(12.dp))

            Text(
                text = content,
                style = MaterialTheme.typography.bodyLarge.copy(color = Color(0xFF555555)),
                modifier = Modifier.verticalScroll(rememberScrollState())
            )
        }
    }
}
