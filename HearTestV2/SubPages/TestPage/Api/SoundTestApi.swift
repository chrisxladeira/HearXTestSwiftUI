//
//  SoundTestApi.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import Foundation

class SoundTestApi {
    
    //MARK: - Fetch Account Settings
    func uploadTestResults(body : [String: Any], completion: @escaping (Bool?, ApiErrorData?, NetworkError?) ->()){
        setApiHeaders.append(ApiHeaders(headerValue: "application/json", headerKey: "Content-Type"))
        
        let requestBody = try? JSONSerialization.data(withJSONObject: body)
        
        let resource = Resource<Bool,ApiErrorData>(url: URL(string: "https://enoqczf2j2pbadx.m.pipedream.net")! , httpVerb: HttpMethod.POST,body: requestBody)
        
        ServiceHelper().load(resource: resource) { success , apiError, networkError, response  in
            if response?.statusCode == 200 {
                completion(true,nil,nil)
            }else if apiError != nil{
                completion(nil,apiError,nil)
            }else if networkError != nil{
                completion(nil,nil,networkError)
            }
        }
    }
    
}
