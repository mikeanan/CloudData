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

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBAction func okButton(_ sender: UIButton) {
    }
    
    //直接從 IB 拖拉過來這裹即可
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    //直接從 IB 拖拉過來這裹即可
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var studenDataTransfer: StudentData!//用來讓 segue 回傳資料用
    
    //segue 切換之前的 prepare function，可以用來檢查 sender 是誰
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as? UIBarButtonItem {
            let name = nameLabel.text ?? "No data"
            let gender = genderLabel.text ?? "No data"
            let email = emailLabel.text ?? "No data"
            
            studenDataTransfer = StudentData(name: name, gender: gender, email: email)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Alamofire.request("https://api.github.com/users/octocat/repos").responseJSON { response in
            guard let result_value_from_url = response.result.value,//回傳的是 json 物件的陣列
                let array_of_json_object = result_value_from_url as? [Any] else {//將資料轉成 json 物件的陣列
                    return//請留意，guard 可以包括多個條件，而且可以使用之前條件得到的變數
            }
    //      if let JSON_object = array_of_json_object.first {//取得陣列中第一個 json 物件，然後在後續解析
            for JSON_object in array_of_json_object {//取出陣列中的每一個 json 物件，然後解析
                guard let dictionary = JSON_object as? [String: Any],
                    let id_value = dictionary["id"] as? Int else {
                    return
                }
                print("got value of the key:(id)")
                print(id_value)

                guard let owner_dictionary = dictionary["owner"] as? [String: Any],//解第2層資料
                let owner_id_value = owner_dictionary["id"] as? Int else {
                    return
                }
                print("got value of the key:(owner_id)")
                print(owner_id_value)

                guard let private_value = dictionary["private"] as? Bool else {
                    return
                }
                print("got value of the key:(private)")
                print(private_value)
                
//                用來存放 JSON 內容的變數
                let api_git_hubcom = apiGithubCom(id: id_value,
                                                  owner_id: owner_id_value,
                                                  key_private: private_value)
                print(api_git_hubcom)
                
//                傳入資料，在 struct 中解析
                let api_git_hubcom2 = apiGithubCom(dictionary: dictionary)
                print(api_git_hubcom2)
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

