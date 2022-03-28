import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm({Key? key, required this.submitRegister}) : super(key: key);

  void Function(
    String name,
    String email,
    String password,
    DateTime birthDate,
    String telephoneNumber,
    String imageUrl,
  ) submitRegister;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  String? _userEmail = "";
  String? _userPassword = "";
  String? _userName = "";
  String? _userTelephone = "";
  DateTime? _userBirthDate;
  String? _userImageUrl = "-";

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (isValid != null && isValid) {
      _formKey.currentState?.save();
      widget.submitRegister(
        _userName!,
        _userEmail!,
        _userPassword!,
        _userBirthDate!,
        _userTelephone!,
        _userImageUrl!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return "A regisztrációhoz email szükséges!";
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'Emal cím',
              ),
              onSaved: (value) {
                _userEmail = value;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 7) {
                  return "A jelszó mérete legalább 7 karakter!";
                }
                return null;
              },
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Jelszó',
              ),
              onSaved: (value) {
                _userPassword = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _trySubmit,
                    clipBehavior: Clip.hardEdge,
                    child: const Text('Regisztráció'),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    clipBehavior: Clip.hardEdge,
                    child: const Text('Mégse'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
