import UIKit

final class FilmNameViewController: UIViewController{
    
    //MARK: - Properties
    
    static let identifier = "FilmNameViewController"
    
    private let nameLabel = UILabel()
    private let nameTextField = UITextField()
    private let saveButton = UIButton()
    
    var viewModel: FilmNameModel!
    
    weak var delegate: NameDelegate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DefaultFilmNameModel(presentingViewController: self)
        if let viewModel = viewModel as? DefaultFilmNameModel {
            viewModel.setNavigationController(self.navigationController)
        }
        
        addSubview()
        addConstraints()
        addSetups()
    }
    
    //MARK: - AddSubviews
    
    private func addSubview(){
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(saveButton)
    }
    
    //MARK: - Constraints
    
    private func addConstraints() {
        
        //nameLabel
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        //nameTextField
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 42).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        nameTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //saveButton
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 32).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 79).isActive = true
        
    }
    
    //MARK: - Setups
    
    private func addSetups() {
        
        //nameLabel
        nameLabel.text = "Fill Name"
        nameLabel.textColor = UIColor(named: "black_white")
        nameLabel.textAlignment = .center
        nameLabel.font = .manrope(24, .medium)
        
        //nameTextField
        nameTextField.placeholder = "Name"
        
        //saveButton
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor(named: "white_black")
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.titleLabel?.font = .manrope(18, .medium)
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
    }
    
    //MARK: - Action
    
    @objc private func saveButtonTap() {
        let name = nameTextField.text ?? ""
        viewModel.saveButtonTap(withName: name)
        delegate?.nameDelegate(name)
    }
}
