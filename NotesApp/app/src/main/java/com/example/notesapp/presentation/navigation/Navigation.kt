package com.example.notesapp.presentation.navigation

import android.util.Log
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.hilt.navigation.compose.hiltViewModel
import androidx.navigation.NavType
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.navigation.navArgument
import com.example.notesapp.presentation.screen.AddNoteScreen
import com.example.notesapp.presentation.screen.HomeScreen
import com.example.notesapp.presentation.screen.LoginScreen
import com.example.notesapp.presentation.screen.NoteDetailScreen
import com.example.notesapp.presentation.screen.SignUpScreen
import com.example.notesapp.presentation.screen.UpdateNoteScreen
import com.example.notesapp.presentation.viewmodel.NoteViewModel

@Composable
fun Navigation(
    viewModel: NoteViewModel = hiltViewModel()
) {
    val user_id = viewModel.user_id.collectAsState().value
    val navController = rememberNavController()
    Log.d("userId---------------------Navigation1-------------------", user_id.toString())

    NavHost(
        navController = navController,
        startDestination = if (user_id == 0) Route.LoginScreenRoute.route
        else Route.HomeScreenRoute.route
    ) {
        composable(Route.LoginScreenRoute.route) { LoginScreen(navController = navController) }
        composable(Route.SignUpScreenRoute.route) { SignUpScreen(navController = navController) }
        composable(Route.HomeScreenRoute.route) { HomeScreen(navController = navController) }
        composable(Route.AddScreenRoute.route) { AddNoteScreen(navController = navController) }
        composable(
            route = Route.NoteDetailScreenRoute.route,
            arguments = listOf(
                navArgument("title") { type = NavType.StringType },
                navArgument("content") { type = NavType.StringType },
                navArgument("note_id") { type = NavType.IntType },
                navArgument("user_id") { type = NavType.IntType }
            )
        ) { backStackEntry ->
            val title = backStackEntry.arguments?.getString("title") ?: ""
            val content = backStackEntry.arguments?.getString("content") ?: ""
            val noteId = backStackEntry.arguments?.getInt("note_id") ?: 0
            val userId = backStackEntry.arguments?.getInt("user_id") ?: 0

            NoteDetailScreen(
                navController = navController,
                title = title,
                content = content,
                noteId = noteId,
                userId = userId
            )
        }


        composable(
            route = Route.updateNoteScreenRoute.route,
            arguments = listOf(
                navArgument("title") { type = NavType.StringType },
                navArgument("content") { type = NavType.StringType },
                navArgument("note_id") { type = NavType.IntType },
                navArgument("user_id") { type = NavType.IntType }
            )
        ) { backStackEntry ->
            val title = backStackEntry.arguments?.getString("title") ?: ""
            val content = backStackEntry.arguments?.getString("content") ?: ""
            val noteId = backStackEntry.arguments?.getInt("note_id") ?: 0
            val userId = backStackEntry.arguments?.getInt("user_id") ?: 0
            UpdateNoteScreen(
                navController = navController,
                title = title,
                content = content,
                noteId = noteId,
                userId = userId
            )
        }

    }

}
