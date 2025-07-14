import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_my.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('my'),
    Locale('zh')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @liveChat.
  ///
  /// In en, this message translates to:
  /// **'Live Chat'**
  String get liveChat;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter phone number'**
  String get enterPhoneNumber;

  /// No description provided for @typeYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Type your password'**
  String get typeYourPassword;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @ifYouDontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t have an account,'**
  String get ifYouDontHaveAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @enterReferralCode.
  ///
  /// In en, this message translates to:
  /// **'Enter referral code'**
  String get enterReferralCode;

  /// No description provided for @ifYouAlreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'If you already have an account,'**
  String get ifYouAlreadyHaveAnAccount;

  /// No description provided for @checkYourPhone.
  ///
  /// In en, this message translates to:
  /// **'Check Your Phone'**
  String get checkYourPhone;

  /// No description provided for @weHaveHaveSendTheCodeToYourPhone.
  ///
  /// In en, this message translates to:
  /// **'We\'ve have the code to your phone'**
  String get weHaveHaveSendTheCodeToYourPhone;

  /// No description provided for @codeExpireIn.
  ///
  /// In en, this message translates to:
  /// **'Code expire in'**
  String get codeExpireIn;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @sendAgain.
  ///
  /// In en, this message translates to:
  /// **'Send Again'**
  String get sendAgain;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @setYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Set your password'**
  String get setYourPassword;

  /// No description provided for @reTypeYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-type your password'**
  String get reTypeYourPassword;

  /// No description provided for @typeYourEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Type your email address'**
  String get typeYourEmailAddress;

  /// No description provided for @trendingProducts.
  ///
  /// In en, this message translates to:
  /// **'Trending Products'**
  String get trendingProducts;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @toShip.
  ///
  /// In en, this message translates to:
  /// **'To Ship'**
  String get toShip;

  /// No description provided for @toPay.
  ///
  /// In en, this message translates to:
  /// **'To Pay'**
  String get toPay;

  /// No description provided for @toReceive.
  ///
  /// In en, this message translates to:
  /// **'To Receive'**
  String get toReceive;

  /// No description provided for @toReview.
  ///
  /// In en, this message translates to:
  /// **'To Review'**
  String get toReview;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @refund.
  ///
  /// In en, this message translates to:
  /// **'Refund'**
  String get refund;

  /// No description provided for @smileWallet.
  ///
  /// In en, this message translates to:
  /// **'Smile Wallet'**
  String get smileWallet;

  /// No description provided for @promotionPoint.
  ///
  /// In en, this message translates to:
  /// **'Promotion Point'**
  String get promotionPoint;

  /// No description provided for @promotionPoints.
  ///
  /// In en, this message translates to:
  /// **'Promotion Points'**
  String get promotionPoints;

  /// No description provided for @myFavourite.
  ///
  /// In en, this message translates to:
  /// **'My Favourite'**
  String get myFavourite;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @myTeam.
  ///
  /// In en, this message translates to:
  /// **'My Team'**
  String get myTeam;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @referralCode.
  ///
  /// In en, this message translates to:
  /// **'Referral Code'**
  String get referralCode;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @logOut.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logOut;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @doYouWantToLogoutFromTheApp.
  ///
  /// In en, this message translates to:
  /// **'Do you want to logout from the app?'**
  String get doYouWantToLogoutFromTheApp;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @searchHere.
  ///
  /// In en, this message translates to:
  /// **'Search Here'**
  String get searchHere;

  /// No description provided for @dailyCheckIn.
  ///
  /// In en, this message translates to:
  /// **'Daily Check in'**
  String get dailyCheckIn;

  /// No description provided for @userLevel.
  ///
  /// In en, this message translates to:
  /// **'User Level'**
  String get userLevel;

  /// No description provided for @campaign.
  ///
  /// In en, this message translates to:
  /// **'Campaign'**
  String get campaign;

  /// No description provided for @toClaimPointDaily.
  ///
  /// In en, this message translates to:
  /// **'To claim point daily'**
  String get toClaimPointDaily;

  /// No description provided for @letPracticeAndEnjoyIt.
  ///
  /// In en, this message translates to:
  /// **'Let\'s practice and enjoy it'**
  String get letPracticeAndEnjoyIt;

  /// No description provided for @enjoyTheMoment.
  ///
  /// In en, this message translates to:
  /// **'Enjoy the moment'**
  String get enjoyTheMoment;

  /// No description provided for @joinNow.
  ///
  /// In en, this message translates to:
  /// **'Join Now'**
  String get joinNow;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @participants.
  ///
  /// In en, this message translates to:
  /// **'Participants'**
  String get participants;

  /// No description provided for @participantsInThisCampaign.
  ///
  /// In en, this message translates to:
  /// **'Participants in this campaign'**
  String get participantsInThisCampaign;

  /// No description provided for @totalCount.
  ///
  /// In en, this message translates to:
  /// **'Total Count'**
  String get totalCount;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check In'**
  String get checkIn;

  /// No description provided for @checkInCount.
  ///
  /// In en, this message translates to:
  /// **'Check-in Count'**
  String get checkInCount;

  /// No description provided for @sendAMessage.
  ///
  /// In en, this message translates to:
  /// **'Send a message'**
  String get sendAMessage;

  /// No description provided for @thereWereNoResultTryToAddNewProduct.
  ///
  /// In en, this message translates to:
  /// **'There were no result\nTry to add a new product.'**
  String get thereWereNoResultTryToAddNewProduct;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @smilePoint.
  ///
  /// In en, this message translates to:
  /// **'Smile Point'**
  String get smilePoint;

  /// No description provided for @youHave.
  ///
  /// In en, this message translates to:
  /// **'You have'**
  String get youHave;

  /// No description provided for @recharge.
  ///
  /// In en, this message translates to:
  /// **'Recharge'**
  String get recharge;

  /// No description provided for @incomePoints.
  ///
  /// In en, this message translates to:
  /// **'Income Points'**
  String get incomePoints;

  /// No description provided for @outcomePoints.
  ///
  /// In en, this message translates to:
  /// **'Outcome Points'**
  String get outcomePoints;

  /// No description provided for @paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// No description provided for @chooseTypeOfPayment.
  ///
  /// In en, this message translates to:
  /// **'Choose type of payment.'**
  String get chooseTypeOfPayment;

  /// No description provided for @pleaseEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get pleaseEnterAmount;

  /// No description provided for @changePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change Photo'**
  String get changePhoto;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePassword;

  /// No description provided for @typeYourOldPassword.
  ///
  /// In en, this message translates to:
  /// **'Type your old password'**
  String get typeYourOldPassword;

  /// No description provided for @typeYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Type your new password'**
  String get typeYourNewPassword;

  /// No description provided for @reTypeYourNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Re-type your old password'**
  String get reTypeYourNewPassword;

  /// No description provided for @yourMembers.
  ///
  /// In en, this message translates to:
  /// **'Your members'**
  String get yourMembers;

  /// No description provided for @myAddress.
  ///
  /// In en, this message translates to:
  /// **'My Address'**
  String get myAddress;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @addressCategory.
  ///
  /// In en, this message translates to:
  /// **'Address Category'**
  String get addressCategory;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @pleaseEnterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterYourPhoneNumber;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @township.
  ///
  /// In en, this message translates to:
  /// **'Township'**
  String get township;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @setAsDefaultAddress.
  ///
  /// In en, this message translates to:
  /// **'Set as default address'**
  String get setAsDefaultAddress;

  /// No description provided for @yourReferralCodeIs.
  ///
  /// In en, this message translates to:
  /// **'Your referral code is'**
  String get yourReferralCodeIs;

  /// No description provided for @shareReferralCode.
  ///
  /// In en, this message translates to:
  /// **'Share Referral Code'**
  String get shareReferralCode;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @productSpecifications.
  ///
  /// In en, this message translates to:
  /// **'Product Specifications'**
  String get productSpecifications;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get addToCart;

  /// No description provided for @buyNow.
  ///
  /// In en, this message translates to:
  /// **'Buy Now'**
  String get buyNow;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check Out'**
  String get checkOut;

  /// No description provided for @pleaseSelectAddress.
  ///
  /// In en, this message translates to:
  /// **'Please select address'**
  String get pleaseSelectAddress;

  /// No description provided for @deliveryOptions.
  ///
  /// In en, this message translates to:
  /// **'Delivery Options'**
  String get deliveryOptions;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @payNow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get payNow;

  /// No description provided for @pleaseSelectBothColorAndSize.
  ///
  /// In en, this message translates to:
  /// **'Please select both color and size'**
  String get pleaseSelectBothColorAndSize;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search History'**
  String get searchHistory;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @availableColor.
  ///
  /// In en, this message translates to:
  /// **'Available Color'**
  String get availableColor;

  /// No description provided for @availableSize.
  ///
  /// In en, this message translates to:
  /// **'Available Size'**
  String get availableSize;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// No description provided for @usePromotion.
  ///
  /// In en, this message translates to:
  /// **'Use promotion'**
  String get usePromotion;

  /// No description provided for @noUse.
  ///
  /// In en, this message translates to:
  /// **'No Use'**
  String get noUse;

  /// No description provided for @standardDelivery.
  ///
  /// In en, this message translates to:
  /// **'Quick Delivery'**
  String get standardDelivery;

  /// No description provided for @specialDelivery.
  ///
  /// In en, this message translates to:
  /// **'Free Delivery'**
  String get specialDelivery;

  /// No description provided for @thankForShoppingWithUs.
  ///
  /// In en, this message translates to:
  /// **'Thanks for shopping with us.'**
  String get thankForShoppingWithUs;

  /// No description provided for @weAppreciateYourSupportAndHope.
  ///
  /// In en, this message translates to:
  /// **'We appreciate your support and hope you enjoy your purchase. Feel free to reach out if you need any assistance. We look forward to serving you again!'**
  String get weAppreciateYourSupportAndHope;

  /// No description provided for @yourOrderIsCompleted.
  ///
  /// In en, this message translates to:
  /// **'Your order is completed.'**
  String get yourOrderIsCompleted;

  /// No description provided for @yourOrderIsShipping.
  ///
  /// In en, this message translates to:
  /// **'Your order is shipping.'**
  String get yourOrderIsShipping;

  /// No description provided for @yourOrderIsOnTheWay.
  ///
  /// In en, this message translates to:
  /// **'Your order is on the way.'**
  String get yourOrderIsOnTheWay;

  /// No description provided for @yourOrderTracking.
  ///
  /// In en, this message translates to:
  /// **'Your Order Tracking'**
  String get yourOrderTracking;

  /// No description provided for @startDelivery.
  ///
  /// In en, this message translates to:
  /// **'Start Delivery'**
  String get startDelivery;

  /// No description provided for @inTransit.
  ///
  /// In en, this message translates to:
  /// **'In Transit'**
  String get inTransit;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @rechargeSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Recharge Successful'**
  String get rechargeSuccessful;

  /// No description provided for @yourWalletHasBeenSuccessfullyRecharged.
  ///
  /// In en, this message translates to:
  /// **'Your wallet has been successfully recharged, and the updated balance is now available for use. Thank you for choosing our service!'**
  String get yourWalletHasBeenSuccessfullyRecharged;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @firstAndLastName.
  ///
  /// In en, this message translates to:
  /// **'First & Last Name'**
  String get firstAndLastName;

  /// No description provided for @campaignNotification.
  ///
  /// In en, this message translates to:
  /// **'Campaign Notification'**
  String get campaignNotification;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @package.
  ///
  /// In en, this message translates to:
  /// **'Package'**
  String get package;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @goldPackageDealer.
  ///
  /// In en, this message translates to:
  /// **'Gold Package Dealer'**
  String get goldPackageDealer;

  /// No description provided for @currentProgress.
  ///
  /// In en, this message translates to:
  /// **'Current Progress'**
  String get currentProgress;

  /// No description provided for @goldPackage.
  ///
  /// In en, this message translates to:
  /// **'Gold Package'**
  String get goldPackage;

  /// No description provided for @diamondPackage.
  ///
  /// In en, this message translates to:
  /// **'Diamond Package'**
  String get diamondPackage;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @editMyAddress.
  ///
  /// In en, this message translates to:
  /// **'Edit My Address'**
  String get editMyAddress;

  /// No description provided for @deleteAddress.
  ///
  /// In en, this message translates to:
  /// **'Delete Address'**
  String get deleteAddress;

  /// No description provided for @productRefund.
  ///
  /// In en, this message translates to:
  /// **'Product Refund'**
  String get productRefund;

  /// No description provided for @youNeedToSendYourRefundItem.
  ///
  /// In en, this message translates to:
  /// **'You need to send your refund item to our address.'**
  String get youNeedToSendYourRefundItem;

  /// No description provided for @chooseRefundReason.
  ///
  /// In en, this message translates to:
  /// **'Choose refund reason'**
  String get chooseRefundReason;

  /// No description provided for @uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Photo'**
  String get uploadPhoto;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @yourOrderIsCanceled.
  ///
  /// In en, this message translates to:
  /// **'Your order is canceled'**
  String get yourOrderIsCanceled;

  /// No description provided for @yourOrderHasBeenDeliveredOn.
  ///
  /// In en, this message translates to:
  /// **'Your order has been delivered on.'**
  String get yourOrderHasBeenDeliveredOn;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// No description provided for @doYouWantToDeleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete your account? This action cannot be undone'**
  String get doYouWantToDeleteAccount;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notification;

  /// No description provided for @need_login.
  ///
  /// In en, this message translates to:
  /// **'You need to log in to use this feature.'**
  String get need_login;

  /// No description provided for @leftReferralCodeEmpty.
  ///
  /// In en, this message translates to:
  /// **'If you don\'t have a referral code, leave it blank.'**
  String get leftReferralCodeEmpty;

  /// No description provided for @toViewMyTeamMembers.
  ///
  /// In en, this message translates to:
  /// **'To view my team members'**
  String get toViewMyTeamMembers;

  /// No description provided for @doubleTapToZoom.
  ///
  /// In en, this message translates to:
  /// **'Double Tap to Zoom In/Out'**
  String get doubleTapToZoom;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @inWareHouse.
  ///
  /// In en, this message translates to:
  /// **'In Warehouse'**
  String get inWareHouse;

  /// No description provided for @onGoing.
  ///
  /// In en, this message translates to:
  /// **'Start Deliver'**
  String get onGoing;

  /// No description provided for @toViewMyWallet.
  ///
  /// In en, this message translates to:
  /// **'To view my wallet'**
  String get toViewMyWallet;

  /// No description provided for @pickUp.
  ///
  /// In en, this message translates to:
  /// **'Pick Up'**
  String get pickUp;

  /// No description provided for @findMyPickUp.
  ///
  /// In en, this message translates to:
  /// **'Find My Pickup'**
  String get findMyPickUp;

  /// No description provided for @coupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get coupon;

  /// No description provided for @deliveryFee.
  ///
  /// In en, this message translates to:
  /// **'Delivery Fee'**
  String get deliveryFee;

  /// No description provided for @subTotal.
  ///
  /// In en, this message translates to:
  /// **'Sub Total'**
  String get subTotal;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @detailAddress.
  ///
  /// In en, this message translates to:
  /// **'Detail Address'**
  String get detailAddress;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'my', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'my':
      return AppLocalizationsMy();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
