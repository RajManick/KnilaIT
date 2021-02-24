//
//  ViewController.swift
//  KnilIT
//
//  Created by Manickam T on 24/02/21.
//

import UIKit
import AFNetworking
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
    var userListArr : [UserModelObject]!
    
    @IBOutlet weak var myTblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SetupUI()
        self.SetupModel()
        // Do any additional setup after loading the view.
    }
    
    func SetupUI()  {
        self.title = "User List"
        userListArr = []
        myTblView.register(UINib(nibName: "UserListCell", bundle: nil), forCellReuseIdentifier: "UserListCell")
        myTblView.tableFooterView = UIView()
    }
    
    func SetupModel() {
        Helper.app.ShowActivityLoader(controller : self)
        self.perform(#selector(callUserListAPI), with: nil, afterDelay: 2.0)
    }
    
    func LoadModel(){
        GetUserDatafromDB()
        self.myTblView.reloadData()
        Helper.app.RemoveActivityLoader()
    }
    
    func GetUserDatafromDB()  {
        userListArr = []
        userListArr = Helper.app.retrieveUserData()
    }
    
  @objc func callUserListAPI() {
        let manager = AFHTTPSessionManager.init()
        manager.get("https://reqres.in/api/users", parameters: nil, headers: nil, progress: nil) { [self] (task, responseObject) in
            let response = responseObject as! NSDictionary
            let UserList : Array = response.value(forKey: "data") as! Array<Any>
            for data in UserList {
                let userData = UserModelObject()
                userData.first_name = (data as AnyObject).value(forKey: "first_name") as? String
                userData.last_name = (data as AnyObject).value(forKey: "last_name") as? String
                userData.avatar = (data as AnyObject).value(forKey: "avatar") as? String
                userData.email = (data as AnyObject).value(forKey: "email") as? String
                userData.id = (data as AnyObject).value(forKey: "id") as? Int64
                Helper.app.CreateUserDB(userData: userData)
            }
            LoadModel()
        } failure: { (task, error) in
            print(error)
            self.LoadModel()
        }
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserListCell = tableView.dequeueReusableCell(withIdentifier: "UserListCell") as! UserListCell
        let data = userListArr[indexPath.row]
        Helper.app.setURLImageFor(cell.userImgView, url: data.avatar, placeHolderImage: "sample_profile")
        cell.userNameLbl.text = "\(data.first_name ?? "") \(data.last_name ?? "")"
        cell.emailLbl.text = data.email
        cell.userImgView.layer.cornerRadius = cell.userImgView.frame.size.height/2
        cell.userImgView.layer.borderWidth = 1.0
        cell.userImgView.layer.borderColor = UIColor.white.cgColor
        cell.userImgView.clipsToBounds = true
        cell.BgView.layer.cornerRadius = 10
        cell.BgView.clipsToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        vc.userData = userListArr[indexPath.row]
        self.navigationController?.pushViewController(vc,
                                                      animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
