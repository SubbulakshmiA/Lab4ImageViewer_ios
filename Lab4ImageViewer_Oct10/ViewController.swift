//
//  ViewController.swift
//  Lab4ImageViewer_Oct10
//
//  Created by user243757 on 10/10/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var myModelObj = MyModel()
    
    @IBOutlet var myGesture: UISwipeGestureRecognizer!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    @IBOutlet weak var myPickerView: UIPickerView!
    
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var myStackView: UIStackView!
    var rowSelected = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myModelObj.listOfImages.keys.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let keyArray = Array(myModelObj.listOfImages).sorted(by: <)
       
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.backgroundColor = UIColor.lightGray
        label.text = keyArray[row].key
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        swipeImage(row: row)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myImageView.frame = UIScreen.main.bounds
        swipeImage(row: 0)
        self.view.addSubview(myStackView)
        myImageView.contentMode = .scaleAspectFill
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)


        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        // Do any additional setup after loading the view.
    }

    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                rowSelected -= 1
                if rowSelected < 0 {
                    rowSelected = myModelObj.listOfImages.count - 1
                }
                myPickerView.selectRow(rowSelected, inComponent: 0, animated: true)
                swipeImage(row: (rowSelected))
                print("Swiped right")
                
            case .left:
                rowSelected += 1
                if rowSelected >= myModelObj.listOfImages.count {
                           rowSelected = 0
                       }
                myPickerView.selectRow(rowSelected, inComponent: 0, animated: true)
                swipeImage(row: rowSelected)
                print("Swiped left")

            default:
                break
                
            }
            
        }
        
    }
    
    func swipeImage(row:Int){
        print("swiped")
        let valueArray = Array( myModelObj.listOfImages).sorted(by: <)
        let myUrlStr = valueArray[row].value
        myActivityIndicator.startAnimating()
        
        Service.shared.getData(urlStr: myUrlStr) { data in
            
            if let data = data{
                DispatchQueue.main.async {
                    self.myImageView.image = UIImage(data: data)
                    self.myActivityIndicator.stopAnimating()
                    self.myActivityIndicator.hidesWhenStopped = true
                    
                }
            }
        }
     
        
    }
    
    
    
    
    
    
}



