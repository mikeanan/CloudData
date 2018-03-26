//
//  StudentDataTableViewController.swift
//  CloudData
//
//  Created by mike on 2018/3/26.
//  Copyright © 2018年 mike. All rights reserved.
//

import UIKit

//要記得在 identity inspector 中設定 custom class
class StudentDataTableViewController: UITableViewController {

    var studentDataArray = [StudentData]()//存放要顯示用的資料的陣列
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        模擬從網路取得資料
        loadSamplesStudentData()
    }
    
//            模擬從網路取得資料
    func loadSamplesStudentData() {
        //定幾點資料放到陣列中
        let studentData1 = StudentData(name: "mike", gender: "male", email: "mike@gmail.com")
        let studentData2 = StudentData(name: "Jack", gender: "male", email: "Jack@gmail.com")
        let studentData3 = StudentData(name: "John", gender: "male", email: "John@gmail.com")
        let studentData4 = StudentData(name: "Mary", gender: "female", email: "Mary@gmail.com")
        let studentData5 = StudentData(name: "Judy", gender: "female", email: "Judy@gmail.com")
        
        //將模擬資料放到陣列中
        studentDataArray += [studentData1, studentData2, studentData3, studentData4, studentData5]
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
        let number = studentDataArray.count//根據陣列資料數目顯示
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
        let studentData = studentDataArray[indexPath.row]//取出對應的資料放在 cell 介面中
        
        cell.nameLabel.text = studentData.name
        cell.genderLabel.text = studentData.gender
        cell.emailLabel.text = studentData.email
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

}
