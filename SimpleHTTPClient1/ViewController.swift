//
//  ViewController.swift
//  SimpleHTTPClient1
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var addBtnOutlet: UIButton!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var lblStatus: UILabel!
    
    @IBAction func AddBtnAction(_ sender: Any) {
        
        if  (txtTitle.text?.count ?? 0) > 2 && (txtDate.text?.count ?? 0) > 7 {
        let myobj =  Claim(this_title: txtTitle.text ?? "no title", this_date: txtDate.text ?? "\(Date())")
        // Testing addPerson() method
        let pService = ClaimService()
        pService.addClaim(pObj:myobj, complition: {result in
            DispatchQueue.main.async {
                self.txtDate.text = ""
                self.txtTitle.text = ""
            self.lblStatus.text = result
                       
            }
                      })
        }else{
            self.lblStatus.text = "Please enter title and correct date."
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtDate.placeholder = "YYYY-MM-DD"
        self.txtDate.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        let pService = ClaimService()
//         Testing getAll() method
        pService.getAll(complition: {resultArray in
            print(resultArray)
            
        })
        let pList = pService.ClaimList
//        let myobj =  Claim(this_title: "First Title", this_date: "2020-10-24")
//        // Testing addPerson() method
//        pService.addClaim(pObj:myobj)
//        pService.addClaim(pObj: Claim(this_title: "Second Title", this_date: "2020-10-24"))
//        pService.addClaim(pObj: Claim(this_title: "Third Title", this_date: "2020-10-24"))
        
        print(pList)
    }


    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {


    if textField.text?.count == 1 {
                textField.placeholder = "YYYY-MM-DD"
    }

    if (textField.text?.count == 4) || (textField.text?.count == 7) {
                    //Handle backspace being pressed
                    if !(string == "") {
                        self.txtDate.text = textField.text! + "-"
                    }
                }
                return !(textField.text!.count > 9 && (string.count) > range.length)
    }
    
}

