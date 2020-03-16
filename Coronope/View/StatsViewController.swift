//
//  StatsViewController.swift
//  Coronope
//
//  Created by IT Division on 15/03/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit
import PromiseKit

class StatsViewController: UIViewController {

    var coronopeService = CoronopeService()
    
    @IBOutlet weak var confirmedLabelID: UILabel!
    @IBOutlet weak var confirmedLabelGlobal: UILabel!
    @IBOutlet weak var recoveredLabelID: UILabel!
    @IBOutlet weak var deathLabelID: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        coronopeService.delegate = self
        initData()
    }
    
    func initData(){
        asyncFethcingData()
    }
      
    func asyncFethcingData(){
        let group = DispatchGroup()
        group.enter()
        coronopeService.fetchLocalCases()
        coronopeService.fetchGlobalConfirmedCases()
        group.leave()
        group.wait()
        self.setupStyle()
    }
    
    func setupStyle(){
        self.confirmedLabelGlobal.textColor = .yellow
        self.confirmedLabelID.textColor = .yellow
        self.deathLabelID.textColor = .red
        self.recoveredLabelID.textColor = .green
        
        self.confirmedLabelGlobal.font = UIFont.boldSystemFont(ofSize: CGFloat(CoronopeConstants.globalFontSize))
        self.confirmedLabelID.font = UIFont.boldSystemFont(ofSize: CGFloat(CoronopeConstants.localFontSize))
        self.deathLabelID.font = UIFont.boldSystemFont(ofSize: CGFloat(CoronopeConstants.localFontSize))
        self.recoveredLabelID.font = UIFont.boldSystemFont(ofSize: CGFloat(CoronopeConstants.localFontSize))
    }
}


extension StatsViewController : CoronopeServiceDelegate {
    func didGetGlobalData(coronopeModel: CoronopeModel) {
        DispatchQueue.main.async {
            self.confirmedLabelGlobal.text = "\(coronopeModel.coronopeGlobal?.value ?? 0)"
        }
    }
    
    func didGetLocalData(coronopeModel: CoronopeModel) {
        DispatchQueue.main.async {
            self.confirmedLabelID.text = "\( coronopeModel.coronopeIndo?.confirmed ?? 0)"
            self.deathLabelID.text = "\(coronopeModel.coronopeIndo?.deaths ?? 0)"
            self.recoveredLabelID.text = "\(coronopeModel.coronopeIndo?.recovered ?? 0)"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
