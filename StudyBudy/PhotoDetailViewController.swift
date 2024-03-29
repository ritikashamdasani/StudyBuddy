//
//  PhotoDetailViewController.swift
//  StudyBudy
//
//  Created by Apple on 6/26/19.
//  Copyright © 2019 Appl#imageLiteral(resourceName: "images.png")e. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let realPhoto = photo  {
            title = realPhoto.caption
            
            if let cellPhotoImageData = realPhoto.imageData {
                if let cellPhotoImage = UIImage(data: cellPhotoImageData) {
                    photoDetailView.image = cellPhotoImage
                }
            }
        }
    }
    
    @IBOutlet weak var photoDetailView: UIImageView!
    
    var photo : Photos? = nil

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
