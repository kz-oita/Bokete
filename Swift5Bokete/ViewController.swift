//
//  ViewController.swift
//  Swift5Bokete
//
//  Created by 及田　一樹 on 2020/05/18.
//  Copyright © 2020 oita kazuki. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos


class ViewController: UIViewController {
    
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var odaiImageView: UIImageView!
    @IBOutlet weak var commentTextView: UITextView!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTextView.layer.cornerRadius = 20.0
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status) {
                case .authorized: break
                case .denied: break
                case .notDetermined: break
                case .restricted: break
            }
        }
        
        getImages(keyWord: "funny")
    }
    
    //検索キーワードの値を元に画像を引っ張ってくる
    //pixabay.com 16597432-41516eaf3305cb2db56078e3d
    func getImages (keyWord:String){
        
        //APIkey
        let url = "https://pixabay.com/api/?key=16597432-41516eaf3305cb2db56078e3d&q=\(keyWord)"
        
        //Alamofireをつかってhttpリクエストを投げる
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result {
                
            case .success:
                
                let json:JSON = JSON(response.data as Any)
                var imageString = json["hits"][self.count]["webformatURL"].string
                
                if imageString == nil{
                    
                    imageString = json["hits"][0]["webformatURL"].string
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                
                }else{
                    
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                
                }
                
                
                
            case .failure(let errror):
                print(errror)
                
                
            }
            
        }
        
        
    }
    
    
    @IBAction func nextOdai(_ sender: Any) {
        
        count = count + 1
        
        if searchTextField.text == ""{
            
            getImages(keyWord: "funny")
            
        }else{
            
            getImages(keyWord: searchTextField.text!)
            
        }
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
        self.count = 0
        
        if searchTextField.text == ""{
            
            getImages(keyWord: "funny")
            
        }else{
            
            getImages(keyWord: searchTextField.text!)
            
        }
    }
    
    @IBAction func next(_ sender: Any) {
        
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let shareVC = segue.destination as? ShareViewController
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
        
    }
    
}

 
