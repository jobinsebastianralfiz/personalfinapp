
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personalfinanceapp/constants/colors.dart';
import 'package:personalfinanceapp/models/expense_model.dart';
import 'package:personalfinanceapp/services/fin_service.dart';
import 'package:personalfinanceapp/widgets/appbutton.dart';
import 'package:personalfinanceapp/widgets/apptext.dart';
import 'package:personalfinanceapp/widgets/customtextformfiled.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddExpensePage extends StatefulWidget {
  final uid;
  const AddExpensePage({super.key,this.uid});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  String? category;

  final _expeKey = GlobalKey<FormState>();
  var expenseCategories = [
    'Housing',
    'Transportation',
    'Food and Groceries',
    'Healthcare',
    'Debt Payments',
    'Entertainment',
    'Personal Care',
    'Clothing and Accessories',
    'Utilities and Bills',
    'Savings and Investments',
    'Education',
    'Travel',
  ];

  @override
  Widget build(BuildContext context) {

    final finService=Provider.of<UserServvice>(context);
    final String userid=ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(

      appBar: AppBar(
        title: AppText(data: "Add Expense",),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _expeKey,
          child: Column(
            children: [
              DropdownButtonFormField(
                dropdownColor: scaffoldColor,
                style: TextStyle(color: Colors.white),
                value: category, // Add this line to set the current value
                onChanged: (value) {
                  setState(() {
                    category = value as String?;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Select a category';
                  }
                  return null; // Return null if validation succeeds
                },
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Select Category",
                ),
                items: expenseCategories
                    .map((item) => DropdownMenuItem(
                  value: item,
                  child: AppText(data: item),
                ))
                    .toList(),
              ),

              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
          
                  validator: (value){
          
                    if(value!.isEmpty){
                      return "Description is Mandatory";
                    }
                  },
                  controller:_descController, hintText: "Description")
             , SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                type: TextInputType.number,
                  validator: (value){
          
                    if(value!.isEmpty){
                      return "Enter a Valid Amount";
                    }
                  },
                  controller: _amountController, hintText: "Enter the Amount"),
              SizedBox(
                height: 20,
              ),
              Center(
                child: AppButton(
                    height: 48,
                    width: 250,
                    color: Colors.deepOrange,
                    onTap: () async{
                      print("hello");

                      var uuid=Uuid().v1();
          
                      if (_expeKey.currentState!.validate()) {

                        ExpenseModel exp=ExpenseModel(
                            id: uuid,
                            uid: userid,
                            amount: double.parse(_amountController.text),
                            description: _descController.text,
                            category:  category.toString(),
                            createdat: DateTime.now());



                        finService.addExpense(exp);

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Lottie.asset('assets/json/success.json'),
                            );
                          },
                        );



                        // Close the dialog after 4 seconds
                        Future.delayed(Duration(seconds: 4), () {
                          Navigator.pop(context);
                        }).then((value) => Navigator.pop(context));

                      }
                    },
                    child: AppText(
                      data: "Add Expense",
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
