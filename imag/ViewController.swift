//
//  ViewController.swift
//  imag
//
//  Created by Ritesh Harihar on 15/02/22.
//

import UIKit
import SwiftSoup

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    let urlKey="https://m.media-amazon.com/images/I/21wb0b2lXsS._AC_SY350_QL15_.jpg"
func getProductImage(url: URL)-> String {
    var result = ""
    do {
        let html = try String(contentsOf: url, encoding: .utf8)
       // print(html)
        let doc: Document = try SwiftSoup.parseBodyFragment(html)
      //  let title: String = try
       // let headerTitle = try doc.title()
        //print("Header title: \(headerTitle)"
        let img: Element = try doc.select(".image-size-wrapper.fp-image-wrapper.image-block-display-flex img").first()!
       let src  = try img.attr("src")

        if src.contains("data:image/gif;base64"){
            
            let dataMidresReplacement  = try img.attr("data-midres-replacement")
            print("dataMidresReplacement: \(dataMidresReplacement)")
            result = dataMidresReplacement
            
        } else {
            result = src
        }
    }
    catch {
        print(error)
    }
    
    return result
}
    func getProductTitle(url: URL)-> String {
        var headerTitle=""
        do {
            let html = try String(contentsOf: url, encoding: .utf8)
        
            let doc: Document = try SwiftSoup.parseBodyFragment(html)
             headerTitle = try doc.title()
        }
        catch {
            print(error)
        }
        
        return headerTitle
        
        
    }

override func viewDidLoad() {
    super.viewDidLoad()
    
   guard let url = URL(string: "https://www.amazon.in/AmazonBasics-1-5-Ton-Air-Conditioner/dp/B08J8SM4GD/ref=lp_27346089031_1_1") else {
        fatalError("Can not get url")
    }
    let imgUrl = getProductImage(url: url)
    let imgtitle = getProductTitle(url: url)
   // let title = gettitle(url: url)
    //print(title)
    print(imgUrl)
    print(imgtitle)
    
    
    label.text = imgtitle
    
    // Create URL
       let url1 = URL(string: imgUrl)!

    // Fetch Image Data
        if let data = try? Data(contentsOf: url1) {
            // Create Image and Update Image View
            imageView.image = UIImage(data: data)
        }
   
   
}
    @IBAction func click(_sender:Any)
    {
        if let url = URL(string: urlKey){
            do{
                let data = try Data(contentsOf: url)
                self.imageView.image = UIImage(data: data)
            }
            catch let err{
                print("Error:\(err.localizedDescription)")
            }
        }
    }
}




