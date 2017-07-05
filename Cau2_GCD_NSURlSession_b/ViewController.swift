//
//  ViewController.swift
//  Cau2_GCD_NSURlSession_b
//
//  Created by Cntt03 on 7/5/17.
//  Copyright © 2017 Cntt03. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var txt2: UITextField!
    @IBOutlet weak var txt1: UITextField!
    @IBOutlet weak var img2: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnClick(_ sender: Any) {
        if ((txt1.text?.isEmpty)! || (txt2.text?.isEmpty)!){
            showAlert(message: "Hãy điền đầy đủ đường dẫn ảnh")
        }
        else {
            let thread1 = DispatchQueue(label: "thread1")
            let thread2 = DispatchQueue(label: "thread2")
            
            //load data into imageview 1
            thread1.async {
                let imageUrl: URL = URL(string: self.txt1.text!)!
                (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageUrl, completionHandler: {(imageData, response, error) in
                    if let data = imageData {
                        DispatchQueue.main.async {
                            self.img1.image = UIImage(data: data)
                        }
                    }
                    if error != nil {
                        self.showAlert(message: "Không thể hiển thị ảnh với đường dẫn 1")
                    }
                    
                    
                }).resume()
            }
            
            //load data into imageview 1
            thread2.async {
                let imageUrl: URL = URL(string: self.txt2.text!)!
                (URLSession(configuration: URLSessionConfiguration.default)).dataTask(with: imageUrl, completionHandler: {(imageData, response, error) in
                    if let data = imageData {
                        DispatchQueue.main.async {
                            self.img2.image = UIImage(data: data)
                        }
                    }
                    if error != nil {
                        self.showAlert(message: "Không thể hiển thị ảnh với đường dẫn 2")
                    }
                    
                }).resume()
            }
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Thông Báo", message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

