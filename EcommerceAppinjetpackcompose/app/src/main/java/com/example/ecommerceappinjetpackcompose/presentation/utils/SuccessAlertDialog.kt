package com.example.ecommerceappinjetpackcompose.presentation.utils

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
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
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.material3.BasicAlertDialog
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun SuccessAlertDialog(
    message: String,
    onDismiss: () -> Unit,
    onConfirm: () -> Unit,
) {

    BasicAlertDialog(
        onDismissRequest = onDismiss,
        modifier = Modifier.background(shape = RoundedCornerShape(16.dp), color = Color.White),

    ) {
        Column(
            modifier = Modifier.fillMaxWidth().padding(24.dp),
            horizontalAlignment = Alignment.CenterHorizontally,
        ) {
            Box(
                modifier = Modifier.size(64.dp).background(color = Color.Green).clip(CircleShape),
                contentAlignment = Alignment.Center
            ){
                Icon(
                    imageVector = Icons.Default.Check,
                    contentDescription = "check",
                    tint = Color.White,
                    modifier = Modifier.size(32.dp)
                )
            }
            Spacer(modifier = Modifier.height(16.dp))
            Text(
                text = "Success",
                modifier = Modifier.padding(vertical = 16.dp),
                color = Color.Green,
                fontWeight = FontWeight.Bold,
                fontSize = 24.sp
            )
            Spacer(modifier = Modifier.height(8.dp))
            Text(
                text = "Congregation , you have \n completed your registration",
                textAlign = TextAlign.Center,
                modifier = Modifier.padding(vertical = 16.dp),
                fontSize = 16.sp
            )

            Spacer(modifier = Modifier.height(16.dp))

            Button(
                modifier = Modifier.fillMaxWidth().height(50.dp),
                onClick = { onConfirm() },
                colors = ButtonDefaults.buttonColors(
                    backgroundColor = Color.Green,
                    contentColor = Color.White
                ),
                shape = RoundedCornerShape(8.dp)
            ) {
                Text(text = "Go to Home")
            }

        }
    }

}