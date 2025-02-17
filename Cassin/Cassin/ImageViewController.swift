//
//  ImageViewController.swift
//  Cassin
//
//  Created by 曹肖鹏 on 2024/12/26.
//

import UIKit

class ImageViewController: UIViewController {
    
    var imageURL: URL? {
        didSet {
            imageView.image = nil
            fetchImage()
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    private func fetchImage() {
        
    }
    
}
