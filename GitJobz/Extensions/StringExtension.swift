//
//  StringExtension.swift
//  GitJobz
//
//  Created by er on 3/2/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import Foundation

extension String {
     /**
       Treats the given input as a localizable key and returns the value for this key from a localizable file
       */
       func localized(comment: String = "") -> String {
           return NSLocalizedString(self, comment: comment)
       }
}
