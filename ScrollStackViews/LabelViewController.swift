//
//  LabelViewController.swift
//  ScrollStackViews
//
//  Created by Felipe Montoya on 2/22/22.
//

import UIKit

class LabelViewController: UIViewController {

    var text: String = "ViewController" {
        didSet {
            guard let label = self.view.subviews.first as? UILabel else {
                return
            }
            label.text = text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        self.view.addSubview(label)
        self.view.backgroundColor = .white
       
        // Do any additional setup after loading the view.
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            ])
    }


}
