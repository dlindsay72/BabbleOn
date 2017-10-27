//
//  CreatePostVC.swift
//  BabbleOn
//
//  Created by Dan Lindsay on 2017-10-27.
//  Copyright © 2017 Dan Lindsay. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
    }

    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if textView.text != nil && textView.text != "Say something here..." {
            sendBtn.isEnabled = false
            if let uid = Auth.auth().currentUser?.uid {
                DataService.instance.uploadPost(withMessage: textView.text, forUID: uid, withGroupKey: nil, sendComplete: { (isComplete) in
                    if isComplete {
                        self.sendBtn.isEnabled = true
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        self.sendBtn.isEnabled = true
                        print("There was an error")
                    }
                })
            } else {
                print("unable to get current user uid")
            }
            
        }
    }
    
}

//MARK: - UITextViewDelegate

extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}




