import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogInCard extends StatefulWidget {
  LogInCard({Key key, @required this.onButtonPress}) : super(key: key);

  final Widget onButtonPress;

  @override
  _LogInCardState createState() => _LogInCardState();
}

class _LogInCardState extends State<LogInCard> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isBtnEnabled = false;

  void initState() {
    emailController.addListener(() {
      setState(() => _isBtnEnabled = emailController.value.text.isNotEmpty &&
          passwordController.value.text.isNotEmpty);
    });
    passwordController.addListener(() {
      setState(() => _isBtnEnabled = emailController.value.text.isNotEmpty &&
          passwordController.value.text.isNotEmpty);
    });
    super.initState();
  }

  @override
  build(BuildContext context) => Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.only(left: 40, right: 40, top: 45, bottom: 50),
          child: Column(
            children: <Widget>[
              fancyTextField('Email', emailController, false),
              fancyTextField('Пароль', passwordController, true),
              Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: fancyButton('Войти')),
            ],
          ),
        ),
      );

  fancyTextField(
      String label, TextEditingController controller, bool isObscure) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: TextFormField(
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        obscureText: isObscure,
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          labelText: label,
        ),
      ),
    );
  }

  fancyButton(String label) => MaterialButton(
        color: Theme.of(context).primaryColor,
        disabledColor: CupertinoColors.lightBackgroundGray,
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: _isBtnEnabled
            ? () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => widget.onButtonPress));
              }
            : null,
        minWidth: 300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      );

  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
