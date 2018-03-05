//
//  ViewController.swift
//  CloudData
//
//  Created by mike on 2018/2/23.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request("https://api.github.com/users/octocat/repos").responseJSON { response in
            if let result_value_from_url = response.result.value {//回傳的是 json 物件的陣列
                if let array_of_json_object = result_value_from_url as? [Any] {//將資料轉成 json 物件的陣列
                    if let JSON_object = array_of_json_object.first {//取得陣列中第一個 json 物件，然後在後續解析
                        if let dictionary = JSON_object as? [String: Any] {
                            if let value = dictionary["id"] as? Int {
                                print("got value of the key:(id)")
                                print(value)
                            }
                            
                            if let owner_dictionary = dictionary["owner"] as? [String: Any] {//解第2層資料
                                if let value = owner_dictionary["site_admin"] as? Bool {
                                    print("got value of the key:(site_admin)")
                                    print(value)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

