import UIKit
import Bottomify

class ViewController: UIViewController {

    @IBOutlet weak var sourceTextField: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func translateToBottomButtonTapped(_ sender: Any) {
        resultLabel.text = sourceTextField.text?.bottomified()
    }
    
    @IBAction func translateFromBottomButtonTapped(_ sender: Any) {
        if let result = try? sourceTextField.text?.regressed() {
            resultLabel.text = result
        } else {
            let alert = UIAlertController(
                title: "Invalid string 🥺",
                message: "Please include a valid bottom sequence to decode.",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true)
        }
    }
    
    @IBAction func copyButtonTapped(_ sender: Any) {
        UIPasteboard.general.string = resultLabel.text
    }
    
}

