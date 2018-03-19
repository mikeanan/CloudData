//
//  api.github.com.swift
//  CloudData
//
//  Created by mike on 2018/3/5.
//  Copyright © 2018年 mike. All rights reserved.
//

import Foundation
import Alamofire

//宣告 struct 及其名稱，定義用來存放 JSON 內容的變數
struct apiGithubCom {
    let id: Int
    let owner_id: Int
    let key_private: Bool
    
//    init() {//放在這會改寫預設的 init function (建構子)
//        self.id = 0
//        self.owner_id = 0
//        self.key_private = false
//    }
}

extension apiGithubCom {
//    將解析的程式放在 struct
//    init(dictionary: [String: Any]) throws {//
//        guard let id = dictionary["id"] as? Int,
//            let key_private = dictionary["private"] as? Bool else {
//                throw 0 as! Error//初始化不能用 return
//        }
//    throw 還需要進步定義一些訊息
//    比較簡單的解決上面的問題 ？＋return nil,用 optional 跳過 throw
    init?(dictionary: [String: Any]) {
        guard let id = dictionary["id"] as? Int,
            let key_private = dictionary["private"] as? Bool else {
                return nil
        }
        
        self.id = id
        self.owner_id = 0
        self.key_private = key_private
    }
    
    static func fetch() {//定義成 static 時，會預先載入到記憶體中，所以，struct 還沒初始化就可以使用
        //以下動作，跟之前放在外部時一樣
        Alamofire.request("https://api.github.com/users/octocat/repos").responseJSON { response in
            guard let result_value_from_url = response.result.value,//回傳的是 json 物件的陣列
                let array_of_json_object = result_value_from_url as? [Any] else {//將資料轉成 json 物件的陣列
                    return//請留意，guard 可以包括多個條件，而且可以使用之前條件得到的變數
            }
            
            for JSON_object in array_of_json_object {//取出陣列中的每一個 json 物件，然後解析
                guard let dictionary = JSON_object as? [String: Any] else {
                    return
                }
                
                //                傳入資料，在 struct 中解析
                guard let api_git_hub_com = apiGithubCom(dictionary: dictionary) else {
                    return
                }
                print(api_git_hub_com as Any)
            }
        }
    }
}
