//
//  NetworkingManager.swift
//  FeedApp
//
//  Created by Дмитрий Мартьянов on 13.12.2021.
//

import UIKit

typealias Response<T> = (data: T?, error: String?)

protocol NetworkService🌐 {
    
    static var shared: NetworkService🌐 { get }
    
    func fetchListing(subreddit: String, postsLimit: Int, after itemName: String?,_ completion: @escaping (Response<Listing>) -> Void)
    
    func fetchSubreddit(subreddit: String, _ completion: @escaping (Response<Subreddit>) -> Void)
}
class RedditAPI: NetworkService🌐 {
    
    private init() {
        
    }
    
    public static var shared: NetworkService🌐 = RedditAPI()
    
    func fetchListing(subreddit: String, postsLimit: Int = 25, after itemName: String? = nil, _ completion: @escaping (Response<Listing>) -> Void) {
        
        guard let url = URL(string: createURLPath(subreddit, postsLimit, itemName)) else {
            completion((nil, "Connection error"))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, _ , error in
            DispatchQueue.main.async {
                if let error = error {
                    completion((nil, error.localizedDescription))
                    return
                }
                guard let data = data else {
                    completion((nil, "No data found"))
                    return
                }
                guard let object = try? JSONSerialization.jsonObject(with: data, options: []) else {
                    completion((nil, "Error serialize json object."))
                    return
                }
                guard let jsonDictionary = object as? JSONDictionary, let listingJson = jsonDictionary["data"] as? JSONDictionary else {
                    completion((nil, "Error creating jsonDictionary"))
                    return
                }
                let listing = Listing(json: listingJson)
                completion((listing, nil))
            }
            
        }.resume()
    }
    
    private func createURLPath(_ subreddit: String, _ postsLimit: Int, _ after: String? = nil) -> String {
        let limit = postsLimit > 0 ? postsLimit : 25
        let after = after ?? ""
        
        return "https://www.reddit.com/r/\(subreddit).json?limit=\(limit)" + (after.isEmpty ? "" : "&after=" + after)
    }
    
    func fetchSubreddit(subreddit: String, _ completion: @escaping (Response<Subreddit>) -> Void){
        guard let url = URL(string: "https://www.reddit.com/\(subreddit)/about.json?") else {
            completion((nil, "Error"))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion((nil, error.localizedDescription))
                }
                return
            }
            DispatchQueue.main.async {
                guard let data = data, let object = try? JSONSerialization.jsonObject(with: data, options: [])  else {
                        completion((nil, "Error"))
                    return
                }
                guard let jsonDictionary = object as? JSONDictionary, let listingJson = jsonDictionary["data"] as? JSONDictionary else {
                        completion((nil, "Error"))
                    return
                }
            
                let sub = Subreddit(from: listingJson)
                completion((sub, nil))
            }
            
        }.resume()
    }
   
}

