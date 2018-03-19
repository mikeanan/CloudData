//
//  ViewController.swift
//  CloudData
//
//  Created by mike on 2018/2/23.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var apiGithubComGlossJson: [apiGithubComGloss] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        apiGithubComGloss.fetch(){ dataTransfer in//在區塊中實作 completion handler 要做的事
            self.apiGithubComGlossJson = dataTransfer//把收到的資料放在這個類別的變數中
            print("fetch() 完成後")
            print(self.apiGithubComGlossJson)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

