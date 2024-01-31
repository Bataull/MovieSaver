import UIKit

protocol DatePickerModel: AnyObject {
    func setNavigationController(_ navigationController: UINavigationController?)
    func saveButtonTap()
    var delegate: DateDelegate? { get set }
}

final class DefaultDatePickerModel: DatePickerModel {
    
    private var navigationController: UINavigationController?
    
    weak var delegate: DateDelegate?
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    internal func saveButtonTap() {
        delegate?.dateDelegate(Date())
        navigationController?.popViewController(animated: true)
    
    }
}

