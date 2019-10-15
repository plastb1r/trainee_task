import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogInCard extends StatefulWidget {
  LogInCard({Key key, @required this.onButtonPress}) : super(key: key);

  var onButtonPress;

  @override
  _LogInCardState createState() => _LogInCardState();
}

class _LogInCardState extends State<LogInCard> {
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isBtnEnabled = false;

  void initState() {
    loginController.addListener(() {
      setState(() => _isBtnEnabled = loginController.value.text.isNotEmpty &&
          passwordController.value.text.isNotEmpty);
    });
    passwordController.addListener(() {
      setState(() => _isBtnEnabled = loginController.value.text.isNotEmpty &&
          passwordController.value.text.isNotEmpty);
    });
    super.initState();
  }

  @override
  build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              fancyTextField('логин', loginController),
              fancyTextField('пароль', passwordController),
              Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: fancyButton('Войти')),
            ],
          ),
        ),
      );

  fancyTextField(String label, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          labelText: label,
        ),
      ),
    );
  }

  fancyButton(String label) => MaterialButton(
        color: Theme.of(context).accentColor,
        child: Text(label),
        minWidth: 150,
        onPressed: _isBtnEnabled
            ? () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (_) => widget.onButtonPress));
              }
            : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      );

  dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
