//
//  api.github.com.swift
//  CloudData
//
//  Created by mike on 2018/3/5.
//  Copyright © 2018年 mike. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

//使用 Gloss 解析 JSON
struct apiGithubComGloss: JSONDecodable {//最新版本改用 JSONDecodable
    //變數必需是 optional
    let id: Int?
    let name: String?
    let url: String?//for gender
    let full_name: String?//for email
    let key_private: Bool?
    let owner: apiGithubComOwnerGloss?//第 2 層的格式
    
    //init 也要符合 Gloss 要求
    init?(json: JSON) {
        self.id = "id" <~~ json //給定 key 即可解出 value
        self.name = "name" <~~ json
        self.url = "url" <~~ json
        self.full_name = "full_name" <~~ json
        self.key_private = "private" <~~ json
        self.owner = "owner" <~~ json
    }
}

struct apiGithubComOwnerGloss: JSONDecodable {//跟第 1 層一樣的方法，改用 JSONDecodable 才能解出
    
    let id: Int?
    
    init?(json: JSON) {
        self.id = "id" <~~ json
    }
}

extension apiGithubComGloss {
    
    //讓 UI 傳回資料用
    init(name nameIn:String, gender genderIn:String, email emailIn:String) {
        self.id = nil
        self.name = nameIn
        self.url = genderIn
        self.full_name = emailIn
        self.key_private = nil
        self.owner = nil
    }

    static func fetch(completion: @escaping([apiGithubComGloss]) -> Void) {//定義成 static 時，會預先載入到記憶體中，所以，struct 還沒初始化就可以使用
        //以下動作，跟之前放在外部時一樣
        Alamofire.request("https://api.github.com/users/octocat/repos").responseJSON { response in
            //改用 JSONDecodable 才能直接解 JSON 陣列
            guard let dataTransfer = [apiGithubComGloss].from(jsonArray: response.result.value as! [JSON]) else {
                return
            }
            
            print("fetch() 完成")
            completion(dataTransfer)//將陣列使用 completion handler 傳出
        }
    }
}
