//
//  WeaterRouter.swift
//  NearWeather
//
//  Created by Pablo Ruiz on 4/19/18.
//  Copyright © 2018 nearsoft. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRouter: URLRequestConvertible {
  
  case getWeather(latitude: Double, longitude: Double)
  
  var method: HTTPMethod {
    switch self {
    case .getWeather:
      return .get
    }
  }
  
  var path: String {
    switch self {
    case .getWeather:
      return "data/2.5/weather"
    }
  }
  
  var parameters: [String: Any] {
    switch self {
    case .getWeather(let latitude, let longitude):
      return [
        "lat": latitude,
        "lon": longitude,
        "appid": ApiManager.weatherApiKey,
        "units": "metric",
      ] as [String : Any]
    }
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try ApiManager.baseUrl.asURL()
    //var urlRequest = URLRequest(url: url.appendingPathComponent(path), headers: headers)
    var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
    
    urlRequest.httpMethod = method.rawValue
    switch self {
    case .getWeather:
      urlRequest = try URLEncoding.queryString.encode(urlRequest, with: self.parameters)
    }
    return urlRequest
  }
}

