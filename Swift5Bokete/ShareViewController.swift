//
//  ShareViewController.swift
//  Swift5Bokete
//
//  Created by 及田　一樹 on 2020/05/18.
//  Copyright © 2020 oita kazuki. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    var resultImage = UIImage()
    var commentString = String()
    var screenShotImage = UIImage()
    
    
    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultImageView.image = resultImage
        commentLabel.text = commentString
        commentLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    @IBAction func share(_ sender: Any) {
        
        //スクリーンショットを撮る
        takeScreenShoto()
        
        let items = [screenShotImage] as [Any]
        
        //アクティビティビューに乗っけてシェアする
        let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
    }
    
    func takeScreenShoto(){
        
        let width = CGFloat(UIScreen.main.bounds.size.width)
        let height = CGFloat(UIScreen.main.bounds.size.height/1.3)
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        //viewに書き出す
        self.view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        screenShotImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
