//
//  ViewController.swift
//  CloudData
//
//  Created by mike on 2018/2/23.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {//修改成可以輸入
    var apiGithubComGlossJson: [apiGithubComGloss] = []

    @IBOutlet weak var nameTextField: UITextField!//修改成可以輸入
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addrTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var photoImage: UIImageView!
    
    //直接從 IB 拖拉過來這裹即可
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {//2 個 segue 跳回上一頁的方式不同
        let isPresentingInAddItem = presentingViewController is UINavigationController
        if isPresentingInAddItem {
            dismiss(animated: true, completion: nil)//使用 modal 頁面時
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)//使用 show 頁面時
        } else {
            fatalError("not belong to any navigation controller")
        }
    }
    
    //直接從 IB 拖拉過來這裹即可
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //改用 apiGithubComGloss, githubDataTransfer
    var localhostDataTransfer: localhostStudents!//用來讓 segue 回傳資料用
    
    //segue 切換之前的 prepare function，可以用來檢查 sender 是誰
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === sender as? UIBarButtonItem {
            let name = nameTextField.text ?? "No data"
            let gender = (genderTextField.text ?? "No data") == "F" ? 1 : 2
            let birth = birthTextField.text ?? "No data"
            let email = emailTextField.text ?? "No data"
            let phone = phoneTextField.text ?? "No data"
            let addr = addrTextField.text ?? "No data"
            let height = Int(heightTextField.text!) ?? 0
            let weight = Int(weightTextField.text!) ?? 0
            let photo = photoImage.image
            
            //改用 apiGithubComGloss, githubDataTransfer
            //判斷是否有傳入資料來決定是否要建立傳資料用的物件
            if( localhostDataTransfer == nil ) {
                localhostDataTransfer = localhostStudents(cid: localhostDataTransfer == nil ? 0 : localhostDataTransfer.cID!, name: name, gender: gender, birth: birth, email: email, phone: phone, addr: addr, height: height, weight: weight, photo: photo!)//自訂 init
            } else {
                localhostDataTransfer.cName = name
                localhostDataTransfer.cSex = gender == 1 ? "F" : "M"
                localhostDataTransfer.cBirthday = birth
                localhostDataTransfer.cEmail = email
                localhostDataTransfer.cPhone = phone
                localhostDataTransfer.cAddr = addr
                localhostDataTransfer.cHeight = height
                localhostDataTransfer.cWeight = weight
                localhostDataTransfer.photo = photo
            }
        }
    }
    
    @IBAction func selectPhoto(_ sender: UITapGestureRecognizer) {
        let selectPhotoController = UIImagePickerController()
        selectPhotoController.sourceType = .photoLibrary
        selectPhotoController.delegate = self
        
        present(selectPhotoController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("\(info)")
        }
        photoImage.image = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        TODO：要搬到程式起始處
//        apiGithubComGloss.fetch(){ dataTransfer in//在區塊中實作 completion handler 要做的事
//            self.apiGithubComGlossJson = dataTransfer//把收到的資料放在這個類別的變數中
//            print("fetch() 完成後")
//            print(self.apiGithubComGlossJson)
//        }
        
        //解出傳過來的資料
        //改用 apiGithubComGloss, githubDataTransfer
        guard let githubDataTmp = localhostDataTransfer else {
//            fatalError("沒有傳進來的資料")
            return
        }
        
        //改用 githubDataTmp
        nameTextField.text = githubDataTmp.cName
        genderTextField.text = githubDataTmp.cSex
        birthTextField.text = githubDataTmp.cBirthday
        emailTextField.text = githubDataTmp.cEmail
        phoneTextField.text = githubDataTmp.cPhone
        addrTextField.text = githubDataTmp.cAddr
        heightTextField.text = String(githubDataTmp.cHeight!)
        weightTextField.text = String(githubDataTmp.cWeight!)
        photoImage.image = githubDataTmp.photo
        
        nameTextField.delegate = self
        genderTextField.delegate = self
        birthTextField.delegate = self
        emailTextField.delegate = self
        phoneTextField.delegate = self
        addrTextField.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self
        
//        點選別的地方來收起鍵盤
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false//讓 tableView 可以正常運作
        view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {//點選別的地方來收起鍵盤
        view.endEditing(true)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

