//
//  EventTableViewModel.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 30/09/22.
//

import Foundation

enum Functionalies{
    case eventSelectCell
    case eventTypeCell
    case selectedLangCell
    case selectLangCollectionCell
    case dateTimeCell
    case dateTimeAddCell
    case ListingLangCell
}

class EventTableViewCellModel {
    
    // MARK: - variable
    
    var identifier: String = "eventSelect.Cell"
    var cellType:Functionalies = .eventSelectCell
    var eventDetails: EventModel = EventModel([:])
    var isSelected: Bool = false
    
    init(name: String, cellType:Functionalies) {
        self.eventDetails.title = name
      
        self.cellType = cellType
        switch cellType {
        case .eventSelectCell:
            identifier = "eventSelect.Cell"
        case .eventTypeCell:
            identifier = "eventType.Cell"
        case .selectedLangCell:
            identifier = "selectedLang.Cell"
        case .dateTimeCell:
            identifier = "dateTime.Cell"
        case .dateTimeAddCell:
            identifier = "dateTimeAdd.Cell"
        case .ListingLangCell:
            identifier = "listingLang.Cell"
        case .selectLangCollectionCell:
            identifier = "SelectLangCollection.Cell"
        }
    }
    
    // MARK: - Function
    
    func gettitle() -> String {
        return eventDetails.title
    }
    
}
