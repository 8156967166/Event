//
//  SelectLanguageViewController.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 03/10/22.
//

import UIKit

protocol DataEnteredDelegate {
    func userDidEnterInformation(info: String)
    func isSelectLanguage(bool: Bool)
    func cellModel(cellModelInSelectedLanguage: SelectLanguageTableViewCellModel)
//    func setSelectItem(selectItem: )
}

class SelectLanguageViewController: UIViewController {
    
    // MARK: - Outlet
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonDone: UIButton!
    
    // MARK: - Variable
    
    var selectLanguageArray = [SelectLanguageTableViewCellModel]()
    var cellModels: SelectLanguageTableViewCellModel!
    var selectedLang = String()
    var delegate: DataEnteredDelegate?
    var isSelectLanguage = Bool()
    var selectedLangArray = [SelectLanguageTableViewCellModel]()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSelectLanguageModel()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - functions
    
    func setSelectLanguageModel() {
        let languageName1 = SelectLanguageTableViewCellModel(strname: "Afrikanns", cellType: .languageCell)
        let languageName2 = SelectLanguageTableViewCellModel(strname: "Albanian", cellType: .languageCell)
        let languageName3 = SelectLanguageTableViewCellModel(strname: "Arabic", cellType: .languageCell)
        let languageName4 = SelectLanguageTableViewCellModel(strname: "Armenian", cellType: .languageCell)
        let languageName5 = SelectLanguageTableViewCellModel(strname: "Basque", cellType: .languageCell)
        let languageName6 = SelectLanguageTableViewCellModel(strname: "Bengali", cellType: .languageCell)
        let languageName7 = SelectLanguageTableViewCellModel(strname: "Bulgarian", cellType: .languageCell)
        let languageName8 = SelectLanguageTableViewCellModel(strname: "Catalan", cellType: .languageCell)
        let languageName9 = SelectLanguageTableViewCellModel(strname: "Cambodian", cellType: .languageCell)
        let languageName10 = SelectLanguageTableViewCellModel(strname: "Chinese", cellType: .languageCell)
        let languageName11 = SelectLanguageTableViewCellModel(strname: "Croation", cellType: .languageCell)
        let languageName12 = SelectLanguageTableViewCellModel(strname: "Arabic", cellType: .languageCell)
        
        selectLanguageArray = [languageName1, languageName2, languageName3, languageName4, languageName5, languageName6, languageName7, languageName8, languageName9, languageName10, languageName11, languageName12]
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func buttonActionDone(_ sender: UIButton) {
        if isSelectLanguage == true {
            
            delegate?.userDidEnterInformation(info: selectedLang)
            delegate?.isSelectLanguage(bool: isSelectLanguage)
           
            let selectedItems = self.selectLanguageArray.filter({ $0.isSelect == true })
            
            print("selectedItems.count ***** \(selectedItems)")
            
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}

// MARK: - Table

extension SelectLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectLanguageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = selectLanguageArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as! SelectLanguageTableViewCell
        
        cell.cellModel = cellModel
        
        if cellModel.isSelect == true {
            delegate?.cellModel(cellModelInSelectedLanguage: cellModel)
            buttonDone.addTarget(self, action: #selector(buttonActionDone(_:)), for: .touchUpInside)
            isSelectLanguage = true
            
            print("selected Languages ====> \(cellModel.languageDetails.languageName)")
            
            selectedLang = cellModel.languageDetails.languageName
            print(" selectedLang ----- \(selectedLang)")
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellModel = selectLanguageArray[indexPath.row]
        
        if cellModel.isSelect == true {
            cellModel.isSelect = false
        } else {
            cellModel.isSelect = true
        }
        
        tableView.reloadData()
        
    }
}
