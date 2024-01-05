import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ride_with_passenger/view/bottom_nav_bar/bottom_nav_bar_view.dart';

import '../../Widgets/buttons/k_elevated_button.dart';
import '../../Widgets/form_fields/k_text_field.dart';
import '../../controller/auth_controller/auth_controller.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final _authcontroller = Get.put(AuthController());
  final RxBool isValid = true.obs;
  final RxBool isPasswordVisible = false.obs;
   GlobalKey<FormState> _formkey = GlobalKey<FormState>();
   final emailController = TextEditingController().obs;
   final passwordController = TextEditingController().obs;
  checkValidity() {
    if (emailController.value.text.isNotEmpty && passwordController.value.text.isNotEmpty) {
      isValid.value = true;
    } else {
      isValid.value = false;
    }
  }
   final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (() {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      }),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(title: Text('Login Screen')),
        body: Container(
          height: size.height,
          width: size.width,
          child:  Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Image.asset('assets/images/ridewithpassngers.png',height: 150,width: 230,),
                    const Gap(60),
                    TextInputFieldWidget(
                      controller: emailController.value,
                      textInputType: TextInputType.emailAddress,
                      isEmail: true,
                      lable: 'Email',
                      hintText: 'Enter Email',
                      onChange: (value){
                        checkValidity();
                      },
                      prefixIcon: Icon(Icons.email),

                    ),
                    const Gap(20),
                    Obx(() => TextInputFieldWidget(
                      controller: passwordController.value,
                      textInputType: TextInputType.emailAddress,
                      lable: 'Password',
                      hintText: 'Enter Password',
                      obscure: isPasswordVisible.value,
                      maxLines: 1,
                      suffixIcon: GestureDetector(
                        onTap: (){
                          isPasswordVisible.value = !isPasswordVisible.value;
                        },
                        child: Icon(isPasswordVisible.value ? Icons.visibility_off : Icons.visibility),
                      ),
                      onChange: (value){
                        checkValidity();
                      },
                      prefixIcon: Icon(Icons.lock),
                    )),
                    const Gap(20),
                    KElevatedButton(
                      title: 'Login',
                      isEnable: isValid,
                      onPressed: (){
                        if(_formkey.currentState!.validate()){
                          _authcontroller.login(context, email: emailController.value.text, password: passwordController.value.text);
                        }
                      },
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
