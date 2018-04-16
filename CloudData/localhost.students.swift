//
//  localhost.students.swift
//  CloudData
//
//  Created by mike on 2018/4/9.
//  Copyright © 2018年 mike. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

struct localhostStudents: JSONDecodable {
    //更新型別
    var cID: Int?
    var cName: String?
    var cSex: String?
    var cBirthday: String?
    var cEmail: String?
    var cPhone: String?
    var cAddr: String?
    var cHeight: Int?
    var cWeight: Int?
    
    init?(json: JSON) {
        self.cID = "cID" <~~ json
        self.cName = "cName" <~~ json
        self.cSex = "cSex" <~~ json
        self.cBirthday = "cBirthday" <~~ json
        self.cEmail = "cEmail" <~~ json
        self.cPhone = "cPhone" <~~ json
        self.cAddr = "cAddr" <~~ json
        self.cHeight = "cHeight" <~~ json
        self.cWeight = "cWeight" <~~ json
    }
}

extension localhostStudents {
    
    //可能需要調整這個 init
    //cid 不一定有，傳入之前要判斷
    init(cid cidIn:Int, name nameIn:String, gender genderIn:Int, birth birthIn:String, email emailIn:String, phone phoneIn:String, addr addrIn:String, height heightIn:Int, weight weightIn:Int) {
        self.cID = cidIn
        self.cName = nameIn
        self.cSex = genderIn == 1 ? "F" : "M"//為了 mysql enum 做判斷
        self.cBirthday = birthIn
        self.cEmail = emailIn
        self.cPhone = phoneIn
        self.cAddr = addrIn
        self.cHeight = heightIn
        self.cWeight = weightIn
    }
    
    static func fetch(completion: @escaping([localhostStudents]) -> Void) {
        //若用 http 時，要修改專案的安全設定
        //localhost 或 homestead.test 是根據自己的環境設定
        Alamofire.request("http://homestead.test").responseJSON { response in
            guard let dataTransfer = [localhostStudents].from(jsonArray: response.result.value as! [JSON]) else {
                return
            }
            
            var helper = Helper.sharedInstance
            helper.helperLocalhostStudentsDataArray = dataTransfer
            
            print("fetch() 完成")
            completion(dataTransfer)
        }
    }
    
//    新增用
    static func add(parameters: Parameters){
        Alamofire.request("http://homestead.test/add.php", method: .post, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            print("from here...")
            print(response.request as Any)
            print(response.response as Any)
            print(response.data as Any)
            print(response.result as Any)

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }

        }
    }
    
//    更新用
    static func update(parameters: Parameters){
        Alamofire.request("http://homestead.test/update.php", method: .post, parameters: parameters, encoding: URLEncoding.default).responseString { response in
            print("response.request")
            print(response.request as Any)
            print("response.response")
            print(response.response as Any)
            print("response.data")
            print(response.data as Any)
            print("response.result")
            print(response.result as Any)
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }

        }
    }
}
