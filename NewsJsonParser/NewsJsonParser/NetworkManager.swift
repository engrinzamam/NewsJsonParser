//
//  NetworkManager.swift
//  NewsJsonParser
//
//  Created by engrInzamamulhaq on 25/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    class func getNews(completion: @escaping (Data?) -> Void) {
        
        AF.request(APIURLS.newsURL, method: .get,encoding: JSONEncoding.default).responseJSON { response in
            let result = response.result
            switch result {
            case .success( _):
                completion(response.data)
            case .failure(let err):
                print(err.localizedDescription)
                completion(nil)
            }
        }
        
//        let urlRequest = URLRequest(url: URL(string: APIURLS.newsURL)!)
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: urlRequest) { (data,response,error) in
//            guard error == nil else {
//                print(error?.localizedDescription)
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                return
//            }
//            guard let data = data else { return }
//            completion(data)
//
//        }
//        task.resume()
    }

}

struct APIURLS {
//    static let newsURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    static let newsURL = "https://api.npoint.io/cc9cb6ca8f37529735ec"
}
