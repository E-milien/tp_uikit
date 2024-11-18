//
//  DocumentViewController.swift
//  Document App
//
//  Created by Émilien on 11/18/2024.
//

import UIKit

class DocumentViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var imageName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if imageName != nil {
            imageView.image = UIImage(named: imageName!)
        }
        
    }
}
