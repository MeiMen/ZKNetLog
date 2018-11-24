//
//  ViewController.swift
//  ZKNetLogDemoSwift
//
//  Created by admin on 2018/11/24.
//  Copyright © 2018 ZK. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
         
            
        }
        
    }


}

