import 'package:flutter/material.dart';
import 'package:mvvm/res/components/round_button.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/utils/utils.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();

  FocusNode passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obsecurePassword = ValueNotifier<bool>(true);//todo: we can use it instead of set state

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _obsecurePassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authViewModel = Provider.of<AuthViewModel>(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sign Up"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: "Email",
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email)
                ),
                focusNode: emailFocusNode,
                onFieldSubmitted: (value){
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),
              ValueListenableBuilder(
                valueListenable: _obsecurePassword,//pass listenable variable
                builder: (context, value, child) {
                  return TextFormField(
                    controller: _passwordController,
                    obscureText: _obsecurePassword.value, //true or false
                    focusNode: passwordFocusNode,
                    decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePassword.value = !_obsecurePassword.value;
                            },
                            child: Icon(
                                _obsecurePassword.value == true?
                                Icons.visibility_off:
                                Icons.visibility
                            ))
                    ),
                    obscuringCharacter: "*",
                  );
                },
              ),
              SizedBox(height: size.height * .1,),
              RoundButton(
                title: "Sing up",
                loading: authViewModel.loading,
                onPress: () {

                  if(_emailController.text.isEmpty){
                    Utils.flushBarErrorMessage("Please enter email", context);
                  }else if(_passwordController.text.isEmpty){
                    Utils.flushBarErrorMessage("Please enter password", context);
                  }else if(_passwordController.text.length < 6){
                    Utils.toastMessage("Password length should be more than 6");
                  }else{
                    Map data = {
                      "email": _emailController.text.toString(),
                      "password": _passwordController.text.toString()
                    };
                    authViewModel.signUpApi(data,context);

                    print("Api hit");
                  }

                },),
              SizedBox(height: size.height * .01,),
            ],
          ),
        )
    );
  }
}
