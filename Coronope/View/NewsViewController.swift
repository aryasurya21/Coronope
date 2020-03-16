//
//  SecondViewController.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    var service = CoronopeNewsService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.parseNews()
    }


}

