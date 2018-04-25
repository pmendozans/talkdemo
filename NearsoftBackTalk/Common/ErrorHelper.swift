//
//  ErrorHelper.swift
//  NearsoftBackTalk
//
//  Created by Pablo Ruiz on 4/19/18.
//  Copyright © 2018 nearsoft. All rights reserved.
//

import Foundation

class ErrorHelper {
  static func createCustomError(withMessage message: String, domain: String = "DefaultDomain", code: Int = 0) -> NSError {
    let userInfo: [AnyHashable: Any] = [
      NSLocalizedDescriptionKey :  NSLocalizedString(domain, value: message, comment: "") ,
      NSLocalizedFailureReasonErrorKey : NSLocalizedString(domain, value: message, comment: "")
    ]
    let error = NSError(domain: domain, code: code, userInfo: userInfo as? [String : Any])
    return error
  }
}
