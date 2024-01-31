import UIKit

protocol FilmNameModel: AnyObject {
    
    func setNavigationController(_ navigationController: UINavigationController?)
    func saveButtonTap(withName name: String)
    var delegate: NameDelegate? { get set }
}

final class DefaultFilmNameModel: FilmNameModel {
    
    private var navigationController: UINavigationController?
    private var presentingViewController: UIViewController?
    
    weak var delegate: NameDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        }
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    internal func saveButtonTap(withName name: String) {
        if name != "" {
            delegate?.nameDelegate(name)
            navigationController?.popViewController(animated: true)
        } else {
            showAlert("Enter the name")
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
