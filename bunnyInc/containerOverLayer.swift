//
//  containerOverLayer.swift
//  bunnyInc
//
//  Created by Christian Ernesto Chavarría Méndez on 07/10/18.
//  Copyright © 2018 Christian Ernesto Chavarría Méndez. All rights reserved.
//

import UIKit
import SwiftyJSON

class containerOverLayer: UIViewController{
    
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblCompanyTitle: UILabel!
    @IBOutlet weak var lblDatesTitle: UILabel!
    
    var data : JSON?
    var type : String?
    
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
        self.lblJobTitle.text = (data?[type!].stringValue)!
        let tmp = data?["organizations"].array
        self.lblCompanyTitle.text = tmp?[0]["name"].stringValue
        self.lblDatesTitle.text = (data?["fromMonth"].stringValue)! + " " + (data?["fromYear"].stringValue)! + " - " + (data?["toMonth"].stringValue)! + " " + (data?["toYear"].stringValue)!
    }
}
