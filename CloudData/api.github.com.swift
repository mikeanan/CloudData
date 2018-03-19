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
    
    init() {//在這，不會影響預設的 init function
        self.id = 0
        self.owner_id = 0
        self.key_private = false
    }
}
