//
//  aspirationsOverLayer.swift
//  bunnyInc
//
//  Created by Christian Ernesto Chavarría Méndez on 06/10/18.
//  Copyright © 2018 Christian Ernesto Chavarría Méndez. All rights reserved.
//

import UIKit
import SwiftyJSON

class aspirationsOverLayer: UIViewController{
    
    @IBOutlet weak var lblOpportunity1: UILabel!
    @IBOutlet weak var lblOpportunity2: UILabel!
    @IBOutlet weak var lblOpportunity3: UILabel!
    @IBOutlet weak var lblCircle1: UILabel!
    @IBOutlet weak var lblCircle2: UILabel!
    @IBOutlet weak var lblCircle3: UILabel!
    @IBOutlet weak var lblAvatarRound: UILabel!
    @IBOutlet weak var imgAvatarRound: UIImageView!
    
    var data: [JSON]?
    
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
        self.lblOpportunity1.layer.masksToBounds = false
        self.lblOpportunity1.layer.cornerRadius = 7
        self.lblOpportunity1.clipsToBounds = true
        self.lblOpportunity2.layer.masksToBounds = false
        self.lblOpportunity2.layer.cornerRadius = 7
        self.lblOpportunity2.clipsToBounds = true
        self.lblOpportunity3.layer.masksToBounds = false
        self.lblOpportunity3.layer.cornerRadius = 7
        self.lblOpportunity3.clipsToBounds = true
        
        self.lblCircle1.layer.masksToBounds = false
        self.lblCircle1.layer.cornerRadius = self.lblCircle1.frame.size.height / 2
        self.lblCircle1.clipsToBounds = true
        self.lblCircle2.layer.masksToBounds = false
        self.lblCircle2.layer.cornerRadius = self.lblCircle2.frame.size.height / 2
        self.lblCircle2.clipsToBounds = true
        self.lblCircle3.layer.masksToBounds = false
        self.lblCircle3.layer.cornerRadius = self.lblCircle3.frame.size.height / 2
        self.lblCircle3.clipsToBounds = true
        
        self.lblAvatarRound.layer.masksToBounds = false
        self.lblAvatarRound.layer.cornerRadius = self.lblAvatarRound.frame.size.height / 2
        self.lblAvatarRound.clipsToBounds = true
        self.imgAvatarRound.layer.masksToBounds = false
        self.imgAvatarRound.layer.cornerRadius = self.imgAvatarRound.frame.size.height / 2
        self.imgAvatarRound.clipsToBounds = true
    }
    
    func setData(){
        self.lblOpportunity1.text = data?[0]["name"].stringValue
        self.lblOpportunity2.text = data?[1]["name"].stringValue
        self.lblOpportunity3.text = data?[2]["name"].stringValue
    }
}
