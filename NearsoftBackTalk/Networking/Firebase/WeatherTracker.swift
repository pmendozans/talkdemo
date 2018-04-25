//
//  WeatherTracker.swift
//  NearsoftBackTalk
//
//  Created by Pablo Ruiz on 4/19/18.
//  Copyright © 2018 nearsoft. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class WeatherTracker {
  
  var reference: DatabaseReference!
  
  init() {
    reference = Database.database().reference()
  }
  
  func trackUserWeather(changeHandler: @escaping ((Weather) -> Void)) {
    let weatherReference = reference.child("defaultWeather")
    weatherReference.observe(DataEventType.value, with: { snapshot in
      if let weatherDictionary  = snapshot.value as? [String : Any] {
        let weatherInformation = Weather(usingDisctionary: weatherDictionary)
        changeHandler(weatherInformation)
      }
    })
  }
}
