//
//  Weather.swift
//  NearsoftBackTalk
//
//  Created by Pablo Ruiz on 4/19/18.
//  Copyright © 2018 nearsoft. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

struct Weather: Mappable {
  
  var temperature: Double?
  var city: String = ""
  var country: String = ""
  
//     _____
//    /     \ _____  ______ ______   ___________
//   /  \ /  \\__  \ \____ \\____ \_/ __ \_  __ \
//  /    Y    \/ __ \|  |_> >  |_> >  ___/|  | \/
//  \____|__  (____  /   __/|   __/ \___  >__|
//          \/     \/|__|   |__|        \/
  
  init?(map: Map) {}
  
  mutating func mapping(map: Map) {
    temperature   <- map["main.temp"]
    city          <- map["name"]
    country       <- map["sys.country"]
  }
  
//  __________
//  \______   \_____ __  _  __
//  |       _/\__  \\ \/ \/ /
//  |    |   \ / __ \\     /
//  |____|_  /(____  /\/\_/
//         \/      \/

  init(usingDisctionary dictionary: [String: Any]) {
    self.temperature = dictionary["temperature"] as? Double
    self.city = dictionary["city"] as? String ?? ""
    self.country = dictionary["country"] as? String ?? ""
  }
  
//   _________       .__  _____  __
//  /   _____/_  _  _|__|/ ____\/  |_ ___.__.
//  \_____  \\ \/ \/ /  \   __\\   __<   |  |
//  /        \\     /|  ||  |   |  |  \___  |
// /_______  / \/\_/ |__||__|   |__|  / ____|
//         \/                         \/

  init(usingSwifty json: JSON) {
    temperature   = json["main"]["temp"].double
    city          = json["name"].stringValue
    country       = json["sys"]["country"].stringValue
  }
}









