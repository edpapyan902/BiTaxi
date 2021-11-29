//
//  Constants.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/22/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import Foundation

let BASE_URL = "https://bi-taxi.com/api/"
let URL_LOGIN = "\(BASE_URL)sign_in_as_client_by_mobile"
let URL_REGISRER = "\(BASE_URL)signup_as_client"
let URL_ABOUT = "\(BASE_URL)pages"
let URL_CITIES = "\(BASE_URL)city"
let URL_NATIONALITY = "\(BASE_URL)nationality"
let URL_UPDATE_PASSWORD = "\(BASE_URL)update_password"
let URL_UPDATE_PROFILE = "\(BASE_URL)profile/edit"
let URL_CREATE_ORDER = "\(BASE_URL)order/create"
let URL_Pendding_ORDERS = "\(BASE_URL)order/client/wait"
let URL_privacy_policy = "\(BASE_URL)privacy_policy"
let URL_terms_of_use = "\(BASE_URL)terms_of_use"






//user defaults
let TOKEN_KEY = "api_token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "email"
let USER_NAME = "name"
let EMAIL = "userEmail"
let NAME = "userName"
let PHONE = "userPhone"

typealias CompletionHandle = (_ success: Bool)->()

let HEADER = [ "Content-Type": "application/json; charset=utf-8", "Accept": "application/json; charset=utf-8"]
let BEARER_HEADER = [
    "Content-Type": "application/json; charset=utf-8",
    "Accept": "application/json; charset=utf-8",
    "Authorization": "Bearer \(AuthManger.instance.authToken)"]


