//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by sid almekhlfi on 13/06/2020.
//  Copyright © 2019 saeed almekhlfi. All rights reserved.
//

import Foundation

class TMDBClient {
    
    static let apiKey = "6caa4d8bb93aac8f8712bc1ba4edd62d"
    
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        
        case getWatchlist
        case getfavorite
        case getRequestToken
        case login
        case creatSessionId
        case webAthu
        case logout
        case search(String)
        case markWatchList
    
        var stringValue: String {
            switch self {
            case .getWatchlist: return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .getfavorite:return Endpoints.base + "/account/\(Auth.accountId))/favorite/movies"+Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .getRequestToken: return Endpoints.base + "/authentication/token/new" + Endpoints.apiKeyParam
            case .login:return Endpoints.base + "/authentication/token/validate_with_login" + Endpoints.apiKeyParam
            case .creatSessionId : return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam
            case .webAthu:return"https://www.themoviedb.org/authenticate/\(Auth.requestToken)?redirect_to=themoviemanager:authenticate"
            case .logout:return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam
            case .search(let query):return Endpoints.base + "/search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed) ?? "")"
             case .markWatchList: return Endpoints.base + "/account/\(Auth.accountId)/watchlist" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            
                }
                   }
                   
                   var url: URL {
                       return URL(string: stringValue)!
                   }
   
    }
    
    
    class func taskForGetRequest<ResponseTyps:Decodable>(url:URL ,ResponseType:ResponseTyps.Type , completion : @escaping(ResponseTyps? ,Error?)-> Void){
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                             guard let data = data else {
                                DispatchQueue.main.async {
                                     completion(nil, error)
                                }
                                
                                 return
                             }
                             let decoder = JSONDecoder()
                             do {
                                let responseObject = try decoder.decode(ResponseTyps.self, from: data)
                                DispatchQueue.main.async {
                                     completion(responseObject, nil)
                                }
                              
                         
                             } catch {
                                DispatchQueue.main.async {
                                     completion(nil, error)
                                }
                                
                             }
                         }
                         task.resume()
        
    }
    
    class func taskForPostRequest<ResponseTypes:Decodable,RequestTyps:Encodable>(url:URL,ResponseType:ResponseTypes.Type,body:RequestTyps,completion:@escaping(ResponseTypes?, Error?)-> Void){
        
               var request = URLRequest(url:url)
               request.httpMethod = "POST"
               request.httpBody = try! JSONEncoder().encode(body)
               request.addValue("application/json",forHTTPHeaderField: "Content-Type")
              let tasks = URLSession.shared.dataTask(with: request) { (data, respone, error) in
                   guard let data = data else {
                    DispatchQueue.main.async {
                          completion(nil, error)
                    }
                       return
                   }
                 let decoder = JSONDecoder()
                   do{
                     
                    let responObject = try decoder.decode(ResponseTypes.self, from: data)
                    DispatchQueue.main.async {
                          completion(responObject, nil)
                    }
                     
                   }catch {
                             
                         DispatchQueue.main.async {
                            completion(nil, error)
                    }
                   
                   }

               }
              
               tasks.resume()
    }
    
    
    class func login(username:String , password:String , completion : @escaping(Bool , Error?)-> Void ){
       let body = LoginRequest(username:username,password:password,requestToken:Auth.requestToken)
        taskForPostRequest(url:Endpoints.login.url, ResponseType:RequestTokenResponse.self, body: body) { (response, error) in
            if let response = response {
                Auth.requestToken = response.requestToken
               completion(true,nil)
            } else {
                completion(false,nil)
            }
        }
        
    }
    
    
    class func logout(completion : @escaping ()-> Void ){
        var request = URLRequest(url: Endpoints.logout.url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = LogoutRequest(sessionId: Auth.sessionId)
        request.httpBody = try! JSONEncoder().encode(body)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            Auth.requestToken = ""
            Auth.sessionId = ""
            completion()
            
        }
        task.resume()
    
    }
    
    

    
    
    
               
    class func getRequestToken (completion : @escaping (Bool, Error?)-> Void ){
        
        taskForGetRequest(url: Endpoints.getRequestToken.url, ResponseType: RequestTokenResponse.self) { (response, error) in
            if let response = response {
                  Auth.requestToken = response.requestToken
                completion(true ,nil)
                                
            } else {
               completion(false ,error)
            }
            
        }
       
    }
    
    
    
    
    class func getfavorites(completion: @escaping([Movie],Error?)->Void){
        taskForGetRequest(url: Endpoints.getfavorite.url, ResponseType: MovieResults.self) { (response, error) in
            if let response = response {
                completion(response.results , nil)
            } else {
                completion([] , error)
                
            }
        }
    }
               class func getWatchlist(completion: @escaping ([Movie], Error?) -> Void) {
                
                taskForGetRequest(url: Endpoints.getWatchlist.url, ResponseType: MovieResults.self) { (response, error) in
                    if let response = response {
                        completion(response.results ,  nil)
                    } else {
                        completion([] , error)
                        
                    }
                }
                   
               }
    
            class func CreateSession (completion: @escaping (Bool, Error?)->Void){
                 let body = PostSession(requestToken: Auth.requestToken)
                taskForPostRequest(url: Endpoints.creatSessionId.url, ResponseType: SessionResponse.self, body: body) { (response, error) in
                    if let response = response {
                        Auth.sessionId = response.sessionId
                        completion(true,nil)
                    } else {
                         completion(false,error)
                        
                    }
                }
                  
        
        
             }
    
    class func search( query:String , completion : @escaping([Movie],Error?)->Void ){
        taskForGetRequest(url: Endpoints.search(query).url, ResponseType: MovieResults.self) { (response, error) in
            if let response = response {
                completion(response.results , nil)
                
            } else {
                   completion([] , error)
                
            }
        }
    }
    
     class func markWatchlist(movieId: Int, watchlist: Bool, completion: @escaping (Bool, Error?) -> Void) {
          let body = MarkWatchlist(mediaType: "movie", mediaId: movieId, watchlist: watchlist)
        taskForPostRequest(url: Endpoints.markWatchList.url, ResponseType: TMDBResponse.self, body: body) { response, error in
              if let response = response {
                  // separate codes are used for posting, deleting, and updating a response
                  // all are considered "successful"
                  completion(response.statusCode == 1 || response.statusCode == 12 || response.statusCode == 13, nil)
              } else {
                  completion(false, nil)
              }
          }
      }
    
    
    
    
    
    
               
           }
