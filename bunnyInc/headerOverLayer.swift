//
//  headerOverLayer.swift
//  bunnyInc
//
//  Created by Christian Ernesto Chavarría Méndez on 06/10/18.
//  Copyright © 2018 Christian Ernesto Chavarría Méndez. All rights reserved.
//

import UIKit

class headerOverLayer: UIViewController{
    
    @IBOutlet weak var lblHeaderTitle: UILabel!
    
    var headerTitle:String?
    
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
        self.lblHeaderTitle.text = headerTitle
    }

}
