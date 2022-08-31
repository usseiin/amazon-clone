import 'package:amazon_app/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

import '../../../constants/constant.dart';
import '../../../provider/user_provider.dart';
import '../../../utilities/show_snack_bar.dart';
import '../../../widgets/custom_textfield.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);
  final String totalAmount;

  static const String routeName = '/address-screen';

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final GlobalKey<FormState> _addressFormKey = GlobalKey<FormState>();
  final TextEditingController _flatNoController = TextEditingController();
  final TextEditingController _areaStreetController = TextEditingController();
  final TextEditingController _pinCodeController = TextEditingController();
  final TextEditingController _townCityController = TextEditingController();
  // final TextEditingController _flatNoController = TextEditingController();
  final AddressServices _addressServices = AddressServices();

  String addressToBeUse = '';
  void onGooglePay(res) async {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      _addressServices.saveUserAddress(
          context: context, address: addressToBeUse);
    }
    _addressServices.placeOrder(
      context: context,
      address: addressToBeUse,
      totalAmount: double.parse(widget.totalAmount),
    );
  }

  void payPressed(String addressFromProvider) {
    addressToBeUse = '';

    bool isForm = _flatNoController.text.isNotEmpty ||
        _areaStreetController.text.isNotEmpty ||
        _pinCodeController.text.isNotEmpty ||
        _townCityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUse =
            '${_flatNoController.text.isNotEmpty} ${_areaStreetController.text.isNotEmpty} -${_pinCodeController.text.isNotEmpty}${_townCityController.text.isNotEmpty} ';
      } else {
        throw Exception('Please enter a value!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUse = addressFromProvider;
    } else {
      showSnackBar(context, 'Error!');
    }
  }

  List<PaymentItem> paymentItems = [];

  @override
  void initState() {
    super.initState();
    paymentItems.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  @override
  void dispose() {
    _areaStreetController.dispose();
    _flatNoController.dispose();
    _pinCodeController.dispose();
    _townCityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariable.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (address.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Center(
                      child: Text(
                        'OR',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20)
                  ],
                ),
              ),
            Form(
              key: _addressFormKey,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration:
                    const BoxDecoration(color: GlobalVariable.backgroundColor),
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Flat, House no',
                      controller: _flatNoController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Area, Street',
                      controller: _areaStreetController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Pincode',
                      controller: _pinCodeController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'Town/City',
                      controller: _townCityController,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            // const Icon(Icons.abc),
            // GooglePayButton(
            //   onPressed: () => payPressed(address),
            //   width: double.infinity,
            //   height: 50,
            //   margin: const EdgeInsets.only(top: 50),
            //   paymentConfigurationAsset: 'gpay.json',
            //   onPaymentResult: onGooglePay,
            //   paymentItems: paymentItems,
            //   style: GooglePayButtonStyle.black,
            //   type: GooglePayButtonType.buy,
            //   loadingIndicator: const Center(
            //     child: CircularProgressIndicator(),
            //   ),
            // ),
            // ApplePayButton(
            //   height: 50,
            //   paymentConfigurationAsset: 'applepay.json',
            //   onPaymentResult: onGooglePay,
            //   paymentItems: paymentItems,
            // ),
            // const Icon(Icons.abc),

            GooglePayButton(
              paymentConfigurationAsset: 'gpay.json',
              paymentItems: paymentItems,
              style: GooglePayButtonStyle.black,
              type: GooglePayButtonType.pay,
              margin: const EdgeInsets.only(top: 15.0),
              onPaymentResult: onGooglePay,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
