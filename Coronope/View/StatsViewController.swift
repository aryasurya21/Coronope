//
//  StatsViewController.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {

    var coronopeService = CoronopeService()
    
    @IBOutlet weak var confirmedLabelID: UILabel!
    @IBOutlet weak var confirmedLabelGlobal: UILabel!
    @IBOutlet weak var recoveredLabelID: UILabel!
    @IBOutlet weak var deathLabelID: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        coronopeService.delegate = self
        coronopeService.fetchAllCases()
    }
    
    
    func setupStyle(){
        self.confirmedLabelID.textColor = .yellow
        self.confirmedLabelGlobal.textColor = .yellow
        self.deathLabelID.textColor = .red
        self.recoveredLabelID.textColor = .green
        
        self.confirmedLabelID.font = UIFont.boldSystemFont(ofSize: CGFloat(CoronopeConstants.fontSize))
        self.confirmedLabelGlobal.font = UIFont.boldSystemFont(ofSize: CGFloat(CoronopeConstants.fontSize))
        self.deathLabelID.font = UIFont.boldSystemFont(ofSize: CGFloat(CoronopeConstants.fontSize))
        self.recoveredLabelID.font = UIFont.boldSystemFont(ofSize: CGFloat(CoronopeConstants.fontSize))
    }
}


extension StatsViewController : CoronopeServiceDelegate {
    
    func didGetData(coronopeModel: CoronopeModel) {
        DispatchQueue.main.async {
            self.confirmedLabelID.text = "\( coronopeModel.coronopeIndo?.confirmed ?? 0)"
            self.confirmedLabelGlobal.text = "\(coronopeModel.coronopeGlobal?.value ?? 0)"
            self.deathLabelID.text = "\(coronopeModel.coronopeIndo?.deaths ?? 0)"
            self.recoveredLabelID.text = "\(coronopeModel.coronopeIndo?.recovered ?? 0)"
        
            self.setupStyle()
        }
      
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
