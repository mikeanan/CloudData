 //
//  StudentDataTableViewController.swift
//  CloudData
//
//  Created by mike on 2018/3/26.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit
import Alamofire

//要記得在 identity inspector 中設定 custom class
class StudentDataTableViewController: UITableViewController {

//    var studentDataArray = [StudentData]()//存放要顯示用的資料的陣列
    var localhostStudentsDataArray = [localhostStudents]()//整合網路，改用相對應的資料結構
    var helper = Helper.sharedInstance //調用 singleton 的實體
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        navigationItem.leftBarButtonItem = editButtonItem//顯示 table view list 編輯按鈕
        
//        模擬從網路取得資料
//        loadSamplesStudentData()//已由實際取得資料代替
        
//        實際從網路取得資料
        localhostStudents.fetch(){ dataTransfer in//在區塊中實作 completion handler 要做的事
            self.localhostStudentsDataArray = dataTransfer//改用 githubDataArray
            print("fetch() 完成後")
//            print(self.githubDataArray)
            
            print(self.helper.helperLocalhostStudentsDataArray as Any)
            
//            在 completion handler 中可以確保取得資料後，再根據資料取得圖檔
            for index in 0..<self.localhostStudentsDataArray.count {
                let cPhotoPath = self.localhostStudentsDataArray[index].cPhotoPath
                
                //傳入圖檔路徑
                localhostStudents.fetchImage(cPhotoPath: cPhotoPath!){ dataTransfer in
                    self.localhostStudentsDataArray[index].photo = dataTransfer
                    self.tableView.reloadData()
                }
            }
            self.tableView.reloadData()//在非同步得到資料後，再次更新 UI
        }
        
//        寫在這無法如我們預期的更新圖檔到資料陣列中，因為還沒取得資料
//        localhostStudents.fetchImages(){ dataTransfer in
//            for index in 0..<self.localhostStudentsDataArray.count {
//                self.localhostStudentsDataArray[index].photo = dataTransfer
//            }
//
//            self.tableView.reloadData()//在非同步得到資料後，再次更新 UI
//        }
        
    }
    
//            模擬從網路取得資料
//    func loadSamplesStudentData() {//不需要了
//        //定幾點資料放到陣列中
//        let studentData1 = StudentData(name: "mike", gender: "male", email: "mike@gmail.com")
//        let studentData2 = StudentData(name: "Jack", gender: "male", email: "Jack@gmail.com")
//        let studentData3 = StudentData(name: "John", gender: "male", email: "John@gmail.com")
//        let studentData4 = StudentData(name: "Mary", gender: "female", email: "Mary@gmail.com")
//        let studentData5 = StudentData(name: "Judy", gender: "female", email: "Judy@gmail.com")
//
//        //將模擬資料放到陣列中
//        studentDataArray += [studentData1, studentData2, studentData3, studentData4, studentData5]
//    }
    
    //讓 IB 可以找到 segue 切換時，要使用的動作
    @IBAction func unwindToStudentDataList(sender: UIStoryboardSegue) {
        //檢查是從哪個頁面切過來的，檢查傳回來的資料
        if let sourceViewController = sender.source as? ViewController,
            let localhostData = sourceViewController.localhostDataTransfer {//改用 githubDataTransfer
            
//            判斷是否要更新 table view 的項目，或是新增項目
            if let selectedIndexPath = tableView.indexPathForSelectedRow {//如果是點選某一項，則更新該項的資料及 UI
                
                //為了傳給後台使用
                let parameters: Parameters = [ "cID": localhostData.cID!,
                                               "cName": localhostData.cName!,
                                               "cSex": localhostData.cSex!,
                                               "cBirthday": localhostData.cBirthday!,
                                               "cEmail": localhostData.cEmail!,
                                               "cPhone": localhostData.cPhone!,
                                               "cAddr": localhostData.cAddr!,
                                               "cHeight": localhostData.cHeight!,
                                               "cWeight": localhostData.cWeight! ]
                //把包好的資料，寫到後台伺服器
                localhostStudents.update(parameters: parameters)
                
                localhostStudentsDataArray[selectedIndexPath.row] = localhostData//改用 githubDataArray, githubData
                tableView.reloadRows(at: [selectedIndexPath], with: .fade)
            } else {//如果沒有點選某一項，判斷為新增一筆資料 //改用 githubDataArray, githubData
                let indexPath = IndexPath(row: localhostStudentsDataArray.count, section: 0)
                
                //為了傳給後台使用
                let parameters: Parameters = [ "cName": localhostData.cName!,
                                               "cSex": localhostData.cSex!,
                                               "cBirthday": localhostData.cBirthday!,
                                               "cEmail": localhostData.cEmail!,
                                               "cPhone": localhostData.cPhone!,
                                               "cAddr": localhostData.cAddr!,
                                               "cHeight": localhostData.cHeight!,
                                               "cWeight": localhostData.cWeight! ]
                //把包好的資料，寫到後台伺服器
                localhostStudents.add(parameters: parameters)
                
                localhostStudentsDataArray.append(localhostData)//把資料加到 list 用的資料陣列
                tableView.insertRows(at: [indexPath], with: .automatic)//更新 UI
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1//要顯示 list 行數
    }

//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let number = localhostStudentsDataArray.count//根據陣列資料數目顯示 //改用 githubDataArray
        print("目前會傳到 UI 中的資料個數")
        return number
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "StudentDataTableViewCell"//使用在 UI 的 custom cell view 屬性中設定好的
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! StudentDataTableViewCell//要轉成 custom cell view class 的類別
        
        // Configure the cell...
        //改用 githubDataArray, githubData
        let studentData = localhostStudentsDataArray[indexPath.row]//取出對應的資料放在 cell 介面中
        
        cell.nameLabel.text = studentData.cName
        cell.genderLabel.text = studentData.cSex
        cell.emailLabel.text = studentData.cEmail
        cell.phptoImage.image = studentData.photo
        
        print("資料更新到 UI 中")
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //需要同時刪除對應的資料，否則更新 table view list 時，會因為資料對不上而當掉
            localhostStudentsDataArray.remove(at: indexPath.row)//改用 githubDataArray
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch(segue.identifier ?? "") {//切換之前可以判斷用什麼方式
        case "AddStudentData":
            print("AddStudentData, prepare for segue")
        case "ShowStudentData":
            print("ShowStudentData, prepare for segue")
            guard let viewController = segue.destination as? ViewController else {
                fatalError("不是我們要切換的頁面")
            }
            
            guard let selectedStudentDataCell = sender as? StudentDataTableViewCell else {
                fatalError("不是我們點選的 cell 類別")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedStudentDataCell) else {
                fatalError("無法解出點選列的 index")
            }
            
            //改用 githubDataArray, githubData
            let selectedGithubData = localhostStudentsDataArray[indexPath.row]//找到對應位置的資料
            viewController.localhostDataTransfer = selectedGithubData//將資料放到目標頁面的變數中，準備顯示
            
        default:
            fatalError("segue identifier unknown...")
        }
    }

}
