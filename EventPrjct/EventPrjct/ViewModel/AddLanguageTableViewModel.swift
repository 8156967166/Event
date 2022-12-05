//
//  AddLanguageTableViewModel.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 06/10/22.
//

import Foundation

enum CellTypes{
    case addLanguageCell
    case selectedLanguageCell
}

class AddLanguageTableViewModel {
    
    // MARK: - variable
    
    var identifier: String = "addSelectLanguage.Cell"
    var cellType:CellTypes = .addLanguageCell
    var addLanguageDetails: AddLanguageModel = AddLanguageModel([:])
    var isSelect: Bool = false
    
    init(strname: String, cellType: CellTypes) {
        self.addLanguageDetails.addLanguageName = strname
      
        self.cellType = cellType
        switch cellType {
        case .addLanguageCell:
            identifier = "addSelectLanguage.Cell"
        case .selectedLanguageCell:
            identifier = "selectedLanguage.Cell"
        }
    }
    
    
    // MARK: - Function
    
    func getaddLanguageName() -> String {
        return addLanguageDetails.addLanguageName
    }
    
}
