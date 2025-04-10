package com.example.ecommerceappinjetpackcompose.presentation.utils

import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.Button
import androidx.compose.material.ButtonDefaults
import androidx.compose.material.Icon
import androidx.compose.material.OutlinedButton
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Person
import androidx.compose.material3.Card
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.window.Dialog

@Composable
fun LogoutAlertDialog(
    onDismiss: () -> Unit,
    onConfirm: () -> Unit,
) {

    Dialog(onDismissRequest = { onDismiss() }) {
        Card(
            modifier = Modifier.fillMaxWidth().padding(16.dp),
            shape = RoundedCornerShape(16.dp)
        ) {

            Column(
                modifier = Modifier.fillMaxWidth().padding(16.dp),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                Icon(
                    modifier = Modifier.size(80.dp).clip(CircleShape),
                    imageVector = Icons.Default.Person,
                    contentDescription = null
                )
                Spacer(modifier = Modifier.height(16.dp))
                Text(
                    text = "Are you sure you want to logout?",
                    modifier = Modifier.padding(vertical = 16.dp)
                )

                Row(
                    modifier = Modifier.fillMaxWidth(),
                    horizontalArrangement = Arrangement.SpaceBetween
                ) {
                    OutlinedButton(
                        modifier = Modifier.weight(1f).height(50.dp),
                        border =BorderStroke(
                            width = 1.dp,
                            color = Color.Red
                        ),
                        onClick = { onDismiss() }
                    ) {
                        Text(text = "Cancel")
                    }

                    Button(
                        modifier = Modifier.weight(1f).height(50.dp),
                        onClick = { onConfirm() },
                        colors = ButtonDefaults.buttonColors(
                            backgroundColor = Color.Green,
                            contentColor = Color.White
                        )
                    ) {
                        Text(text = "Logout")
                    }
                }
            }

        }
    }

}