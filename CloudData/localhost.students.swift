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
    let cID: String?
    let cName: String?
    let cSex: String?
    let cBirthday: String?
    let cEmail: String?
    let cPhone: String?
    let cAddr: String?
    let cHeight: String?
    let cWeight: String?
    
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
    init(name nameIn:String, gender genderIn:String, email emailIn:String) {
        self.cID = "cID"
        self.cName = "cName"
        self.cSex = "cSex"
        self.cBirthday = "cBirthday"
        self.cEmail = "cEmail"
        self.cPhone = "cPhone"
        self.cAddr = "cAddr"
        self.cHeight = "cHeight"
        self.cWeight = "cWeight"
    }
    
    static func fetch(completion: @escaping([localhostStudents]) -> Void) {
        //若用 http 時，要修改專案的安全設定
        Alamofire.request("http://localhost/PHP/index.php").responseJSON { response in
            guard let dataTransfer = [localhostStudents].from(jsonArray: response.result.value as! [JSON]) else {
                return
            }
            
            var helper = Helper.sharedInstance
            helper.helperLocalhostStudentsDataArray = dataTransfer
            
            print("fetch() 完成")
            completion(dataTransfer)
        }
    }
}
