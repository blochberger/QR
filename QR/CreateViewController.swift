import UIKit

import QRCode

class CreateViewController: UIViewController, UITextFieldDelegate {

	@IBOutlet weak var inputTextField: UITextField!
	@IBOutlet weak var imageView: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	@IBAction func generateQrCode() {
		guard let input = inputTextField.text else {
			return
		}

		guard let qrCode = QRCode(input) else {
			return
		}

		imageView.image = qrCode.image
	}
}

