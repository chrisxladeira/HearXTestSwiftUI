//
//  ErrorHandler.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import Foundation

//MARK: Network errors
enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
    case networkError
    case InvalidUserNameOrPassword
    
    func displayErrorCode() -> String {
        switch self {
        case .decodingError:
            return NSLocalizedString(UserFriendlyNetworkErrors.decodeingError.rawValue, comment: "DecodingError")
        case .domainError:
            return NSLocalizedString(UserFriendlyNetworkErrors.domainError.rawValue, comment: "DomainError")
        case .urlError:
            return NSLocalizedString(UserFriendlyNetworkErrors.urlError.rawValue, comment: "UrlError")
        case .networkError:
            return NSLocalizedString(UserFriendlyNetworkErrors.networkError.rawValue, comment: "NetworkError")
        default:
            return "Need to create error discription"
        }
    }
}

//MARK: - User Friendly Network Errors
enum UserFriendlyNetworkErrors: String {
    case errorTitle = "Error"
    case decodeingError = "We having trouble reading the app data."
    case domainError    = "Problem retriving app data."
    case urlError       = "Issue connecting to our servers."
    case networkError   = "No network connection."
    
}


//MARK: User Errors
enum UserError: Error {
    case errorTitle
    case invalidPasswordTitle
    case emptyFieldsError
    case emptyFieldError
    case invalidMobileNumberError
    case invalidPasswordFormatError
    case invalidEmailError
    case invalidBiometrics
    case logoutError
    case mobileNuberExists
    case pageDoesntExist
    case navigationRouteDoesntExist
    case whatsAppNotAcecible
    case whatsAppUnavailableTitle
    case whatsAppUnavailable
    
    //MARK: - Display User Error Code
    func displayUserErrorCode() -> String {
        switch self {
        case .errorTitle :
            return NSLocalizedString(UserFriendlyNetworkErrors.errorTitle.rawValue, comment: "errorTitle")
        case .invalidPasswordTitle:
            return NSLocalizedString(UserFriendlyError.invalidPasswordTitle.rawValue, comment: "invalidPasswordTitle")
        case .emptyFieldsError:
            return NSLocalizedString(UserFriendlyError.emptyFieldsError.rawValue, comment: "emptyFieldsError")
        case .emptyFieldError:
            return NSLocalizedString(UserFriendlyError.emptyFieldError.rawValue, comment: "emptyFieldError")
        case .invalidMobileNumberError:
            return NSLocalizedString(UserFriendlyError.invalidMobileNumberError.rawValue, comment: "invalidMobileNumberError")
        case .invalidBiometrics:
            return NSLocalizedString(UserFriendlyError.invalidBiometrics.rawValue, comment: "invalidBiometrics")
        case .logoutError:
            return NSLocalizedString(UserFriendlyError.logoutError.rawValue, comment: "logoutError")
        case .invalidPasswordFormatError:
            return NSLocalizedString(UserFriendlyError.invalidPasswordFormatError.rawValue, comment: "invalidPasswordFormatError")
        case .invalidEmailError:
            return NSLocalizedString(UserFriendlyError.invalidemailError.rawValue, comment: "invalidEmailError")
        case .mobileNuberExists:
            return NSLocalizedString(UserFriendlyError.mobileNuberExists.rawValue, comment: "mobileNuberExists")
        case .pageDoesntExist :
            return NSLocalizedString(UserFriendlyError.pageDoesntExist.rawValue, comment: "pageDoesntExist")
        case .navigationRouteDoesntExist :
            return NSLocalizedString(UserFriendlyError.navigationRouteDoesntExist.rawValue, comment: "navigationRouteDoesntExist")
        case .whatsAppNotAcecible :
            return NSLocalizedString("Having a problem accessing WhatsApp.", comment: "whatsAppNotAcecible")
        case .whatsAppUnavailableTitle :
            return NSLocalizedString("WhatsApp unavailable", comment: "whatsAppUnavailableTitle")
        case .whatsAppUnavailable :
            return NSLocalizedString("The app cant be found on your device please make sure you do have whatsapp installed.", comment: "whatsAppUnavailable")
        }
    }
}

//MARK: - User Friendly Error
enum UserFriendlyError: String {
    case invalidPasswordTitle = "Invalid password"
    case emptyFieldsError = "Please complete all fields"
    case emptyFieldError = "Field can't be empty"
    case invalidMobileNumberError = "Please Enter a Valid Mobile Number"
    case invalidPasswordFormatError = "Please enter an alpha-numeric password containing 5-10 characters"
    case invalidemailError = "Please Enter a Valid Email Address"
    case invalidBiometrics = "Biometrics data not valid."
    case logoutError = "There seems to be an issue. Please try again"
    case mobileNuberExists = "This number is already registered"
    case pageDoesntExist = "The page does not exist"
    case navigationRouteDoesntExist = "This navigation route does not exist and isnt configured."
}


//MARK: - Error Handler
class ErrorHandler{
    
    //MARK: Display API Errors
    func DisplayApiErrorCode(APIError: ApiErrorData) -> String{
        let Error = APIError.errorMessage ?? (APIError.message ?? "")
        switch Error {
        case "InvalidUserNameOrPassword" :
            return NSLocalizedString("Invalid user name or password", comment: "API Error")
        case "InvalidAuthorizationCredentials":
            return NSLocalizedString("Invalid authorization credentials", comment: "API Error")
        case "CodeRequestLimitReached" :
            return NSLocalizedString("OTP Code Request Limit Reached", comment: "API Error")
        case "PlayerAccountLocked":
            return NSLocalizedString("Player Account Locked", comment: "playerAccountLocked")
        case "InvalidPassword" :
            return NSLocalizedString("Invalid Password", comment: "InvalidPassword")
        case "AccountOrPasswordMismatch" :
            return NSLocalizedString("Account Or Password Mismatch", comment: "AccountOrPasswordMismatch")
        case "ModelStateError" :
            return DisplayModelStateError(Error: APIError.errors?[0].error ?? "")
        case "GeneralError":
            return NSLocalizedString("General Error", comment: "GeneralError")
        case "LoginLimitReached":
            return NSLocalizedString("Login Limit Reached", comment: "LoginLimitReached")
        default:
            return "Need to create error discription"
        }
    }
    
    //MARK: - Display Model State Error
    func DisplayModelStateError(Error: String) -> String{
        switch Error {
        case "invalid.subject" :
            return NSLocalizedString("Please select query type", comment: "invalid.subject")
        case "invalid.emailaddress" :
            return NSLocalizedString("Please insert a valid email address", comment: "invalid.emailaddress")
        case "invalid.mobilenumber" :
            return NSLocalizedString("please insert a valid mobile number", comment: "invalid.mobilenumber")
        case "invalid.querydescription" :
            return NSLocalizedString("Query cant be empry", comment: "invalid.querydescription")
        default:
            return "Need to create model state error discription"
        }
    }
    
    static func validateReferralCode(value: String, regexCode : String) -> Bool {
            let codeTest = NSPredicate(format: "SELF MATCHES %@", regexCode)
            let result =  codeTest.evaluate(with: value)

            return result
        }
}
