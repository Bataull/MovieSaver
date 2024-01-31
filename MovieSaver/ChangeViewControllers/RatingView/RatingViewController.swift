import UIKit

final class RatingViewController: UIViewController {
    
    static let identifier = "RatingViewController"
    
    private let ratingLabel = UILabel()
    private let pickerView = UIPickerView()
    private let saveButton = UIButton()
    private var arrayOfRatings: [Double] = []
    private var selectedRating: String?
    
    var viewModel: RatingViewModel!
    
    weak var delegate: RatingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        addConstraints()
        addSetups()
        
        viewModel = DefaultRatingViewModel(presentingViewController: self)
        if let viewModel = viewModel as? DefaultRatingViewModel {
            viewModel.setNavigationController(self.navigationController)
        }
    }
    
    private func addSubview(){
        view.addSubview(ratingLabel)
        view.addSubview(pickerView)
        view.addSubview(saveButton)
    }
    
    private func addConstraints(){
        
        //ratingLabel
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        ratingLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        ratingLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        ratingLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        //pickerView
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 10).isActive = true
        pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        //saveButton
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 32).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 27).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 79).isActive = true

    }
    
    private func addSetups() {
        
        //ratingLabel
        ratingLabel.text = "Your Rating"
        ratingLabel.textColor = .black
        ratingLabel.textAlignment = .center
        ratingLabel.font = .manrope(24, .medium)
        
        //saveButton
        saveButton.setTitle("Save", for: .normal)
        saveButton.backgroundColor = .white
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.titleLabel?.font = .manrope(18, .medium)
        saveButton.addTarget(self, action: #selector(saveButtonTap), for: .touchUpInside)
        
        //pickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        arrayOfRatings = arrayLimits()
    }
    
    @objc private func saveButtonTap() {
        viewModel.saveButtonTap(selectedRating: selectedRating)
        delegate?.ratingDelegate(selectedRating ?? "")
    }
}

extension RatingViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        arrayOfRatings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: "%.1f", arrayOfRatings[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRating = String(format: "%.1f", arrayOfRatings[row])
    }
    
    func arrayLimits() -> [Double] {
        return Array(stride(from: 0.0, to: 10.1, by: 0.1)).reversed()
    }
}
