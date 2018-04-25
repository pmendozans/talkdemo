//
//  IconHelper.swift
//  NearsoftBackTalk
//
//  Created by Pablo Ruiz on 4/19/18.
//  Copyright © 2018 nearsoft. All rights reserved.
//

import Foundation
import UIKit

class IconHelper {
  static func getIcon(byTemperature temperature: Double) -> UIImage {
    if temperature <= 0 {
      return #imageLiteral(resourceName: "snowflake")
    }
    if temperature > 0 && temperature < 30 {
      return #imageLiteral(resourceName: "sun")
    }
    return #imageLiteral(resourceName: "fire")
  }
}
