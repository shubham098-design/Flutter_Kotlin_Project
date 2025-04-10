import 'package:flutter/cupertino.dart';

class BannerContainer extends StatelessWidget {
  const BannerContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width*0.8,
      height: MediaQuery.of(context).size.height*0.25,
      child: Image.asset("images/b_banner.png",fit: BoxFit.cover,),
    );
  }
}
