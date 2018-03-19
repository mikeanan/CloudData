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
    let key_private: Bool
    
//    let owner: (//tuple 必需至少 2 個，改用底下的 struct
//    id: Int
//    )
    let owner: apiGithubComJsonOwner
}

struct apiGithubComJsonOwner {
    let id: Int
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
        
        guard let dictionaryOwner = dictionary["owner"] as? [String: Any],//解第 2 層
            let owner_id = dictionaryOwner["id"] as? Int else {
                return nil
        }
        
        self.id = id
        self.key_private = key_private
//        self.owner = (owner_id)//tuple 不能只有一個東西
        self.owner = apiGithubComJsonOwner(id: owner_id)//改用 struct
    }
    
//    定義 completion handler 來執行完成後的動作，執行的實作放在外部，
    static func fetch(completion: @escaping([apiGithubCom]) -> Void) {//定義成 static 時，會預先載入到記憶體中，所以，struct 還沒初始化就可以使用
        //以下動作，跟之前放在外部時一樣
        Alamofire.request("https://api.github.com/users/octocat/repos").responseJSON { response in
            
            var dataTransfer: [apiGithubCom] = []//把解析出來的資料放這，用來回傳資料
            
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
                
                dataTransfer.append(api_git_hub_com)//將解析出來的物件（內含每筆資料）附加到陣列中
            }
            
            print("fetch() 完成")
            completion(dataTransfer)//將陣列使用 completion handler 傳出
        }
    }
}
