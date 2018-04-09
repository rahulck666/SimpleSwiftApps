//
//  ViewController.swift
//  WeatherCast
//
//  Created by RAHUL CK on 4/8/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var placeNameTextField: UITextField!
    @IBOutlet weak var addPlaceButton: UIButton!
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var activityIndicator:WCActivityIndicator!
    
    var interactor:WCHomeInteractor?
    var weathers = [WCWeather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialSetup()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        tableView.removeObserver(self, forKeyPath: WCUIConstants.contentSize, context: nil)
    }
    
    /**
     Doing the initial setup for the controller
     */
    func intialSetup() {
        interactor = WCHomeInteractor(interactorOutput: self)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        activityIndicator = WCActivityIndicator(activityIndicatorStyle: .gray)
        tableView.addObserver(self, forKeyPath: WCUIConstants.contentSize, options: [.new], context: nil)
        placeNameTextField.placeholder = WCLocalizationConstants.cityTextFieldPlaceHolder
        self.navigationItem.title = WCLocalizationConstants.weatherCast
        
    }
    /**
     Fetches weather data from server
     */
    func fetchWeather(city:String) {
        interactor?.fetchWeatherData(cityName: city)
        activityIndicator.showActivityIndicator(view: self.view)
    }
    /**
     Updates UI for content availability
     */
    func updateUI(for contentAvailability:Bool)  {
        if contentAvailability {
            responseLabel.text = ""
            responseLabel.isHidden = true
        }
        else {
            responseLabel.text = WCLocalizationConstants.nocitiesAdded
            responseLabel.isHidden = false
        }
    }
    /**
     Add Button action callback
     */
    @IBAction func addPlaceButtonTapped(_ sender: Any) {
        
        if let city = placeNameTextField.text ,city.count > 0 {
            fetchWeather(city: city)
        }
        else {
            showSimpleAlert(title: WCLocalizationConstants.weatherCast, message: WCLocalizationConstants.invalidCity, action: { (alert) in
                self.placeNameTextField.layer.add(WCAnimationHelper.shakeAnimation(), forKey: WCUIConstants.shake)
            })
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == WCUIConstants.contentSize {
            self.updateUI(for: tableView.contentSize.height > 0)
        }
    }
    
}
//MARK:- UITableViewDataSource and UITableViewDelegate

extension HomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weathers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: WCWeatherCell.className, for: indexPath)
        let city = weathers[indexPath.row].city ?? ""
        let temperature = String(Int(weathers[indexPath.row].temperature ?? 0))
        (cell as? WCWeatherCell)?.configure(city:city ,temperature:temperature)
        
        return cell
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: WCLocalizationConstants.delete) { (action, indexPath) in
            self.weathers.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        return [delete]
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
}
//MARK:- WCHomeInteractorOutput

extension HomeViewController:WCHomeInteractorOutput {
    func didFinishFetchingWeatherData(success: Bool, response: WCWeather?, error: Error?) {
        activityIndicator.removeActivityIndicator()
        if let weather = response , success == true , weather.isValid() {
            showSimpleAlert(title: WCLocalizationConstants.weatherCast, message: WCLocalizationConstants.cityAdded, action: { (alert) in
                self.placeNameTextField.text = ""
            })
            weathers.append(weather)
            tableView.reloadData()
        }
        else {
            showSimpleAlert(title: WCLocalizationConstants.weatherCast, message: WCLocalizationConstants.invalidCity, action: { (alert) in
                self.placeNameTextField.text = ""
            })
        }
    }
}
//MARK:- UITextFieldDelegate
extension HomeViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK:- Util methods
extension HomeViewController {
    func showSimpleAlert(title:String,message:String,action:@escaping (_ alert:UIAlertAction) -> Void ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: WCLocalizationConstants.ok, style: .cancel, handler: action)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

