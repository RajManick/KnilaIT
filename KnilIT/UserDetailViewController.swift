//
//  MusicDetailViewController.swift
//  Sample
//
//  Created by Manickam T on 07/11/20.
//

import UIKit



class MusicDetailViewController: UIViewController {

    var musicData : MusicModelObject!
    var MusicDetailArr : Array<String>!
    
    @IBOutlet weak var trackImgView: UIImageView!{
        didSet{
            trackImgView.layer.cornerRadius = trackImgView.frame.size.height/2
            trackImgView.clipsToBounds = true
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
        self.title = "Music Detail"
        myTblView.register(UINib(nibName: "MusicDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "MusicDetailTableViewCell")
        Helper.app.setURLImageFor(self.trackImgView, url: musicData.artworkUrl100, placeHolderImage: "sample")
    }
    func SetupModel() {
        
    }
    func LoadModel() {
        self.myTblView.reloadData()
    }
    
}
extension MusicDetailViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MusicDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MusicDetailTableViewCell") as! MusicDetailTableViewCell
        
        if  indexPath.row % 2 == 0 {
            cell.detailBGView.backgroundColor = Helper.app.hexStringToUIColor(hex: "796BFF")
        }else{
            cell.detailBGView.backgroundColor = .lightGray
        }
        cell.detailBGView.layer.cornerRadius = 10.0
        cell.detailBGView.clipsToBounds = true
        
        if indexPath.row == 0{
            cell.detailLbl.text = "Title : \(musicData.trackName ?? "")"
        }else if indexPath.row == 1{
            cell.detailLbl.text = "Price : \(musicData.trackPrice ?? "")"
        }
        else if indexPath.row == 2{
            cell.detailLbl.text = "artistName : \(musicData.artistName ?? "")"
        }
        else if indexPath.row == 3{
            cell.detailLbl.text = "releaseDate : \(musicData.releaseDate ?? "")"
        }
        else if indexPath.row == 4{
            cell.detailLbl.text = "primaryGenreName : \(musicData.primaryGenreName ?? "")"
        }
        else if indexPath.row == 5{
            cell.detailLbl.text = "country : \(musicData.country ?? "")"
        }
        else if indexPath.row == 6{
            cell.detailLbl.text = "currency : \(musicData.currency ?? "")"
        }
        return cell
    }
    
    /*    var artworkUrl100: String? = ""
     var trackPrice: String? = ""
     var artistName: String? = ""
     var artistViewUrl: String? = ""
     var releaseDate: String? = ""
     var primaryGenreName: String? = ""
     var country: String? = ""
     var currency: String? = ""**/
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
