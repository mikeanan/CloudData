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
import UIKit
import AlamofireImage

struct localhostStudents: JSONDecodable {
    //更新型別
    var cID: Int?
    var cPhotoPath: String?
    var cName: String?
    var cSex: String?
    var cBirthday: String?
    var cEmail: String?
    var cPhone: String?
    var cAddr: String?
    var cHeight: Int?
    var cWeight: Int?
    
    var photo: UIImage?
    
    init?(json: JSON) {
        self.cID = "cID" <~~ json
        self.cPhotoPath = "cPhotoPath" <~~ json
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
    init(cid cidIn:Int, name nameIn:String, gender genderIn:Int, birth birthIn:String, email emailIn:String, phone phoneIn:String, addr addrIn:String, height heightIn:Int, weight weightIn:Int, photo photoIn:UIImage) {
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
    
    //    測試抓取雲端的檔案
    //    static func fetchImages(completion: @escaping(UIImage) -> Void) {
    //        Alamofire.request("http://homestead.test/img/01.png").responseImage{ response in
    //            guard let image = response.result.value else{
    //                return
    //            }
    //
    //            completion(image)
    //        }
    //    }
    
//    根據資料庫中的圖檔路徑取得圖檔
    static func fetchImage(cPhotoPath cPhotoPathIn:String, completion: @escaping(UIImage) -> Void) {
        Alamofire.request("http://homestead.test/\(cPhotoPathIn)").responseImage{ response in
            guard let image = response.result.value else{
                return
            }
            
            completion(image)
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
    
    static func update_image(image: UIImage, photoPath: String){
        let image = UIImageJPEGRepresentation(image, 0.5)
        let parameters = ["path": photoPath]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(image!, withName: "file", fileName: photoPath, mimeType: "image/jpg")
                for(key, value) in parameters {
                    multipartFormData.append(value.data(using:String.Encoding.utf8)!, withName: key)
                }
            }, to: "http://homestead.test/update_image.php", encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON{ response in
                        print(response.result.value)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
            }
        )
    }
}
