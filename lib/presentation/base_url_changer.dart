import 'package:flutter/material.dart';
import 'package:noya_app/core/provider.dart';
import 'package:noya_app/presentation/tabs/counsultant/counslatunt_text_filds.dart';
import 'package:noya_app/core/resuable_comp/myBotton.dart';
import 'package:noya_app/core/resuable_comp/toast_message.dart';
import 'package:noya_app/core/shared_prefrnces.dart';
import 'package:provider/provider.dart';

class BaseUrlScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Load the current baseUrl from DataProvider
    _controller.text = Provider.of<DataProvider>(context).baseUrl;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Change Base URL'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
spacing: 10,
          mainAxisSize:MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter new Base URL',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              label: 'Base URL', controller: _controller,),

            const SizedBox(height: 20),

            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: MyButton(label: 'Save', onPressed: () async {
                    String newBaseUrl = _controller.text;
                    await SharedPrefsService.saveBaseUrl(newBaseUrl);
                    Provider.of<DataProvider>(context, listen: false).changeBaseUrl(newBaseUrl);
                    toastMessage(message: "Base URL updated!", tybeMessage: TybeMessage.positive);
                    Navigator.pop(context);
                  },),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
