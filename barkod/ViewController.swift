//
//  ViewController.swift
//  barkod
//
//  Created by halil ibrahim Elkan on 22.12.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sonuc: UILabel!
    
    
    var mesaj:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sonuc.text = mesaj
        print(mesaj)
    }

    @IBAction func geri(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

