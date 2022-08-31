import 'package:amazon_app/features/account/services/account_service.dart';
import 'package:amazon_app/features/account/widgets/account_button.dart';
import 'package:flutter/cupertino.dart';

class TopButtons extends StatelessWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: AccountButton(btntext: "Your Order", onTap: () {})),
            Expanded(
                child: AccountButton(btntext: "Turn seller", onTap: () {})),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: AccountButton(
                btntext: "Log Out",
                onTap: () => AccountService().logOut(context),
              ),
            ),
            Expanded(
              child: AccountButton(
                btntext: "Your Wish List",
                onTap: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
