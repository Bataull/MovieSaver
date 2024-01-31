import UIKit

final class TrailerLinkViewController: UIViewController {
    
    //MARK: - Properties
    
    static let identifier = "TrailerLinkViewController"
    
    private let linkLabel = UILabel()
    private let linkTextField = UITextField()
    private let saveButton = UIButton()
    
    var viewModel: TrailerLinkModel!
    
    weak var delegate: LinkDelegate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        addSetups()
        
        viewModel = DefaultTrailerLinkModel(presentingViewController: self)
        if let viewModel = viewModel as? DefaultTrailerLinkModel {
            viewModel.setNavigationController(self.navigationController)
        }
    }
    
    //MARK: - AddSubviews
    
    private func addSubviews(){
        view.addSubview(linkLabel)
        view.addSubview(linkTextField)
        view.addSubview(saveButton)
    }
    
    //MARK: - Constraints
    
    private func addConstraints(){
        
        //linkLabel
        linkLabel.translatesAutoresizingMaskIntoConstraints = false
        linkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        linkLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        linkLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        linkLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //linkTextField
        linkTextField.translatesAutoresizingMaskIntoConstraints = false
        linkTextField.topAnchor.constraint(equalTo: linkLabel.bottomAnchor, constant: 42).isActive = true
        linkTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        linkTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        linkTextField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        //saveButton
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: linkTextField.bottomAnchor, constant: 32).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 79).isActive = true
        
    }
    
    //MARK: - Setups
    
    private func addSetups(){
        
        //linkLabel
        linkLabel.text = "YouTube Link"
        linkLabel.textColor = UIColor(named: "black_white")
        linkLabel.textAlignment = .center
        linkLabel.font = .manrope(24, .medium)
        
        //linkTextField
        linkTextField.placeholder = "URL"
        linkTextField.keyboardType = .URL
        linkTextField.delegate = self
        
        //saveButton
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor(named: "white_black")
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.titleLabel?.font = .manrope(18, .medium)
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    @objc private func saveButtonTap(){
        if let urlString = linkTextField.text, let url = URL(string: urlString){
            viewModel.saveButtonTap(withUrl: url)
            delegate?.linkDelegate(url)
        }
    }
}

    //MARK: - Extensions
extension TrailerLinkViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
}
