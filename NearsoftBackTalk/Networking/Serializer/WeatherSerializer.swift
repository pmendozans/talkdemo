//
//  WeatherSerializer.swift
//  NearsoftBackTalk
//
//  Created by Pablo Ruiz on 4/19/18.
//  Copyright © 2018 nearsoft. All rights reserved.
//

import Foundation
import CoreLocation
import PromiseKit
import ObjectMapper
import SwiftyJSON

class WeatherSerializer {
  
  func encodeWeatherParameters(byLocation location: CLLocationCoordinate2D) -> [String: Any] {
    let weatherParameters = [
      "lat": location.latitude,
      "lon": location.longitude,
      "appid": ApiManager.weatherApiKey,
      "units": "metric",
      ] as [String : Any]
    
    return weatherParameters
  }
  
  func decodeWeather(dictionary: [String: Any]) -> Promise<Weather> {
    return Promise { seal in
      let weatherInformation = Mapper<Weather>().map(JSON: dictionary)
      if let weather = weatherInformation, weather.temperature != nil {
        seal.fulfill(weather)
      }
      seal.reject(ErrorHelper.createCustomError(withMessage: "Error Decoding"))
    }
  }
  
  func decodeWeather(json: JSON, completion: ((Weather) -> Void)){
    let weatherInformation = Weather(usingSwifty: json)
    completion(weatherInformation)
  }
}

