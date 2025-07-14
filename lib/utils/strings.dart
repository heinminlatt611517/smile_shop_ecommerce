
const kLoadingLabel = "Smile Shop";
const kHomeLabel = "Home";
const kCartLabel = "Cart";
const kLiveChatLabel = "Live Chat";
const kProfileLabel = "Profile";
const kTrendingProductsLabel = "Trending Products";
const kSearchHereHintLabel = "Search Here";
const kDailyCheckInLabel = "Daily Check in";
const kToClaimPointDailyLabel = "To claim point daily";
const kUserLevelLabel = "User Level";
const kCampaignLabel = "Campaign";
const kLetPracticeAndEnjoyLabel = "Let's practice and enjoy it.";
const kStandardDelivery = 'Standard Delivery';
const kSpecialDelivery = 'Special Delivery';
const kDoWantToDeleteAccount = "Do you want to delete account?";

///hive
const kLoginData = "LoginData";
const kUserData = "UserData";

///get storage key
const kBoxKeyReferralCode = "Referral Code";
const kBoxKeyWalletPassword = "Wallet Password";
const kBoxKeyFirebaseUserId = "FirebaseUserId";
const kBoxKeyLoginUserType = "LoginUserType";
const kBoxKeyPromotionPoint = "PromotionPoint";

String getBelow3000Text(String locale) {
  switch (locale) {
    case 'my-MM':
      return '၃၀၀၀ကျပ်အောက်';
    case 'ch':
      return '低于3000Ks';
    case 'en':
    default:
      return 'Below 3000ks';
  }
}

String getPromotionPointText(String locale) {
  switch (locale) {
    case 'my-MM':
      return 'ပရိုမိုးရှင်းပွိုင့်';
    case 'ch':
      return '促销积分';
    case 'en':
    default:
      return 'PromotionPoint';
  }
}
