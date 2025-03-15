import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_eccomerce_app_with_mongodb/logic/cubits/order/order_cubit.dart';
import 'package:u_eccomerce_app_with_mongodb/presentation/screen/auth/login_screen.dart';
import 'package:u_eccomerce_app_with_mongodb/presentation/screen/splash/splash_screen.dart';

import 'core/routes.dart';
import 'logic/cubits/cart_cubit/cart_cubit.dart';
import 'logic/cubits/category_cubit/category_cubit.dart';
import 'logic/cubits/product_cubit/product_cubit.dart';
import 'logic/cubits/user_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserCubit()),
        BlocProvider(create: (context) => CategoryCubit()),
        BlocProvider(create: (context) => ProductCubit()),
        BlocProvider(create: (context) => CartCubit(BlocProvider.of<UserCubit>(context))),
        BlocProvider(create: (context) => OrderCubit(BlocProvider.of<UserCubit>(context),BlocProvider.of<CartCubit>(context))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: SplashScreen.routeName,
        onGenerateRoute: Routes.onGenerateRoute,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver{
  @override
  void onCreate(BlocBase bloc) {
    print("Created:$bloc");
    super.onCreate(bloc);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print("Changed:$bloc with $change");
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print("Change in $bloc : $transition");
    super.onTransition(bloc, transition);
  }

  @override
  void onClose(BlocBase bloc) {
    print("Closed:$bloc");
    super.onClose(bloc);
  }
}
