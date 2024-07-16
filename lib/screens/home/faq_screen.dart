import 'package:faded_dreamers/models/faq_model.dart';
import 'package:faded_dreamers/utils/colors.dart';
import 'package:faded_dreamers/utils/dimensions.dart';
import 'package:faded_dreamers/widgets/space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {

  var searchController = TextEditingController();

  List<FaqModel> allFaqs = [
    FaqModel(
        question: "WHAT ARE YOUR HOURS OF OPERATION?",
        answer: "Orders can be placed at any time, however orders placed before 1PM PST typically will be sent out the same day. Orders placed after 1PM PST will be sent out the following day. Orders placed on the weekend will be sent out the following Monday. Email/Live Chat hours are Monday – Friday from 9AM – 7PM PST."
    ),
    FaqModel(
        question: "HOW DO I PLACE AN ORDER?",
        answer: "Visit the “Products” page and review our products by clicking the product title. Hover over a product and select “ADD TO CART” or “SELECT OPTIONS” to choose the weight/flavour of the product; then “ADD TO CART”. Click the “CART” or “VIEW CART” when you are done and review your order. Remove items by clicking the “X” button. Add/reduce quantities by clicking the “+” and “-“ buttons beside a product. Click “UPDATE CART”. Click “PROCEED TO CHECKOUT” when ready. Review your billing details, shipping details and order details. Before placing your order, you need to read and accept our terms & conditions. Choose “PLACE ORDER” when you are done; if your purchase fails, you may need to set up an ACCOUNT before you can order products. Check your email for a confirmation letter and next steps to issue an E-Transfer. Send your E-Transfer and make sure it was processed. We will then process and ship your order."
    ),
    FaqModel(
        question: "IS THERE A MINIMUM ORDER?",
        answer: "We do not have a minimum order, however orders less than \$150 will be charged a flat rate of \$20 for shipping."
    ),
    FaqModel(
        question: "REFUNDS OR EXCHANGES",
        answer: "All consumable purchases are final, no refunds or exchanges. Non-consumable related issues will be looked at case by case."
    ),
    FaqModel(
        question: "WHAT ARE THE PAYMENT METHODS ACCEPTED?",
        answer: "Currently, we accept Email Transfers & Bitcoin. Please follow the instructions below, or contact your banking branch directly for further assistance."
    ),
    FaqModel(
        question: "HOW DO I SEND AN E TRANSFER PAYMENT?",
        answer: "Register for online banking with your bank. This can be done online, or if you need assistance call your branch directly. Locate the E-Transfers section in online banking. Add our email provided along with the total amount shown on the invoice. We will provide you with a secret word for the transfer. The secret word and instructions will be given once you have checked out. Please read carefully."
    ),
    FaqModel(
        question: "HOW MUCH IS CHARGED IN TAXES?",
        answer: "Taxes are already included in our prices!"
    ),
    FaqModel(
        question: "WHAT ARE THE SHIPPING CHARGES?",
        answer: "Orders over \$150 after any credits/discounts qualify for free shipping, otherwise shipping charges have a flat rate of \$20.00."
    ),
    FaqModel(
        question: "I HAVE NOT RECEIVED MY TRACKING ORDER?",
        answer: "Once you have made an order and the payment has been processed, your package will be sent out for delivery. Payments accepted before 1PM PST will likely be sent out the same day. Payments accepted after 1PM PST will be sent the following day. Once the Shipping Carrier has scanned the package, we will provide you with your tracking in an email."
    ),
    FaqModel(
        question: "WHY IS MY TRACKING NUMBER INVALID?",
        answer: "It can take up to 48 hours for tracking numbers to be updated with the Shipping Carrier. If after 48 hours the tracking still does not work, feel free to contact us at (our email)."
    ),
    FaqModel(
        question: "MY PACKAGE IS BEING SENT TO ANOTHER LOCATION LOOKING AT MY TRACKING NUMBER?",
        answer: "There could be a number of reasons: the Shipping Carrier could have entered the wrong postal code as they see a significant number of packages every day. The information you provided us was incorrect. Please double-check your shipping information and make sure that the information provided is correct. This may cause a delay of an additional 1-2 business days (Note we do not issue refunds if you provide us with the wrong delivery address)."
    ),
    FaqModel(
        question: "WRONG/INVALID ADDRESS?",
        answer: "INCORRECT SHIPPING ADDRESS: In the case where an incorrect shipping address was provided by the customer for the order which results in an unsuccessful delivery, the customer is responsible for the shipping charge incurred for the delivery, as well as the shipping cost charged to Faded Dreamers by the carrier for the return delivery. Please note that while we try our best to catch errors in delivery addresses before the package is shipped, neither the Shipping Carrier nor Faded Dreamers is responsible for correcting an incorrect delivery address submitted and it is the sole responsibility of the customer to ensure the delivery address provided is correct and deliverable by the Shipping Carrier. A deliverable address by the Shipping Carrier refers to the correct combination of Street #, Street name, unit or PO Box# (if applicable), City, province, and postal code. An additional \$20.00 will be needed to resend the package if deemed incorrect address."
    ),
  ];

  List<FaqModel> filteredFaqs = [];

  @override
  void initState() {
    super.initState();
    filteredFaqs = allFaqs;
    searchController.addListener(() {
      filterFaqs();
    });
  }

  void filterFaqs() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredFaqs = allFaqs.where((faq) {
        return faq.question.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // top
           SizedBox(
             width: double.maxFinite,
             height: Dimensions.height240 + Dimensions.height15,
             child:  Stack(
               children: [
                 Container(
                   width: double.maxFinite,
                   height: Dimensions.height240 + Dimensions.height15,
                   decoration:const BoxDecoration(
                     image:  DecorationImage(
                       image: AssetImage(
                         'assets/images/bg1.png',
                       ),
                       fit: BoxFit.fill,
                     ),
                   ),
                 ),
                 Container(
                   width: double.maxFinite,
                   height: Dimensions.height240 + Dimensions.height15,
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                       begin: Alignment.topCenter,
                       end: Alignment.bottomCenter,
                       colors: [
                         Colors.black.withOpacity(0.2),
                         Colors.black.withOpacity(0.3),
                       ],
                     ),
                   ),
                   child: Column(
                     children: [
                       // space
                       Spacing(
                         height: Dimensions.height50,
                       ),
                       // arrow back and faqs
                       GestureDetector(
                         onTap: (){
                           HapticFeedback.lightImpact();
                           Get.back();
                         },
                         child: Container(
                           margin: EdgeInsets.symmetric(
                             horizontal: Dimensions.width20,
                           ),
                           child: Row(
                             children: [
                               // arrow back
                               Icon(
                                 Icons.arrow_back_ios_new,
                                 color: AppColors.whiteColor,
                                 size: Dimensions.iconSize24,
                               ),
                               // spacing
                               Spacing(
                                 width: Dimensions.width10,
                               ),
                               // faqs
                               Text(
                                 'FAQs',
                                 style: TextStyle(
                                   color: AppColors.whiteColor,
                                   fontSize: Dimensions.font26,
                                   fontWeight: FontWeight.w600,
                                   fontFamily: 'Inter',
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ),
                       // space
                       Spacing(
                         height: Dimensions.height20,
                       ),
                       // faq image
                       Center(
                         child: Container(
                           height: Dimensions.height100 + Dimensions.height10,
                           width: Dimensions.width140,
                           decoration: const BoxDecoration(
                             image: DecorationImage(
                               image: AssetImage(
                                 'assets/images/faq.png',
                               ),
                               fit: BoxFit.fill,
                             ),
                           ),
                         ),
                       ),
                       // space
                       Spacing(
                         height: Dimensions.height5,
                       ),
                       // how can we help you?
                       Text(
                         'How can we help you?',
                         style: TextStyle(
                           color: AppColors.whiteColor,
                           fontSize: Dimensions.font23,
                           fontWeight: FontWeight.w400,
                           fontFamily: 'Poppins',
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
            // space
            Spacing(
              height: Dimensions.height10,
            ),
            // faqs
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      // faqs
                      Text(
                        'FAQs',
                        style: TextStyle(
                          color: AppColors.tertiaryColor,
                          fontFamily: 'Inter',
                          fontSize: Dimensions.font20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      // space
                      Spacing(
                        height: Dimensions.height5,
                      ),
                      // thick line
                      Container(
                        height: Dimensions.height5,
                        width: Dimensions.width50 + Dimensions.width10,
                        color: AppColors.tertiaryColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // space
            Spacing(
              height: Dimensions.height10,
            ),
            // search
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
              ),
              child: TextField(
                controller: searchController,
                cursorColor: AppColors.mainColor,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(Dimensions.radius10),
                  ),
                  filled: true,
                  fillColor: AppColors.greyColor1,
                  hintText: 'Search for answers',
                ),
              ),
            ),
            // faqs
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Dimensions.width20,
              ),
              child:  ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredFaqs.length,
                itemBuilder: (context, index) {
                  FaqModel faq = filteredFaqs[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                      vertical: Dimensions.height10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightBlueWhite,
                      borderRadius: BorderRadius.circular(Dimensions.radius10),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'Q: ${faq.question}',
                      style: TextStyle(
                        color: AppColors.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: Dimensions.font18,
                      ),),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width5,
                            vertical: Dimensions.height5,
                          ),
                          child: Text(faq.answer),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
