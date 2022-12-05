//
//  AddSelectLanguageCollectionViewCell.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 03/10/22.
//

import UIKit

protocol PassDataToEventTableCellDelegate {
   
    func buttonActionClose(sender: UIButton)
}

class AddSelectLanguageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var buttonCloseSelectedLang: UIButton!
    @IBOutlet weak var labelSelectedLanguage: UILabel?
    var delegate: PassDataToEventTableCellDelegate?
    var cellModelInCollection: AddLanguageTableViewModel! {
        didSet {
            setItemsINAddSelectedLanguage()
        }
    }
    
    func setItemsINAddSelectedLanguage() {
        labelSelectedLanguage?.text = cellModelInCollection.getaddLanguageName()
    }
    
    @IBAction func buttonActionClose(sender: UIButton) {
        delegate?.buttonActionClose(sender: buttonCloseSelectedLang)
    }
}
