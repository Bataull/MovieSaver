import UIKit

protocol TrailerLinkModel: AnyObject {
    
    func setNavigationController(_ navigationController: UINavigationController?)
    func saveButtonTap(withUrl url: URL)
    
    var delegate: LinkDelegate? { get set }
}

final class DefaultTrailerLinkModel: TrailerLinkModel {
    
    private var navigationController: UINavigationController?
    private var presentingViewController: UIViewController?
    
    weak var delegate: LinkDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        }
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    internal func saveButtonTap(withUrl url: URL) {
        if url.absoluteString != "" {
            delegate?.linkDelegate(url)
            navigationController?.popViewController(animated: true)
        } else {
            showAlert("Add your link")
        }
    }
    
    private func showAlert(_ message: String){
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        if let presentingViewController = presentingViewController {
                    presentingViewController.present(alert, animated: true, completion: nil)
        }
    }
}
