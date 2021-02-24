//
//  UserDetailViewController.swift
//  KnilIT
//
//  Created by Manickam T on 24/02/21.
//

import UIKit



class UserDetailViewController: UIViewController {

    var userData : UserModelObject!
    
    @IBOutlet weak var UserImgView: UIImageView!{
        didSet{
            UserImgView.layer.cornerRadius = UserImgView.frame.size.height/2
            UserImgView.layer.borderWidth = 2.0
            UserImgView.layer.borderColor = UIColor.white.cgColor
            UserImgView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var myTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupUI()
        SetupModel()
        LoadModel()
    }
    
    func SetupUI() {
        self.title = "User Detail"
        myTblView.register(UINib(nibName: "UserDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "UserDetailTableViewCell")
        myTblView.tableFooterView = UIView()
    
    }
    func SetupModel() {
        Helper.app.setURLImageFor(self.UserImgView, url: userData.avatar, placeHolderImage: "sample_profile")
    }
    func LoadModel() {
        self.myTblView.reloadData()
    }
    
}
extension UserDetailViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "UserDetailTableViewCell") as! UserDetailTableViewCell
        
        if  indexPath.row % 2 == 0 {
            cell.detailBGView.backgroundColor = Helper.app.hexStringToUIColor(hex: "942192")
        }else{
            cell.detailBGView.backgroundColor = .lightGray
        }
        cell.detailBGView.layer.cornerRadius = 10.0
        cell.detailBGView.clipsToBounds = true
         if indexPath.row == 0{
            cell.detailLbl.text = "User Id : \(userData.id ?? 0)"
        }
        else if indexPath.row == 1{
            cell.detailLbl.text = "First Name : \(userData.first_name ?? "")"
        }else if indexPath.row == 2{
            cell.detailLbl.text = "Last Name : \(userData.last_name ?? "")"
        }
        else if indexPath.row == 3{
            cell.detailLbl.text = "Email : \(userData.email ?? "")"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
