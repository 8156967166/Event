//
//  Event.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 30/09/22.
//

import Foundation



import Foundation

class EventModel {
    var title: String = ""
   
    
    init(_ dict: [String: Any]) {
        self.title = dict["title"] as? String ?? ""
    }
}
