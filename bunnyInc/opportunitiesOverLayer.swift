//
//  opportunitiesOverLayer.swift
//  bunnyInc
//
//  Created by Christian Ernesto Chavarría Méndez on 06/10/18.
//  Copyright © 2018 Christian Ernesto Chavarría Méndez. All rights reserved.
//

import UIKit
import SwiftyJSON


class opportunitiesOverLayer: UIViewController{
    
    @IBOutlet weak var lblOpportunities: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var data: [JSON]?
    var loc, email : String?
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setUpView()
        
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
        
        self.lblLocation.text = self.loc!
        self.lblEmail.text = self.email!
        self.lblOpportunities.text = "Interested in "
        for opportunity in data!{
            self.lblOpportunities.text = self.lblOpportunities.text! + opportunity["name"].stringValue +  " ,"
        }
        
    }
}
