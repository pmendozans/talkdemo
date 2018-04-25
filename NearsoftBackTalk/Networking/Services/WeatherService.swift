//
//  WaterService.swift
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

class WeatherService {
  
  let apiManager = ApiManager()
  let weatherSerializer = WeatherSerializer()
  
// __________                       .__
// \______   \_______  ____   _____ |__| ______ ____
//  |     ___/\_  __ \/  _ \ /     \|  |/  ___// __ \
//  |    |     |  | \(  <_> )  Y Y  \  |\___ \\  ___/
//  |____|     |__|   \____/|__|_|  /__/____  >\___  >
//                                \/        \/     \/
//
  func getWeatherWithPromise(byLocation location: CLLocationCoordinate2D) -> Promise<Weather> {
    return apiManager.alamofireRequestWithPromise(request: WeatherRouter.getWeather(latitude: location.latitude, longitude: location.longitude))
      .then { response in
        self.weatherSerializer.decodeWeather(dictionary: response)
      }
  }
  
//  _________        .__  .__ ___.                  __
//  \_   ___ \_____  |  | |  |\_ |__ _____    ____ |  | __
//  /    \  \/\__  \ |  | |  | | __ \\__  \ _/ ___\|  |/ /
//  \     \____/ __ \|  |_|  |_| \_\ \/ __ \\  \___|    <
//   \______  (____  /____/____/___  (____  /\___  >__|_ \
//          \/     \/              \/     \/     \/     \/
//
  func getWeatherWithCallback(byLocation location: CLLocationCoordinate2D, serviceCompletion: ((Weather) -> Void)?) {
    let url = "\(ApiManager.baseUrl)/data/2.5/weather"
    let parameters = weatherSerializer.encodeWeatherParameters(byLocation: location)
    apiManager.sessionRequestWithCallback(url: url, parameters: parameters,completion: { response in
      let jsonResponse = JSON(response)
      self.weatherSerializer.decodeWeather(json: jsonResponse, completion: { weather in
        serviceCompletion?(weather)
      })
    }, errorHandler: nil)
  }
}




