import 'package:flutter/material.dart';
import 'package:personalfinanceapp/models/expense_model.dart';
import 'package:personalfinanceapp/models/income_model.dart';
import 'package:personalfinanceapp/services/auth_serrvice.dart';
import 'package:personalfinanceapp/services/fin_service.dart';
import 'package:personalfinanceapp/widgets/apptext.dart';
import 'package:personalfinanceapp/widgets/mydivider.dart';
import 'package:provider/provider.dart';

class ListIncomeTransactions extends StatelessWidget {
  const ListIncomeTransactions({super.key});

  @override
  Widget build(BuildContext context) {

    final double totalIncome=ModalRoute.of(context)!.settings.arguments as double;
    final finService= Provider.of<UserServvice>(context,listen: false);
    final authService= Provider.of<AuthService>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        title: AppText(data: "All Incomes",),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(

          future: authService.getCurrentUser(),
          builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{

              if(snapshot.hasData){

                final userData=snapshot.data!;
                return FutureBuilder<List<IncomeModel>>(

                    future: finService.getAllIncome(userData.id),

                    builder: (context,snapshot){
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }else{

                        if(snapshot.hasData){

                          final List<IncomeModel>expenses=snapshot.data!;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              AppText(data: "Total Income $totalIncome",color: Colors.white,),
                              const SizedBox(height: 10,),
                              MyDivider(),
                              const SizedBox(height: 10,),
                              Expanded(child: ListView.builder(

                                  itemCount: expenses.length,
                                  itemBuilder: (context,index){
                                    final expense=expenses[index];
                                    return Card(
                                      child: ListTile(

                                        onTap: (){

                                          showModalBottomSheet(

                                              context: context,

                                              builder: (context){
                                                return Container(
                                                  height: 150,
                                                  width: MediaQuery.of(context).size.width,
                                                  padding: EdgeInsets.all(20),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      AppText(data: "${expense.category}"),
                                                      AppText(data: "${expense.description}"),
                                                      AppText(data: "${expense.amount}"),
                                                      AppText(data: "${expense.createdAt}"),

                                                    ],
                                                  ),
                                                );
                                              });



                                        },
                                        title: AppText(data:expense.category,color: Colors.black87,),
                                        subtitle: AppText(data:expense.amount.toString(),color: Colors.black87,),

                                      ),
                                    );
                                  }


                              ))
                            ],
                          );
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );

                    }

                );
              }
              return Center();
            }


          },

        ),
      ),


    );
  }
}
