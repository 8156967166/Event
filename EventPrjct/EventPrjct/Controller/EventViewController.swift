//
//  EventViewController.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 30/09/22.


import UIKit

protocol DataEnteredToEventCellDelegate {
    func userDidEnterInformationToCell(selectedLanguage: String)
}

class EventViewController: UIViewController, PassDataToEventViewControllerDelegate, DataEnteredDelegate {
  
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    
    var eventArray = [EventTableViewCellModel]()
    var index: Int!
    var iconClick = true
    var isSelectbuttonPrivate = Bool()
    var selectedLanguageName = String()
    var delegate: DataEnteredToEventCellDelegate?
    var isSelectFromSelectLanguage = Bool()
    var cellModelFromSelectLang: SelectLanguageTableViewCellModel!
    
    // MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEventModel()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - functions
    
    func setEventModel() {
        let selectEvent = EventTableViewCellModel(name: "Is your event public or private ?", cellType: .eventSelectCell)
        let eventType = EventTableViewCellModel(name: "Event Type", cellType: .eventTypeCell)
        let selectedLag = EventTableViewCellModel(name: "Select Language", cellType: .selectedLangCell)
        let selectLangCollection = EventTableViewCellModel(name: "", cellType: .selectLangCollectionCell)
        let dateTime = EventTableViewCellModel(name: "Date & Time", cellType: .dateTimeCell)
        let dateTimeAdd = EventTableViewCellModel(name: "", cellType: .dateTimeAddCell)
        let listingLang = EventTableViewCellModel(name: "Listing Language", cellType: .ListingLangCell)
        eventArray.append(selectEvent)
        eventArray.append(eventType)
        eventArray.append(selectedLag)
        eventArray.append(selectLangCollection)
        eventArray.append(dateTime)
        eventArray.append(dateTimeAdd)
        eventArray.append(listingLang)
    
    }
    
    func buttonActionPrivate() {
        isSelectbuttonPrivate = true
        tableView.reloadData()
    }
    
    func buttonActionPublic() {
        isSelectbuttonPrivate = false
        index = 6
        tableView.reloadData()
    }
    
    func buttonActionAddCellDate() {
        let item = EventTableViewCellModel(name: "", cellType: .dateTimeAddCell)
//        eventArray.append(item)
        eventArray.insert(item, at: 6)
        
        tableView.reloadData()
    }
    
    func buttonActionCloseDateCell(sender: UIButton) {
    
        let point = sender.convert(CGPoint.zero, to: tableView)
            guard let indexpath = tableView.indexPathForRow(at: point) else {return}
            eventArray.remove(at: indexpath.row)
              tableView.beginUpdates()
            tableView.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .automatic)
              tableView.endUpdates()
        
//        tableView.reloadData()
    }
    
    func userDidEnterInformation(info: String) {
        selectedLanguageName = info
        
        print("selected Language From SL ===> \(info)")
        
        tableView.reloadData()
        
    }
    
    func isSelectLanguage(bool: Bool) {
        isSelectFromSelectLanguage = bool
        
        print("isSelectFromSelectLanguage .....*** \(isSelectFromSelectLanguage)")
        
        tableView.reloadData()
    }
    
    func cellModel(cellModelInSelectedLanguage: SelectLanguageTableViewCellModel) {
        cellModelFromSelectLang = cellModelInSelectedLanguage
        
       
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectLanguageViewController" {
            let secondViewController = segue.destination as! SelectLanguageViewController
                secondViewController.delegate = self
        }
    }
}

// MARK: - Table

extension EventViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = eventArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as! EventTableViewCell
        cell.selectedLangFromSelectedLang = selectedLanguageName
        cell.isSelectLanguage = isSelectFromSelectLanguage
        if isSelectFromSelectLanguage == true {
            cell.receiveCellModel = cellModelFromSelectLang
        }
        cell.cellModel = cellModel
        
//        delegate?.userDidEnterInformationToCell(selectedLanguage: selectedLanguageName)
        cell.delegate = self
        
        cell.productVC = self
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
        let cellModel = eventArray[indexPath.row]
        
        if isSelectbuttonPrivate == true {
            if cellModel.cellType == .ListingLangCell {
                return 100
            }
        }
        else {
            if cellModel.cellType == .ListingLangCell {
                return 0
            }
        }
        return tableView.rowHeight
    }
}


