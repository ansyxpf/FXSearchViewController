//
//  ViewController.swift
//  FXSearchController
//
//  Created by 徐鹏飞 on 2019/12/18.
//  Copyright © 2019 徐鹏飞. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var titleStr: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = titleStr
        
        self.setupUI()
        
    }

    func setupUI() -> () {
        nameLbl.frame = CGRect.init(x: 0, y: 100, width: kSCREEN_WIDTH, height: 20)
        self.view.addSubview(nameLbl)
    }
    
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel.init()
        lbl.text = "第二个界面内容"
        lbl.font = UIFont.systemFont(ofSize: 14)
        lbl.textColor = .black
        return lbl
    }()
}

