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
struct apiGithubComGloss: Decodable {
    //變數必需是 optional
    let id: Int?
    let key_private: Bool?
    
    //init 也要符合 Gloss 要求
    init?(json: JSON) {
        self.id = "id" <~~ json //給定 key 即可解出 value
        self.key_private = "private" <~~ json
    }
}


extension apiGithubComGloss {
    static func fetch(completion: @escaping([apiGithubComGloss]) -> Void) {//定義成 static 時，會預先載入到記憶體中，所以，struct 還沒初始化就可以使用
        //以下動作，跟之前放在外部時一樣
        Alamofire.request("https://api.github.com/users/octocat/repos").responseJSON { response in
            

            var dataTransfer: [apiGithubComGloss] = []//把解析出來的資料放這，用來回傳資料

            guard let result_value_from_url = response.result.value,//回傳的是 json 物件的陣列
                let array_of_json_object = result_value_from_url as? [Any] else {//將資料轉成 json 物件的陣列
                    return//請留意，guard 可以包括多個條件，而且可以使用之前條件得到的變數
            }

            for JSON_object in array_of_json_object {//取出陣列中的每一個 json 物件，然後解析
                guard let dictionary = JSON_object as? [String: Any] else {
                    return
                }

                //                傳入資料，在 struct 中解析
                guard let api_git_hub_com = apiGithubComGloss(json: dictionary) else {
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
