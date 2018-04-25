//
//  ApiManager.swift
//  NearsoftBackTalk
//
//  Created by Pablo Ruiz on 4/19/18.
//  Copyright © 2018 nearsoft. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire

class ApiManager {
  static let baseUrl = "https://api.openweathermap.org/"
  static let weatherApiKey = "997449c1e1fd176a3f2870b99ab903ad"
  
//   ____ _____________.____       _________                    .__
//  |    |   \______   \    |     /   _____/ ____   ______ _____|__| ____   ____
//  |    |   /|       _/    |     \_____  \_/ __ \ /  ___//  ___/  |/  _ \ /    \
//  |    |  / |    |   \    |___  /        \  ___/ \___ \ \___ \|  (  <_> )   |  \
//  |______/  |____|_  /_______ \/_______  /\___  >____  >____  >__|\____/|___|  /
//         \/        \/        \/     \/     \/     \/               \/
//
  func sessionRequestWithCallback(url: String, parameters: [String:Any] = [:], completion: (([String:Any]) -> Void)?, errorHandler: (() -> Void)?){
    guard var urlComponents = URLComponents(string: url) else {
      return
    }
    urlComponents.queryItems = makeGetParameters(dictionary: parameters)
    let request = URLRequest(url: urlComponents.url!)
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let data = data, let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
        do {
          let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
          if let jsonSerialized = jsonSerialized {
            completion?(jsonSerialized)
          }
        } catch let error as NSError {
          print(error)
          errorHandler?()
        }
      } else {
        errorHandler?()
      }
    }
    task.resume()
  }
  
//     _____  ___________
//    /  _  \ \_   _____/
//   /  /_\  \ |    __)
//  /    |    \|     \
//  \____|__  /\___  /
//          \/     \/
  
  func alamofireRequestWithPromise(request: Alamofire.URLRequestConvertible) -> Promise<[String: Any]> {
    return Promise { seal in
      let defaultError = ErrorHelper.createCustomError(withMessage: "Network Error")
      Alamofire.request(request).validate().responseJSON { response in
        switch response.result {
        case .success(let value):
          guard let statusCode = response.response?.statusCode else {
            seal.reject(defaultError)
            return
          }
          switch statusCode {
          case 200:
            guard let rawJson = value as? [String: Any] else {
              seal.reject(defaultError)
              return
            }
            seal.fulfill(rawJson)
          default:
            seal.reject(defaultError)
          }
        case .failure(let error):
          seal.reject(error)
        }
      }
    }
  }
  
  private func makeGetParameters(dictionary: [String:Any]) -> [URLQueryItem] {
    return dictionary.map {
      URLQueryItem(name: $0, value: "\($1)")
    }
  }

}
