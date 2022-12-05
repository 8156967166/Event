//
//  SelectLanguage.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 03/10/22.
//

import Foundation

class SelectLanguageModel {
    var languageName: String = ""
   
    
    init(_ dict: [String: Any]) {
        self.languageName = dict["languageName"] as? String ?? ""
    }
}
