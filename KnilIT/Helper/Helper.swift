//
//  Helper.swift
//  Sample
//
//  Created by Manickam T on 06/11/20.
//

import Foundation
import UIKit
import SDWebImage
import CoreData
import FullMaterialLoader

class Helper {
    
    var indicator: MaterialLoadingIndicator!
    var Activityview : UIView?
    
    static var app: Helper = {
        return Helper()
    }()
    
    func ShowAlertController(controller : UIViewController, titleType : String, message : String){
        let alert = UIAlertController.init(title: titleType, message: message, preferredStyle: .alert)
        let OkAction  = UIAlertAction.init(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(OkAction)
        controller.present(alert, animated: true, completion: nil)
    }
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func setURLImageFor(_ aImageView: UIImageView?, url aURLString: String?, placeHolderImage aPlaceHolderImageString: String?) {
        var aURLString = aURLString
        aURLString = aURLString?.trimmingCharacters(in: .whitespaces)
        let aURL = URL(string: aURLString ?? "")
        weak var imageView_ = aImageView
        imageView_?.sd_setImage(with: aURL, placeholderImage: UIImage(named: aPlaceHolderImageString ?? ""), completed: { image, error, cacheType, imageURL in
            if image == nil {
                imageView_?.image = UIImage(named: aPlaceHolderImageString ?? "")
            } else {
                imageView_?.image = image
            }
        })
    }
    
    
    func ShowActivityLoader(controller : UIViewController) {
        Activityview = UIView.init(frame: CGRect(x: 0, y: 0, width: controller.view.frame.size.width, height: controller.view.frame.size.height))
        Activityview?.backgroundColor = UIColor.clear
        indicator = MaterialLoadingIndicator(frame: CGRect(x:0, y:0, width: 50, height: 50))
        indicator.indicatorColor = [hexStringToUIColor(hex: "#942192").cgColor]
        indicator.center = controller.view.center
        Activityview?.addSubview(indicator)
        controller.view.addSubview(Activityview!)
        indicator.startAnimating()
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func RemoveActivityLoader() {
        Activityview?.removeFromSuperview()
    }
    
    
//     Local DB data Creation
    
    func CreateUserDB(userData : UserModelObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        if !self.CheckUserItemExist(userData: userData){
            let managedContext = appDelegate.persistentContainer.viewContext
            let Entity = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as! User
            Entity.firstname = userData.first_name
            Entity.lastname = userData.last_name
            Entity.avatar = userData.avatar
            Entity.email = userData.email
            Entity.id = userData.id ?? 0
            do {
                try managedContext.save()

            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    func CheckUserItemExist(userData : UserModelObject) -> Bool {
        
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        fetchRequest.fetchLimit =  1
        fetchRequest.predicate = NSPredicate(format: "email == %@",userData.email!)
        do {
            let count  = try managedContext.count(for: fetchRequest)
            if count > 0 {
                return true
            }else {
                return false
            }
        }catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    
    func retrieveUserData()  -> [UserModelObject] {
        var array = [UserModelObject]()
        let managedContext = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                let user = UserModelObject()
                user.first_name = (data.value(forKey: "firstname") as? String)!
                user.last_name = (data.value(forKey: "lastname") as? String)!
                user.email = (data.value(forKey: "email") as? String)!
                user.id = (data.value(forKey: "id") as? Int64)!
                user.avatar = (data.value(forKey: "avatar") as? String)!
                array.append(user)
            }
        } catch let error as NSError {
            array = []
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return array
    }
    
}

