//
//  api.github.com.swift
//  CloudData
//
//  Created by mike on 2018/3/5.
//  Copyright © 2018年 mike. All rights reserved.
//

import Foundation

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
}
