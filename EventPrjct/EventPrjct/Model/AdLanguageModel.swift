//
//  AdLanguageModel.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 06/10/22.
//

import Foundation


class AddLanguageModel {
    var addLanguageName: String = ""
   
    
    init(_ dict: [String: Any]) {
        self.addLanguageName = dict["addLanguageName"] as? String ?? ""
    }
}
