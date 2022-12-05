//
//  SelectLanguageTableViewCell.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 03/10/22.
//

import UIKit

class SelectLanguageTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var labelLanguageName: UILabel?
    @IBOutlet weak var imageViewSelectLanguage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    var cellModel: SelectLanguageTableViewCellModel! {
        didSet {
            setCellItems()
            
            if cellModel.isSelect == true {
                imageViewSelectLanguage.image = UIImage(named: "check")
                
            } else {
                imageViewSelectLanguage.image = UIImage(systemName: "profile")
            }
        }
    }
    
    func setCellItems() {
        labelLanguageName?.text = cellModel.getselectLanguageName()
        
    }
    
    
    

}
