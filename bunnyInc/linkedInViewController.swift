//
//  linkedInViewController.swift
//  bunnyInc
//
//  Created by Christian Ernesto Chavarría Méndez on 06/10/18.
//  Copyright © 2018 Christian Ernesto Chavarría Méndez. All rights reserved.
//

import UIKit
import LinkedinSwift
import SwiftyJSON


class linkedInViewController: UIViewController{
    
    @IBOutlet weak var consoleTextView: UITextView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnProfile: UIButton!
    
    let linkedinHelper = LinkedinSwiftHelper(configuration: LinkedinSwiftConfiguration(clientId: lnClientId, clientSecret: lnClientSecret, state: lnState, permissions: lnPermissions, redirectUrl: lnRedirectURL))
    
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: Custom methods
    @IBAction func login() {
        
        /**
         *  Yeah, Just this simple, try with Linkedin installed and without installed
         *
         *   Check installed if you want to do different UI: linkedinHelper.isLinkedinAppInstalled()
         *   Access token later after login: linkedinHelper.lsAccessToken
         */
        
        linkedinHelper.authorizeSuccess({ [unowned self] (lsToken) -> Void in
            
            self.writeConsoleLine("Login success lsToken: \(lsToken)")
            }, error: { [unowned self] (error) -> Void in
                
                self.writeConsoleLine("Encounter error: \(error.localizedDescription)")
            }, cancel: { [unowned self] () -> Void in
                
                self.writeConsoleLine("User Cancelled!")
        })
    }
    
    @IBAction func logout() {
        
        /**
         logout current linkedin user
         */
        
        linkedinHelper.logout()
    }
    
    /**
     Request profile for your just logged in account
     */
    @IBAction func requestProfile() {
        
        linkedinHelper.requestURL(lnURL, requestType: LinkedinSwiftRequestGet, success: { (response) -> Void in
            
            //response.jsonObject.debugDescription
            
            //let json : JSON = JSON(data: response.jsonObject)
            
            //print(json.stringValue)
            self.writeConsoleLine("Request success with response: \(response)")
            
        }) { [unowned self] (error) -> Void in
            
            self.writeConsoleLine("Encounter error: \(error.localizedDescription)")
        }
    }
    
    fileprivate func writeConsoleLine(_ log: String, funcName: String = #function) {
        
        DispatchQueue.main.async { () -> Void in
            self.consoleTextView.insertText("\n")
            self.consoleTextView.insertText("-----------\(funcName) start:-------------")
            self.consoleTextView.insertText("\n")
            self.consoleTextView.insertText(log)
            self.consoleTextView.insertText("\n")
            self.consoleTextView.insertText("-----------\(funcName) end.----------------")
            self.consoleTextView.insertText("\n")
            
            let rect = CGRect(x: self.consoleTextView.contentOffset.x, y: self.consoleTextView.contentOffset.y, width: self.consoleTextView.contentSize.width, height: self.consoleTextView.contentSize.height)
            
            self.consoleTextView.scrollRectToVisible(rect, animated: true)
        }
    }
    
}
