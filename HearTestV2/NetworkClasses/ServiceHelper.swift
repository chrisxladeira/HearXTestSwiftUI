//
//  ServiceHelper.swift
//  HearTestV2
//
//  Created by Christopher  Ladeira  on 2025/03/30.
//

import Foundation

import Foundation
import UIKit

var setApiHeaders = [ApiHeaders?]()

//MARK: - HttpMethod
enum HttpMethod: String {
    case GET     = "GET"
    case POST    = "POST"
    case PUT     = "PUT"
    case DELETE  = "DELETE"
    case PATCH   = "PATCH"
}

//MARK: - Resource
struct Resource<T:Codable, E:Codable> {
    let url: URL
    var httpVerb: HttpMethod = .GET
    var body: Data? = nil
}

//MARK: - ApiHeaders
struct ApiHeaders: Codable {
    let headerValue : String
    let headerKey : String
}

//T and E is for different decoding object
//MARK: - Service Helper
class ServiceHelper {
    func load<T,E>(resource: Resource<T,E>, completion: @escaping(T?,E?, NetworkError?, HTTPURLResponse?) -> Void){
            var request         = URLRequest(url: URL(string: resource.url.absoluteString ) ?? resource.url)
            request.httpMethod  = resource.httpVerb.rawValue
            request.httpBody    = resource.body
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            for value in setApiHeaders{
                request.addValue(value?.headerValue ?? "", forHTTPHeaderField: value?.headerKey ?? "")
            }
            if setApiHeaders.count > 0{
                setApiHeaders.removeAll()
            }
            
            
            URLSession.shared.dataTask(with: request){ data, response, error in
                
                guard let data = data, error == nil else{
                    completion(nil,nil,.domainError,response as? HTTPURLResponse)
                    return
                }
                
                print("📕 API Data : \(String(decoding: data, as: UTF8.self))")
                
                let results = try? JSONDecoder().decode(T.self, from: data)
                if let results = results {
                    
                    completion(results, nil, nil,response as? HTTPURLResponse)
                    return
                }
                
                if results == nil{
                    print("⛔️ API Error : \(String(describing: results)))")
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode != 200{

                        }
                    }
                    let errorresults = try? JSONDecoder().decode(E.self, from: data)
                    if let errorresults = errorresults {
                        completion(nil, errorresults, nil,response as? HTTPURLResponse)
                        return
                    }
                }
                print("⛔️ Header Response : \(String(describing: response)))")
                completion(nil,nil,.decodingError,response as? HTTPURLResponse)
                
            }.resume()
    }
}
