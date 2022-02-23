//
//  ViewController.swift
//  ScrollStackViews
//
//  Created by Felipe Montoya on 2/22/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    private var scrollView: UIScrollView!
    private var imageView: UIImageView!
    
    
    private func updateUI(){
        scrollView = UIScrollView()
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0),
            //scrollView.heightAnchor.constraint(equalToConstant: view.frame.height/2)
        ])
        
        //agregar contenido a scrollview
        imageView = UIImageView(frame: CGRect(origin: view.frame.origin, size: CGSize(width: view.frame.width * 2, height: view.frame.height * 2)))
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.frame.size
        
    }
    
    @objc func didRefresh() {
        print("refresh data")
        scrollView.refreshControl?.endRefreshing()
    }
    
    private var imageService: ImageService!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateUI()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action: #selector(didRefresh), for: .primaryActionTriggered)
        imageService = ImageService(delegate: self)
        imageService.downloadImage()
        scrollView.delegate = self
        scrollView.maximumZoomScale = 4.0
        scrollView.minimumZoomScale = 0.25
        
        // Do any additional setup after loading the view.
    }


}


extension ViewController: ImageServiceDelegate {
    func didFinishedWith(_ result: Result<Data, Error>) {
        //Grand Central Dispatch
        DispatchQueue.main.async {
            switch result {
            case .failure(_): //handle error
                break
            case .success(let data):
                self.imageView.image = UIImage(data: data)
            }
        }
    }
    
    func serviceNeedsURL() -> URL {
        return URL(
                  string: "https://upload.wikimedia.org/wikipedia/en/2/27/Face_of_Praying_Mantis.jpg")!
    }
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        //
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        imageView
    }
}
