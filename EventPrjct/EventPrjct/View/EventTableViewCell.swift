//
//  EventTableViewCell.swift
//  EventPrjct
//
//  Created by Bimal@AppStation on 30/09/22.
//

import UIKit
protocol PassDataToEventViewControllerDelegate {
    func buttonActionPrivate()
    func buttonActionPublic()
    func buttonActionAddCellDate()
    func buttonActionCloseDateCell(sender: UIButton)
}
class EventTableViewCell: UITableViewCell, UITextFieldDelegate, DataEnteredToEventCellDelegate, PassDataToEventTableCellDelegate {
    
    // MARK: - Outlet
    
    @IBOutlet weak var labelTitle: UILabel?
    @IBOutlet weak var viewPublicEvent: UIView?
    @IBOutlet weak var viewPrivateEvent: UIView?
    @IBOutlet weak var imageSelectedEventPublic: UIImageView?
    @IBOutlet weak var imageSelectedEventPrivate: UIImageView?
    @IBOutlet weak var labelSelectedEventPublic: UILabel?
    @IBOutlet weak var labelSelectedEventPrivate: UILabel?
    @IBOutlet weak var viewInEnglish: UIView?
    @IBOutlet weak var viewInArabic: UIView?
    @IBOutlet weak var viewInBoth: UIView?
    @IBOutlet weak var labelInEnglish: UILabel?
    @IBOutlet weak var labelInArabic: UILabel?
    @IBOutlet weak var labelInBoth: UILabel?
    @IBOutlet weak var textFiledDate: UITextField?
    @IBOutlet weak var textFieldStartAt: UITextField?
    @IBOutlet weak var textFieldEndAt: UITextField?
//    @IBOutlet weak var labelPickerEventType: UILabel?
    @IBOutlet weak var textFiledEventType: UITextField?
    @IBOutlet weak var buttonEvent: UIButton!
    
    @IBOutlet weak var imageViewPlus: UIImageView?
    @IBOutlet weak var buttonCloseDate: UIButton!
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var tableViewPicker: UITableView!
    
    // MARK: - variable
    
    let pickerArray = ["Absolute Planning", "Divine Events", "Dreamworld Venues", "Events Empire", "Party Glory", "Party Invasion", "Party Playground"]
    var delegate: PassDataToEventViewControllerDelegate?
    var productVC: EventViewController?
    var pickerView = UIPickerView()
    let datePickerView: UIDatePicker = UIDatePicker()
    let timePickerView = UIDatePicker()
    var isSelectDoneEventType = Bool()
    var addSelectLanguageCollection = [AddLanguageTableViewModel]()
    var eventType = String()
    var selectedLangFromSelectedLang = String()
    var selectedLanguage = String()
    var isSelectLanguage = Bool()
    
    var receiveCellModel: SelectLanguageTableViewCellModel!
    var cellModel: EventTableViewCellModel! {
        didSet {
           
            setCellItems()
            
            setDate()
            setEventType()
            pickerView.delegate = self
            pickerView.dataSource = self
           
            textFiledEventType?.inputView = pickerView
           
            textFieldStartAt?.inputView = timePickerView
        
            textFieldEndAt?.inputView = timePickerView
            
            setStartAtTime()
            setEndAtTime()
            
            
            if cellModel.cellType == .selectLangCollectionCell {
                setSelectedLanguageModel()
            }
//            if (textFiledDate?.text != "" || textFieldStartAt?.text != "" ||  textFieldEndAt?.text != "") {
//                imageViewPlus?.image = UIImage(named: "wrong")
//            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        // Initialization code
    }
    
    // MARK: - functions
    
    func setSelectedLanguageModel() {
        
        print("selectedLangFromSelectedLang =========> \(selectedLangFromSelectedLang)")
        
        print("addSelectLanguageCollection.count =========> \(addSelectLanguageCollection.count)")
        
        if isSelectLanguage != true {
            
            let addLang = AddLanguageTableViewModel(strname: "", cellType: .addLanguageCell)
            addSelectLanguageCollection.append(addLang)
            
        }
        
        else if isSelectLanguage == true {
            
            let selectedLanguage = AddLanguageTableViewModel(strname: "\(receiveCellModel.languageDetails.languageName)", cellType: .selectedLanguageCell)
            addSelectLanguageCollection.append(selectedLanguage)
            print("addSelectLanguageCollection.count ***=========> \(addSelectLanguageCollection.count)")
            
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    func userDidEnterInformationToCell(selectedLanguage: String) {
        
        self.selectedLanguage = selectedLanguage
        print("selectedLanguage ------> \(selectedLanguage)")
        
    }
    
    func setCellItems() {
        labelTitle?.text = cellModel.gettitle()
    }
    
    func setStartAtTime() {
       
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = .black
        let doneButtonInTime = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonStartAt))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let dismissButtonInTime = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissButtonStartAt))
    //        toolbar.items = [doneButtonInTime, dismissButtonInTime]
        toolbar.setItems([dismissButtonInTime, flexibleSpace, doneButtonInTime], animated: false)
           
