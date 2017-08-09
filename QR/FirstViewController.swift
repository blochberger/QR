import UIKit

import QRCodeReader

class FirstViewController: UIViewController {

	@IBOutlet weak var outputLabel: UILabel!
	@IBOutlet weak var copyToClipboardButton: UIButton!
	@IBOutlet weak var openUrlButton: UIButton!

	private var reader: QRCodeReader? = nil

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	private func reset() {
		outputLabel.text = ""
		outputLabel.textColor = UILabel().textColor
		copyToClipboardButton.isEnabled = false
		openUrlButton.isEnabled = false
	}

	@IBAction func scanQrCode() {
		reset()

		reader = QRCodeReader()
		do {
			try	reader!.startScanning() {
				decodedQrCode in

				DispatchQueue.main.async {
					self.outputLabel.text = decodedQrCode

					self.copyToClipboardButton.isEnabled = true
					self.openUrlButton.isEnabled = decodedQrCode != nil && URL(string: decodedQrCode!) != nil
				}

				self.reader = nil
			}
		} catch {
			outputLabel.text = error.localizedDescription
			outputLabel.textColor = UIColor(red: 1.0, green: 59.0 / 255.0, blue: 48.0 / 255.0, alpha: 1.0)
			self.reader = nil
		}
	}

	@IBAction func copyToClipboard() {
		guard let value = outputLabel.text else {
			return
		}
		UIPasteboard.general.string = value
	}

	@IBAction func openUrl() {
		guard let value = outputLabel.text else {
			return
		}

		guard let url = URL(string: value) else {
			return
		}

		UIApplication.shared.open(url)
	}
}

