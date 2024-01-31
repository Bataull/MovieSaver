import UIKit

protocol ViewModel: AnyObject {
    func setNavigationController(_ navigationController: UINavigationController?)
    func addNewButtonClick()
}

final class DefaultViewModel: ViewModel {
    
    private var navigationController: UINavigationController?
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func addNewButtonClick() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addNewVC = storyboard.instantiateViewController(withIdentifier: AddMovieViewController.identifier) as? AddMovieViewController {
            navigationController?.pushViewController(addNewVC, animated: true)
        }
    }
}
