import UIKit

protocol RatingViewModel: AnyObject {
    
    func setNavigationController(_ navigationController: UINavigationController?)
    func saveButtonTap(selectedRating: String?)
    var delegate: RatingDelegate? { get set }
}

final class DefaultRatingViewModel: RatingViewModel {
    
    private var navigationController: UINavigationController?
    private var presentingViewController: UIViewController?
    
    weak var delegate: RatingDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        }
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    internal func saveButtonTap(selectedRating: String?) {
        if selectedRating != nil {
            delegate?.ratingDelegate(selectedRating ?? "")
            navigationController?.popViewController(animated: true)
        } else {
            showAlert("Enter your rating")
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
