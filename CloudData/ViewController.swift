//
//  ViewController.swift
//  CloudData
//
//  Created by mike on 2018/2/23.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit
import Gloss

class ViewController: UIViewController {
    var apiGithubComJson: [apiGithubCom] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiGithubCom.fetch(){ dataTransfer in//在區塊中實作 completion handler 要做的事
            self.apiGithubComJson = dataTransfer//把收到的資料放在這個類別的變數中
            print("fetch() 完成後")
            print(self.apiGithubComJson)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

