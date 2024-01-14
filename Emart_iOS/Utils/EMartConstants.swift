//
//  EMartConstants.swift
//  EMart
//
//  Created by Asad Khan on 5/18/21.
//  Copyright © 2021 Apple. All rights reserved.
//

import Foundation

// var imageBaseURL = "https://emart.pkgadget.com/images/"


struct Keys {
//    static let GOOGLE_API_KEY = "AIzaSyCBrOipfCVcpJvFgtY2qyLfphnFZLr-aLA"
    static let GOOGLE_API_KEY = "AIzaSyCQV8jcCrGzKrVtDbjHISZLvj-560ieAzE"

    //static let My_GOOGLE_KEY = "AIzaSyAF4ZxJN5Zluf7zKRcp3atE2VksqXvSu48" // Used only for testing
}

struct BASEURL {
    //static let url = "https://emart.pkgadget.com/api/"
    //static let imageUrl = "https://emart.pkgadget.com/images/"
    
    static let url = "https://edelivero.com/api/"
    static let imageUrl = "https://edelivero.com/images/"
    
}

struct URLPath {
    static let GetRestaurantCategories = "\(BASEURL.url)showFoodCategory.php"//BASEURL.url + "showFoodCategory.php"
    static let GetResturantProducts = "\(BASEURL.url)showProducts.php"//BASEURL.url + "showProducts.php"
    
    static let GetSliderImages = "\(BASEURL.url)showSliders.php"
    
    static let GetUserOrders = "\(BASEURL.url)getOrdersUsers.php"
    
    static let GetOrderItems = "\(BASEURL.url)showOrderItems.php"
    
    static let LoginUser = "\(BASEURL.url)login.php"
    
    
    static let RegisterUser = "\(BASEURL.url)register.php"
    
    static let SearchProducts = "\(BASEURL.url)searchProducts.php"
    
    static let ShowAddresses = "\(BASEURL.url)showAddresses.php"

    static let ShowCartProducts = "\(BASEURL.url)showCartProducts.php"
    
    static let Feedback = "\(BASEURL.url)Feedback.php"
    
    static let GetNotifications = "\(BASEURL.url)showNotifications.php"

    
    static let AddAddress = "\(BASEURL.url)addAddress.php"
    static let RemoveAddress = "\(BASEURL.url)removeAddress.php"
    
    static let AddToCart = "\(BASEURL.url)addToCart.php"
    static let UpdateCart = "\(BASEURL.url)updateCartItemQuantity.php"
    static let AddCoupon = "\(BASEURL.url)addCoupon.php"
    static let AddOrder = "\(BASEURL.url)addOrder.php"
    static let AddFavourite = "\(BASEURL.url)addFavorites.php"
    static let GetResturants = "\(BASEURL.url)showVendors.php"
    static let RemovetoCart = "\(BASEURL.url)removetoCart.php"
    static let OrderCancle = "\(BASEURL.url)orderCancleUser.php"
    
    static let ShowFavourite = "\(BASEURL.url)showFavorites.php"
    
    
    static let AddVendorReview = "\(BASEURL.url)addVendorReview.php"
    
    static let riderDetails = "\(BASEURL.url)showOrderDetails.php"
    static let tokenDetail = "\(BASEURL.url)updateToken.php"
    
    
    static let updateProfile = "\(BASEURL.url)updateProfile.php"
    
    static let mainCategories = "\(BASEURL.url)showMainCategory.php"
    static let subCategories = "\(BASEURL.url)showSubCategories.php"
    
    static let resturantRating = "\(BASEURL.url)showVendorReviews.php"
    static let userVouchers = "\(BASEURL.url)showVouchers.php"
    
    static let readNotification = "\(BASEURL.url)readNotification.php"
    
    static let readAllNotifications = "\(BASEURL.url)readAllNotifications.php"
    
    
}


// UserDefault
let userDefault = UserDefaults.standard

// Notification Center
let notificationCenter = NotificationCenter.default

struct UserDefaultKey {
    
    static let kIsLogin = "isLogin"
    static let kToken = "token"
    
    static let kEmail = "emailId"
    static let kUID = "uid"
    static let kUName = "name"
    static let kUserProfile = "UserProfile"
    static let kUser = "User"
    static let kIsUserLoggedIn = "isUserLoggedIn"
    static let kIsLaunched = "isLaunched"
    static let kChildMode = "childMode"
    static let kChildModeTipView = "childModeTipView"
    static let kBedTime = "bedtime"
    static let kInfoButton = "infoButton"
    static let kDeviceID = "device_id"
    
    
    static let kNotificationState = "NotificationState"
    
    
    static let kCountries = "Countries"
    static let kSelectedCountries = "SelectedCountry"
    
    static let kIsCountriesFetched = "isCountryFetched"
    static let kIsCategoriesFetched = "isCategoriesFetched"
    
    static let kCurrency = "Currency"
    static let kIsCurrencyFetched = "isCurrencyFetched"
    
    
    static let kCategory = "Category"
    static let kSettings = "Settings"
   // static let kIsCurrencyFetched = "isCurrencyFetched"
}
