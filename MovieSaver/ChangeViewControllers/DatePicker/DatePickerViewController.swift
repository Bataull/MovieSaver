import UIKit

final class DatePickerViewController: UIViewController {
    
    //MARK: - Properties
    
    static let identifier = "DatePickerViewController"
    
    private let releaseDateLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let saveButton = UIButton()
    
    var viewModel: DatePickerModel!
    
    weak var delegate: DateDelegate?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        addConstraints()
        addSetups()
        
        viewModel = DefaultDatePickerModel()
        if let viewModel = viewModel as? DefaultDatePickerModel {
            viewModel.setNavigationController(self.navigationController)
        }
    }
    
    //MARK: - AddSubviews
    
    private func addSubview(){
        view.addSubview(releaseDateLabel)
        view.addSubview(datePicker)
        view.addSubview(saveButton)
    }
    
    //MARK: - Constraints
    
    private func addConstraints(){
        
        //releaseDateLabel
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        releaseDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        releaseDateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        releaseDateLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //datePicker
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 32).isActive = true
        datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 194).isActive = true
        
        //saveButton
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 32).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 79).isActive = true
    }
    
    //MARK: - Setups
    
    private func addSetups(){
        
        //releaseDateLabel
        releaseDateLabel.text = "Release Date"
        releaseDateLabel.textColor = UIColor(named: "black_white")
        releaseDateLabel.textAlignment  = .center
        releaseDateLabel.font = .manrope(24, .medium)
        
        //datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        //saveButton
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = UIColor(named: "white_black")
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.titleLabel?.font = .manrope(18, .medium)
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
    }
    
    //MARK: - Actions
    
    @objc private func saveButtonTap() {
        viewModel.saveButtonTap()
        delegate?.dateDelegate(datePicker.date)
    }
}
