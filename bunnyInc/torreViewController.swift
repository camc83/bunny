//
//  torreViewController.swift
//  bunnyInc
//
//  Created by Christian Ernesto Chavarría Méndez on 06/10/18.
//  Copyright © 2018 Christian Ernesto Chavarría Méndez. All rights reserved.
//

import UIKit
import SwiftyJSON

class torreViewController: UIViewController{
    
    @IBOutlet weak var swMenu: UIScrollView!
    @IBOutlet weak var swPage: UIScrollView!
    @IBOutlet weak var btnLinkedIN: UIButton!
    
    var profile: profileOverLayer!
    var opportunity: opportunitiesOverLayer!
    var aspiration: aspirationsOverLayer!
    var headerTitle: headerOverLayer!
    var container: containerOverLayer!
    var LN: linkedInViewController!
    var person, recomendation, awards : JSON?
    var jobs,aspirations,education, opportunities : [JSON]?
    var location : String?
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getData(url: "bios/christianchavarria")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //MARK: Custom methods
    
    func setUpView(){
        var height: CGFloat
        
        height = 0
        swMenu.contentSize.width = 740
        profile = profileOverLayer(nibName: "profileOverLayer", bundle: nil)
        profile.data = self.person
        height = height + profile.view.frame.height
        swPage.addSubview(profile.view)
        
        opportunity = opportunitiesOverLayer(nibName: "opportunitiesOverLayer", bundle: nil)
        opportunity.data = self.opportunities
        opportunity.loc = self.person?["location"].stringValue
        opportunity.email = self.person?["email"].stringValue
        opportunity.view.frame.origin.y = height
        height = height + opportunity.view.frame.height
        swPage.addSubview(opportunity.view)
        
        aspiration = aspirationsOverLayer(nibName: "aspirationsOverLayer", bundle: nil)
        aspiration.data = self.aspirations
        aspiration.view.frame.origin.y = height
        height = height + aspiration.view.frame.height
        swPage.addSubview(aspiration.view)
        
        for title in ["Jobs","Education"]{
            var containers : [JSON]?
            var type : String?
            
            if(title == "Jobs"){
                containers = self.jobs
                type = "role"
            }
            if(title == "Education"){
                containers = self.education
                type = "name"
            }
            
            headerTitle = headerOverLayer(nibName: "headerOverLayer", bundle: nil)
            headerTitle.headerTitle = title
            headerTitle.view.frame.origin.y = height
            height = height + headerTitle.view.frame.height
            swPage.addSubview(headerTitle.view)
            
            for cont in containers! {
                container = containerOverLayer(nibName: "containerOverLayer", bundle: nil)
                container.data = cont
                container.type = type
                container.view.frame.origin.y = height
                height = height + container.view.frame.height + 5
                swPage.addSubview(container.view)
            }
            height = height + 10
        }
        
        swPage.contentSize.height = height
    }
    
    func getData(url:String){
        
        restApiManager.sharedInstance.getData(option: url){ (json: JSON) in
            if json != JSON.null {
                self.person = json["person"]
                self.location = self.person?["location"].stringValue
                self.aspirations = json["aspirations"].array
                self.recomendation = json["recomendation"]
                self.awards = json["ahievements"]
                self.jobs = json["jobs"].array
                self.education = json["education"].array
                self.opportunities = json["opportunities"].array
                
                DispatchQueue.main.async(execute: {
                    self.setUpView()
                })

            }
            
        }
    }
    
    @IBAction func goToLinkedIN(){
        LN = linkedInViewController(nibName: "linkedInViewController", bundle: nil)
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = LN
    }
}