        textFieldStartAt?.inputAccessoryView = toolbar
        timePickerView.datePickerMode = .time
//        if #available(iOS 13.4, *) {
        timePickerView.preferredDatePickerStyle = .wheels
//        } else {
            // Fallback on earlier versions
//        }
        
    }
    
    func buttonActionClose(sender: UIButton) {
       
    }
    
   
    
    @objc func doneButtonStartAt() {
        
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            textFieldStartAt?.text = formatter.string(from: timePickerView.date)
            endEditing(true)
       
    }
    
    @objc func dismissButtonStartAt() {
        endEditing(true)
    }
    
    func setEndAtTime() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = .black
        let doneButtonInTime = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonEndAt))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let dismissButtonInTime = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissButtonStartAt))
        toolbar.setItems([dismissButtonInTime, flexibleSpace, doneButtonInTime], animated: false)
        textFieldEndAt?.inputAccessoryView = toolbar
        timePickerView.datePickerMode = .time
//        if #available(iOS 13.4, *) {
            timePickerView.preferredDatePickerStyle = .wheels
//        } else {
            // Fallback on earlier versions
//        }
        
        
    }
    
    @objc func doneButtonEndAt() {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        textFieldEndAt?.text = formatter.string(from: timePickerView.date)
    
        if textFiledDate?.text != "" && textFieldStartAt?.text != "" && textFieldEndAt?.text != "" {
            imageViewPlus?.image = UIImage(named: "wrong")
            delegate?.buttonActionAddCellDate()
        }
        
        endEditing(true)
    }
    
    func setDate() {
       
        datePickerView.datePickerMode = .date
        textFiledDate?.inputView = datePickerView
//        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
//        } else {
            // Fallback on earlier versions
//        }
        datePickerView.sizeToFit()
        datePickerView.backgroundColor = UIColor.white
        datePickerView.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControl.Event.valueChanged)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.tintColor = .black
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDatePicker))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let dismissButtonInTime = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissButtonStartAt))
        
        toolBar.setItems([dismissButtonInTime, flexibleSpace, doneButton], animated: false)
        textFiledDate?.inputAccessoryView = toolBar
       
    }
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "dd/MM/yyyy"
        textFiledDate?.text = timeFormatter.string(from: sender.date)
    }
    
    @objc func doneDatePicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        textFiledDate?.text = formatter.string(from: datePickerView.date)
        
        endEditing(true)
    }
    
    func setEventType() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.tintColor = .black
        let doneButtonInTime = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonEventType))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let dismissButtonInTime = UIBarButtonItem(title: "Dismiss", style: .plain, target: self, action: #selector(dismissButtonStartAt))
        toolbar.setItems([dismissButtonInTime, flexibleSpace, doneButtonInTime], animated: false)
        
        textFiledEventType?.inputAccessoryView = toolbar
//        timePickerView.datePickerMode = .time
////        if #available(iOS 13.4, *) {
//            timePickerView.preferredDatePickerStyle = .wheels
        pickerView.reloadAllComponents()
       
    }
    
    @objc func doneButtonEventType() {
        isSelectDoneEventType = true
        textFiledEventType?.text = eventType
            endEditing(true)
    }
    
    @IBAction func buttonActionPublicEvent(sender: UIButton) {
        viewPublicEvent?.backgroundColor = .red
        viewPrivateEvent?.backgroundColor = .white
        imageSelectedEventPublic?.image = UIImage(named: "task")
        imageSelectedEventPrivate?.image = UIImage(named: "filledcircle")
        labelSelectedEventPublic?.textColor = .white
        labelSelectedEventPrivate?.textColor = .black
        delegate?.buttonActionPublic()
    }
    @IBAction func buttonActionPrivateEvent(sender: UIButton) {
        viewPrivateEvent?.backgroundColor = .red
        viewPublicEvent?.backgroundColor = .white
        imageSelectedEventPrivate?.image = UIImage(named: "task")
        imageSelectedEventPublic?.image = UIImage(named: "filledcircle")
        labelSelectedEventPrivate?.textColor = .white
        labelSelectedEventPublic?.textColor = .black
        delegate?.buttonActionPrivate()
    }
    
    @IBAction func buttonActionEnglish(sender: UIButton) {
        viewColorListingLang()
        viewInEnglish?.backgroundColor = .systemOrange
        labelColorListingLang()
        labelInEnglish?.textColor = .white
    }
    
    @IBAction func buttonActionArabic(sender: UIButton) {
        labelColorListingLang()
        viewColorListingLang()
        viewInArabic?.backgroundColor = .systemOrange
        labelInArabic?.textColor = .white
    }
    
    @IBAction func buttonActionBoth(sender: UIButton) {
        labelColorListingLang()
        viewColorListingLang()
        viewInBoth?.backgroundColor = .systemOrange
        labelInBoth?.textColor = .white
    }
    
    @IBAction func buttonActionDateCellClose(sender: UIButton) {
        if imageViewPlus?.image == UIImage(named: "wrong") {
            if textFiledDate?.text != "" && textFieldStartAt?.text != "" && textFieldEndAt?.text != "" {
                delegate?.buttonActionCloseDateCell(sender: buttonCloseDate)
            }
        }
    }
    
    func labelColorListingLang() {
        labelInEnglish?.textColor = .black
        labelInArabic?.textColor = .black
        labelInBoth?.textColor = .black
    }
    func viewColorListingLang() {
        viewInEnglish?.backgroundColor = .white
        viewInArabic?.backgroundColor = .white
        viewInBoth?.backgroundColor = .white
    }
}

// MARK: - Picker

extension EventTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        textFiledEventType?.text = pickerArray[row]
//        textFiledEventType?.resignFirstResponder()
        
//        if isSelectDoneEventType == true {
//            textFiledEventType?.text = pickerArray[row]
//        }
        
        eventType = pickerArray[row]
    
    }
    
}

// MARK: - Collection

extension EventTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return addSelectLanguageCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellModelInSelectedLang = addSelectLanguageCollection[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellModelInSelectedLang.identifier, for: indexPath) as! AddSelectLanguageCollectionViewCell
        cell.labelSelectedLanguage?.text = selectedLangFromSelectedLang
        cell.cellModelInCollection = cellModelInSelectedLang
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let cellModelInSelectedLang = addSelectLanguageCollection[indexPath.row]
        if cellModelInSelectedLang.cellType == .addLanguageCell {
            return CGSize(width: 50, height: 50)
        }
        else {
            return CGSize(width: 200, height: 40)
        }
            
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellModelInSelectedLang = addSelectLanguageCollection[indexPath.row]
        
        if cellModelInSelectedLang.cellType == .addLanguageCell {
            productVC?.performSegue(withIdentifier: "SelectLanguageViewController", sender: nil)
        }
    }
}
