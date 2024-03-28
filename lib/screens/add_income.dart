import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:personalfinanceapp/constants/colors.dart';
import 'package:personalfinanceapp/models/income_model.dart';
import 'package:personalfinanceapp/services/fin_service.dart';
import 'package:personalfinanceapp/widgets/appbutton.dart';
import 'package:personalfinanceapp/widgets/apptext.dart';
import 'package:personalfinanceapp/widgets/customtextformfiled.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddIncomePage extends StatefulWidget {
  const AddIncomePage({super.key});

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  String? category;

  final _incomeKey = GlobalKey<FormState>();
  var incomeCategories = [
    'Salary/Wages',
    'Freelance/Consulting',
    'Investment Income',
    'Business Income',
    'Side Hustle',
    'Pension/Retirement',
    'Alimony/Child Support',
    'Gifts/Inheritance',
    'Royalties',
    'Savings Withdrawal',
    'Bonus/Incentives',
    'Commissions',
    'Grants/Scholarships',
    'Rental Income',
    'Dividends',
  ];

  @override
  Widget build(BuildContext context) {
    final finService = Provider.of<UserServvice>(context);
    final String userid = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          data: "Add Income",
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Form(
          key: _incomeKey,
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
                items:  incomeCategories
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Description is Mandatory";
                    }
                  },
                  controller: _descController,
                  hintText: "Description"),
              SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                  type: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter a Valid Amount";
                    }
                  },
                  controller: _amountController,
                  hintText: "Enter the Amount"),
              SizedBox(
                height: 20,
              ),
              Center(
                child: AppButton(
                    height: 48,
                    width: 250,
                    color: Colors.deepOrange,
                    onTap: () async {
                      print("hello");

                      var uuid = Uuid().v1();

                      if (_incomeKey.currentState!.validate()) {
                        IncomeModel income = IncomeModel(
                            id: uuid,
                            uid: userid,
                            amount: double.parse(_amountController.text),
                            description: _descController.text,
                            category: category.toString(),
                            createdAt: DateTime.now());

                        finService.addIncome(income);

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
                      data: "Add Income",
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
