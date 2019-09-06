//
//  ImageViewController.swift
//  GCD
//
//  Created by Саша Руцман on 06/09/2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    fileprivate var imageURL: URL?
    fileprivate var image: UIImage? {
        
        get {
            return imageView.image
        }
        
        set {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            imageView.image = newValue
            imageView.sizeToFit()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchImage()
        delay(3) {
            self.alertPresent()
        }
        
        
    }
    
    fileprivate func delay(_ delay: Int, closure: @escaping () -> () ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            closure()
        }
    }
    
    fileprivate func alertPresent() {
        let ac = UIAlertController(title: "Опрос", message: "Вам нравится эта картинка?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Да", style: .default, handler: nil)
        let noAction = UIAlertAction(title: "Нет", style: .default, handler: nil)
        
        ac.addAction(yesAction)
        ac.addAction(noAction)
        
        self.present(ac, animated: true, completion: nil)
    }
    
    fileprivate func fetchImage() {
        imageURL = URL(string: "https://mirpozitiva.ru/uploads/posts/2016-08/medium/1472042903_31.jpg")
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = self.imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: imageData)
            }
            
        }
        
    }

}
