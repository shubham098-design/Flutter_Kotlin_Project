package com.tech.mymedicalshopuser.ui_layer.screens.order.component

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.RectangleShape
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.font.Font
import androidx.compose.ui.text.font.FontFamily
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.tech.mymedicalshopuser.R
import com.tech.mymedicalshopuser.domain.model.ClientChoiceModelEntity
import com.tech.mymedicalshopuser.ui.theme.LightGreenColor
import com.tech.mymedicalshopuser.ui_layer.component.AsyncImageComponent

@Composable
fun OrderItemView(
    cart: ClientChoiceModelEntity,
    onClick: () -> Unit
) {

    Box(
        modifier = Modifier.height(100.dp).width(300.dp).padding(4.dp).clickable {
            onClick()
        },
        contentAlignment = Alignment.Center
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .background(LightGreenColor)
                .padding(8.dp),
            verticalAlignment = Alignment.CenterVertically,
        ) {

            AsyncImageComponent(
                imageId = cart.product_image_id,
                imageSize = 100.dp,
                padding = 8.dp,
                shape = RectangleShape,
                modifier = Modifier
                    .weight(1f)
                    .size(80.dp)
            )
            Spacer(Modifier.width(4.dp))
            Column(
                modifier = Modifier.weight(2f),
                horizontalAlignment = Alignment.Start
            ) {
                Text(
                    text = cart.product_name, // Use item data
                    style = MaterialTheme.typography.titleMedium,
                    color = Color.Black,
                    fontSize = 16.sp,
                    fontFamily = FontFamily(Font(R.font.roboto_medium))
                )
                Text(
                    text = stringResource(R.string.cart_rs,cart.product_price),
                    style = MaterialTheme.typography.titleMedium,
                    color = Color.Black,
                    fontSize = 14.sp,
                    fontFamily = FontFamily(Font(R.font.roboto_medium))
                )
            }

            Column(
                modifier = Modifier.weight(1f),
                horizontalAlignment = Alignment.End,
                verticalArrangement = Arrangement.Center
            ) {
                Text(
                    text = "Qty",
                    style = MaterialTheme.typography.titleMedium,
                    color = Color.Black,
                    fontSize = 16.sp,
                    fontFamily = FontFamily(Font(R.font.roboto_medium))
                )
                Text(
                    text = cart.product_count.toString(), // Use item data
                    style = MaterialTheme.typography.titleMedium,
                    color = Color.Black,
                    fontSize = 14.sp,
                    fontFamily = FontFamily(Font(R.font.roboto_medium))
                )
            }
        }
    }
}
