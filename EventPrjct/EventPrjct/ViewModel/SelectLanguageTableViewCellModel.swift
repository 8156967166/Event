//
//  SelectLanguageTableViewCellModel.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 03/10/22.
//

import Foundation


enum Functionality{
    case languageCell
    
}

class SelectLanguageTableViewCellModel {
    
    // MARK: - variable
    
    var identifier: String = "selectLanguage.Cell"
    var cellType:Functionality = .languageCell
    var languageDetails: SelectLanguageModel = SelectLanguageModel([:])
    var isSelect: Bool = false
    
    init(strname: String, cellType: Functionality) {
        self.languageDetails.languageName = strname
      
        self.cellType = cellType
        switch cellType {
        case .languageCell:
            identifier = "selectLanguage.Cell"
        }
    }
    
    
    // MARK: - Function
    
    func getselectLanguageName() -> String {
        return languageDetails.languageName
    }
    
}
