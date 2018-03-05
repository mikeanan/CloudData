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
        
        Alamofire.request("https://httpbin.org/get").responseJSON { response in
            if let JSON = response.result.value {
                if let dictionary = JSON as? [String: Any] {//let the data as a kind of array
                    
                    if let value = dictionary["origin"] as? String {
                        print("got value of the key:(origin)")
                        print(value)
                    }
                    
                    if let value = dictionary["url"] as? String {
                        print("got value of the key:(url)")
                        print(value)
                    }
                    
                    if let value = dictionary["args"] as? String {
                        print("got value of the key:(args)")
                        print(value)
                    }
                    
                    //parsing the data of headers as JSON object
                    if let headers_dictionary = dictionary["headers"] as? [String: Any] {
                        
                        if let value = headers_dictionary["Accept"] as? String {
                            print("got value of the key:(Accept)")
                            print(value)
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

