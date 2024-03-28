import 'package:flutter/material.dart';
import 'package:personalfinanceapp/services/auth_serrvice.dart';
import 'package:personalfinanceapp/widgets/appbutton.dart';
import 'package:personalfinanceapp/widgets/apptext.dart';
import 'package:personalfinanceapp/widgets/customtextformfiled.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController _emailController=TextEditingController();
  TextEditingController _passwordController=TextEditingController();

  final _loginKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        width: double.infinity,
        child: Form(
          key: _loginKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(data: "Login",color: Colors.white,size: 22,),
              const SizedBox(height: 20,),
              CustomTextFormField(
                validator: (value){

                if(value!.isEmpty){

                  return "Email is Mandatory";
                }
                return null;
                },
                  controller: _emailController,
                  hintText: "Email"

              ),
              const SizedBox(height: 20,),

              CustomTextFormField(
                  validator: (value){

                    if(value!.isEmpty){

                      return "Password is Mandatory";
                    }
                    if(value.length<6){
                      return "Password Should be grater than 6 characters";
                    }
                    return null;
                  },
                obscureText: true,
                  controller: _passwordController,
                  hintText: "Password"

              ),
              const SizedBox(height: 20,),
              
              Center(
                child: AppButton(
                    height: 52,
                    width: 250,
                    color: Colors.deepOrange,
                    onTap: () async{

                      if(_loginKey.currentState!.validate()){


                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            });


                       final user=await authService.loginUser(_emailController.text.trim(), _passwordController.text);
                        Navigator.pop(context);
                        if(user!=null){


                          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false,);
                        }else{

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("No user exists")));
                        }

                      }



                    }, child: AppText(data: "Login",color: Colors.white,)),
              ),
              const SizedBox(height: 40,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  AppText(data: "Don't have an Account?",color: Colors.white,),
                  SizedBox(width: 10,),
                  InkWell(
                      onTap: (){

                        Navigator.pushNamed(context, 'register');
                      },
                      child: AppText(data: "Register",color: Colors.white,))
                ],
              )
              
              
              

            ],
          ),
        ),
      ),
    );
  }
}
