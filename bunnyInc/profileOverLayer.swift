//
//  profileOverLayer.swift
//  bunnyInc
//
//  Created by Christian Ernesto Chavarría Méndez on 06/10/18.
//  Copyright © 2018 Christian Ernesto Chavarría Méndez. All rights reserved.
//

import UIKit
import SwiftyJSON

class profileOverLayer: UIViewController{
    
    @IBOutlet weak var consoleTextView: UITextView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblAvatarRound: UILabel!
    @IBOutlet weak var imgAvatarRound: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblProfession: UILabel!
    
    var data: JSON?
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpView()
        self.setData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Custom methods
    func setUpView(){
        self.imgAvatar.layer.masksToBounds = false
        self.lblAvatarRound.layer.masksToBounds = false
        self.lblAvatarRound.layer.cornerRadius = self.lblAvatarRound.frame.size.height / 2
        self.lblAvatarRound.clipsToBounds = true
        self.imgAvatarRound.layer.masksToBounds = false
        self.imgAvatarRound.layer.cornerRadius = self.imgAvatarRound.frame.size.height / 2
        self.imgAvatarRound.clipsToBounds = true
    }
    
    func setData(){
        self.lblName.text = "Hello, my name is " + (data?["name"].stringValue)!
        self.lblProfession.text = (data?["professionalHeadline"].stringValue)!
        self.makeImageFromURL(url: (data?["picture"].stringValue)!)
        
    }
    
    func makeImageFromURL(url: String){
        let catPictureURL = URL(string:url)!
        let session = URLSession(configuration: .default)
        
        
        let downloadPicTask = session.dataTask(with: catPictureURL) { (data, response, error) in
            // The download has finished.
            if let e = error {
                print("Error downloading cat picture: \(e)")
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = response as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        profileImage = UIImage(data: imageData)
                        self.imgAvatarRound.image = profileImage
                        self.imgAvatar.image = profileImage
                        
                        // Do something with your image.
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }
        
        downloadPicTask.resume()
        
    }
    
    
    
    
    //////////////////////////////////////////////////////
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
