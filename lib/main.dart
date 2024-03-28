import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:personalfinanceapp/constants/colors.dart';
import 'package:personalfinanceapp/models/expense_model.dart';
import 'package:personalfinanceapp/models/income_model.dart';
import 'package:personalfinanceapp/models/user_model.dart';
import 'package:personalfinanceapp/screens/add_expense.dart';
import 'package:personalfinanceapp/screens/add_income.dart';
import 'package:personalfinanceapp/screens/home_page.dart';
import 'package:personalfinanceapp/screens/list_exp_transactions.dart';
import 'package:personalfinanceapp/screens/list_inc_transaction.dart';
import 'package:personalfinanceapp/screens/login_page.dart';
import 'package:personalfinanceapp/screens/profile_page.dart';
import 'package:personalfinanceapp/screens/register_page.dart';
import 'package:personalfinanceapp/screens/splash_page.dart';
import 'package:personalfinanceapp/services/auth_serrvice.dart';
import 'package:personalfinanceapp/services/fin_service.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(IncomeModelAdapter());
  Hive.registerAdapter(ExpenseModelAdapter());
  await AuthService().openBox();
  await UserServvice().openIncomeBox();
  await UserServvice().openExpenseBox();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [


        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => UserServvice()),


      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: scaffoldColor,
            textTheme: TextTheme(
                displaySmall: TextStyle(color: Colors.white, fontSize: 17))),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashPage(),
          'login': (context) => LoginPage(),
          'register': (context) => RegisterPage(),
          'home': (context) => HomePage(),
          'addExpense': (context) => AddExpensePage(),
          'addIncome':(context)=>AddIncomePage(),
          'profile': (context) => ProfilePage(),
          'listexpense': (context) => ListExpenseTransactions()
         , 'listincome': (context) => ListIncomeTransactions()
        },
      ),
    );
  }
}
