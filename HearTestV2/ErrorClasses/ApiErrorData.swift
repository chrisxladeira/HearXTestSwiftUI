//
//  ApiErrorData.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import Foundation

//MARK: - GetErrors
struct GetErrors : Codable {
    let get : [ApiErrorData]
}

//MARK: - ResponseMetadata
struct ResponseMetadata: Codable {
    let remainingLoginAttempts: Int
}

//MARK: - ApiErrorData
struct ApiErrorData: Codable, Error {
    let errorCode: Int?
    let code : Int?
    let errorMessage: String?
    let message : String?
    let responseMetadata: ResponseMetadata?
    let errors: [Errors]?
}

//MARK: - Errors
struct Errors: Codable{
    let field: String?
    let error: String?
}

