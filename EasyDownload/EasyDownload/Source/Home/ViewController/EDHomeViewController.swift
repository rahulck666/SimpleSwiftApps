//
//  EDHomeViewController.swift
//  EasyDownload
//
//  Created by RAHUL CK on 4/6/18.
//  Copyright © 2018 ILink. All rights reserved.
//

import UIKit
import LinearProgressView

class EDHomeViewController: UIViewController {
    
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var downloadProgressView: LinearProgressView!
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var downloadUrlTextField: UITextField!
    @IBOutlet weak var noteLabel: UILabel!

    var downloadedFiles = [URL]()
    var interactor:EDHomeInteractor?
    weak var activityIndicator:EDActivityIndicator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.intialSetUp()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     Doing the initial setup for the controller
     */
    func intialSetUp()  {
        
        //Configuring Interactor
        interactor = EDHomeInteractor(interactorOutput: self)
        interactor?.fetchAllDownloadedFiles()
        
        // Adding observer for the tableview content size change
        tableView.addObserver(self, forKeyPath: EDUIConstants.contentSize, options: [.new], context: nil)
        
        //Configuring navigationbar
        self.navigationItem.title = EDLocalizationConstants.easyDownload
        self.navigationController?.navigationBar.barTintColor = UIColor.primaryBlue
        
        //Configuring other UI elements for initial setup
        self.downloadUrlTextField.placeholder = EDLocalizationConstants.downloadTextFieldPlaceHolder
        self.downloadButton.setTitle(EDLocalizationConstants.startDownload, for: .normal)
        self.downloadProgressView.trackColor = UIColor.progressBarGreen
        self.responseLabel.textColor = UIColor.primaryBlue
        self.noteLabel.isHidden = false
        self.downloadProgressView.isHidden = true
        self.noteLabel.text = EDLocalizationConstants.note
        self.activityIndicator = EDActivityIndicator(activityIndicatorStyle: .gray)
        self.updateUI(for: tableView.contentSize.height > 0)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.installShadow()
       
    }
    
    /**
     Download button action callback
     */
    @IBAction func downloadButtonTapped(_ sender: Any) {
        
        if let url = downloadUrlTextField.text, EdValidationHelper.validateDownloadUrl(urlString: url) {
            downloadButton.isEnabled = false
            activityIndicator?.showActivityIndicator(view: self.view)
            self.noteLabel.isHidden = true
            self.downloadProgressView.isHidden = false
            interactor?.downloadFile(with: url)
        }
        else {
            showSimpleAlert(title: EDLocalizationConstants.easyDownload, message: EDLocalizationConstants.invalidUrl, action: { (alert) in
                self.downloadUrlTextField.layer.add(EDAnimationHelper.shakeAnimation(), forKey:EDUIConstants.shake)
            })
        }
    }
    /**
     Update UI for content availability
     */
    func updateUI(for contentAvailability:Bool)  {
        if contentAvailability {
            responseLabel.text = ""
            responseLabel.isHidden = true
        }
        else {
            responseLabel.text = EDLocalizationConstants.noDownloadedFiles
            responseLabel.isHidden = false
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if keyPath == EDUIConstants.contentSize {
            self.updateUI(for: tableView.contentSize.height > 0)
        }
    }
    
    deinit {
        tableView.removeObserver(self, forKeyPath: EDUIConstants.contentSize, context: nil)
    }
    
}
//MARK: - UITableViewDataSource and UITableViewDelegate
extension EDHomeViewController:UITableViewDataSource,UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadedFiles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EDFileTableViewCell.className, for: indexPath)
        let fileImage = UIImage(named: EDImageNameConstants.fileImage)!
        let fileName = downloadedFiles[indexPath.row].lastPathComponent
        (cell as? EDFileTableViewCell)?.configure(image: fileImage, title: fileName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: EDLocalizationConstants.delete) { (action, indexPath) in
            self.interactor?.deleteFile(file: self.downloadedFiles[indexPath.row])
        }
        let share = UITableViewRowAction(style: .default, title: EDLocalizationConstants.share) { (action, indexPath) in
            // share item at indexPath
            let filesToShare = [self.downloadedFiles[indexPath.row]]
            let activityVC = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
        share.backgroundColor = UIColor.lightGray
        
        return [delete, share]
        
    }
}
//MARK: - EDHomeInteractorOutput

extension EDHomeViewController:EDHomeInteractorOutput {
    
    func didFinishDownloadingFile(success:Bool,response:EDDownloadResponse?,error:Error?) {
        downloadButton.isEnabled = true
        if ((activityIndicator?.superview) != nil) {
            activityIndicator?.removeActivityIndicator()
        }
        if success {
            showSimpleAlert(title: EDLocalizationConstants.easyDownload, message: EDLocalizationConstants.downloadSuccessFul) { (alert) in
                self.downloadUrlTextField.text = ""
                self.interactor?.fetchAllDownloadedFiles()
                self.downloadProgressView.setProgress(0, animated: false)
                self.noteLabel.isHidden = false
                self.downloadProgressView.isHidden = true
            }
        }
        else {
            let errorMessage = error?.localizedDescription ?? EDLocalizationConstants.downloadFailed
            showSimpleAlert(title: EDLocalizationConstants.easyDownload, message: errorMessage, action: { (alert) in
                self.downloadUrlTextField.text = ""
                self.downloadProgressView.setProgress(0, animated: false)
                
            })
        }
        
    }
    func didUpdateDownloadProgress(progress:Double) {
        
        downloadProgressView.setProgress(Float(progress*100), animated: true)
    }
    func didFinishFetchingAllDownloadedFiles(success:Bool,files:[URL]?) {
        if let files = files {
            self.downloadedFiles = files
            tableView.reloadData()
        }
    }
    func didFinishDeleteFile(success:Bool,file:URL) {
        if success {
            if let index = downloadedFiles.index(of: file) {
                self.downloadedFiles.remove(at:index)
                let indexPath = IndexPath(row: index, section: 0)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
}
extension EDHomeViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
//MARK:- Util methods
extension EDHomeViewController {
    func showSimpleAlert(title:String,message:String,action:@escaping (_ alert:UIAlertAction) -> Void ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: EDLocalizationConstants.ok, style: .cancel, handler: action)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

