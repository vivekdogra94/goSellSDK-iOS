//
//  AddressInputViewController.swift
//  goSellSDK
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

import class UIKit.UIStoryboardSegue.UIStoryboardSegue
import class UIKit.UITableView.UITableView

/// View controller to handle address input.
internal class AddressInputViewController: HeaderNavigatedViewController {
    
    // MARK: - Internal -
    // MARK: Methods
    
    internal func setValidator(_ validator: CardAddressValidator) {
        
        self.addressFieldsDataManager = AddressFieldsDataManager(validator: validator)
        self.addressFieldsDataManager?.reloadClosure = {
            
            self.addressFieldsTableView?.reloadData()
        }
    }
    
    internal override func headerNavigationViewLoaded(_ headerView: TapNavigationView) {
        
        super.headerNavigationViewLoaded(headerView)
        
        headerView.title = "Address"
    }
    
    internal override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        if let countrySelectionController = segue.destination as? CountrySelectionViewController {
            
            self.addressFieldsDataManager?.setupCountriesSelectionController(countrySelectionController)
        }
    }
    
    // MARK: - Private -
    // MARK: Properties
    
    @IBOutlet private weak var addressFieldsTableView: UITableView?
    
    internal private(set) var addressFieldsDataManager: AddressFieldsDataManager?
}