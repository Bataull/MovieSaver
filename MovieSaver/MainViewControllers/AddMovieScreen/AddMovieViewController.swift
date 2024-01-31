import CoreData
import UIKit

class AddMovieViewController: UIViewController, NameDelegate, RatingDelegate, DateDelegate, LinkDelegate {
    
    static let identifier = "AddMovieViewController"
    
    var viewModel: AddMovieModel!
    
    var receivedName: String?
    
    private var movieInfo: Movie = .init()
    private var pickedImage: UIImage?
    private let movieImageView = UIImageView()
    private let scrollView = UIScrollView()
    private let mainView = UIView()
    private let infoView = UIView()
    private let infoMovieStackView = UIStackView()
    private let firstStackView = UIStackView()
    private let nameLabel = UILabel()
    private let ratingLabel = UILabel()
    private let secondStackView = UIStackView()
    private let mainNameLabel = UILabel()
    private let mainRatingLabel = UILabel()
    private let thirdStackView = UIStackView()
    private let changeNameButton = UIButton()
    private let changeRatingButton = UIButton()
    private let separatorStackView = UIStackView()
    private let separatorView = UIView()
    private let fourthStackView = UIStackView()
    private let dateLabel = UILabel()
    private let linkLabel = UILabel()
    private let fifthStackView = UIStackView()
    private let mainDateLabel = UILabel()
    private let mainLinkLabel = UILabel()
    private let sixStackView = UIStackView()
    private let changeDateButton = UIButton()
    private let changeLinkButton = UIButton()
    private let descLabel = UILabel()
    private let descTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        addSetups()
        navControllerSetup()
        
        viewModel = DefaultAddMovieModel(presentingViewController: self)
        if let viewModel = viewModel as? DefaultAddMovieModel {
            viewModel.setNavigationController(self.navigationController)
            viewModel.setNameDelegate(self)
            viewModel.setRatingDelegate(self)
            viewModel.setDateDelegate(self)
            viewModel.setLinkDelegate(self)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        movieImageView.layer.cornerRadius = movieImageView.frame.size.width / 2
        movieImageView.clipsToBounds = true
    }
    
    private func saveMovie(_ name: String, _ rating: String, _ releaseDate: String, _ description: String, _ trailerLink: String, _ image: UIImage) {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            movieInfo = Movie(context: appDelegate.persistentContainer.viewContext)
            movieInfo.name = name
            movieInfo.rating = rating
            movieInfo.releaseDate = releaseDate
            movieInfo.desc = description
            movieInfo.trailerLink = URL(string: trailerLink)!
            movieInfo.image = image.pngData()
            appDelegate.saveContext()
            checkDataSaved()
        }
    }
    
    private func addSubviews(){
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        
        mainView.addSubview(movieImageView)
        mainView.addSubview(infoView)
        mainView.addSubview(descLabel)
        mainView.addSubview(descTextView)
        
        infoView.addSubview(infoMovieStackView)
        infoMovieStackView.addArrangedSubview(firstStackView)
        firstStackView.addArrangedSubview(nameLabel)
        firstStackView.addArrangedSubview(ratingLabel)
        
        infoMovieStackView.addArrangedSubview(secondStackView)
        secondStackView.addArrangedSubview(mainNameLabel)
        secondStackView.addArrangedSubview(mainRatingLabel)

        infoMovieStackView.addArrangedSubview(thirdStackView)
        thirdStackView.addArrangedSubview(changeNameButton)
        thirdStackView.addArrangedSubview(changeRatingButton)

        infoMovieStackView.addArrangedSubview(separatorStackView)
        infoMovieStackView.addArrangedSubview(separatorView)

        infoMovieStackView.addArrangedSubview(fourthStackView)
        fourthStackView.addArrangedSubview(dateLabel)
        fourthStackView.addArrangedSubview(linkLabel)

        infoMovieStackView.addArrangedSubview(fifthStackView)
        fifthStackView.addArrangedSubview(mainDateLabel)
        fifthStackView.addArrangedSubview(mainLinkLabel)

        infoMovieStackView.addArrangedSubview(sixStackView)
        sixStackView.addArrangedSubview(changeDateButton)
        sixStackView.addArrangedSubview(changeLinkButton)
    }
    
    private func addConstraints(){
        scrollView.frame = view.bounds
        
        //mainView
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1).isActive = true
        mainView.heightAnchor.constraint(equalToConstant: 730).isActive = true
        
        //movieImageView
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.topAnchor.constraint(equalTo: mainView.safeAreaLayoutGuide.topAnchor, constant: 35).isActive = true
        movieImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        movieImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        movieImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //infoView
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        infoView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 32).isActive = true
        infoView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32).isActive = true
        infoView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32).isActive = true
        
        //infoMovieStackView
        infoMovieStackView.translatesAutoresizingMaskIntoConstraints = false
        infoMovieStackView.topAnchor.constraint(equalTo: infoView.topAnchor).isActive = true
        infoMovieStackView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor).isActive = true
        infoMovieStackView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor).isActive = true
        infoMovieStackView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor).isActive = true
        
        //descLabel
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.topAnchor.constraint(equalTo: infoView.bottomAnchor, constant: 36).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //descTextView
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        descTextView.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 11).isActive = true
        descTextView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 32).isActive = true
        descTextView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -32).isActive = true
        descTextView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -20).isActive = true
    }
    
    private func addSetups(){
        //movieImageView
        movieImageView.image = UIImage(named: "ImageSample")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(movieImageTapped))
        movieImageView.isUserInteractionEnabled = true
        movieImageView.addGestureRecognizer(tapGesture)
        movieImageView.contentMode = .scaleAspectFill
        
        //infoView
        infoView.backgroundColor = .white
        infoView.layer.cornerRadius = 10
        
        //infoMovieStackView
        infoMovieStackView.axis = .vertical
        infoMovieStackView.distribution = .fillEqually
        infoMovieStackView.alignment = .fill
        
        //firstStackView
        firstStackView.axis = .horizontal
        firstStackView.alignment = .fill
        firstStackView.distribution = .fillEqually
        
        //secondStackView
        secondStackView.axis = .horizontal
        secondStackView.distribution = .fillEqually
        secondStackView.alignment = .fill
        
        //thirdStackView
        thirdStackView.axis = .horizontal
        thirdStackView.distribution = .fillEqually
        thirdStackView.alignment = .fill
        
        //fourthStackView
        fourthStackView.axis = .horizontal
        fourthStackView.distribution = .fillEqually
        fourthStackView.alignment = .fill
        
        //separatorStackView
        separatorStackView.axis = .horizontal
        separatorStackView.distribution = .fillEqually
        separatorStackView.alignment = .fill
        
        //fifthStackView
        fifthStackView.axis = .horizontal
        fifthStackView.distribution = .fillEqually
        fifthStackView.alignment = .fill
        
        //sixStackView
        sixStackView.axis = .horizontal
        sixStackView.distribution = .fillEqually
        sixStackView.alignment = .fill
        
        //nameLabel
        nameLabel.text = "Name"
        nameLabel.textColor = .black
        nameLabel.font = .manrope(18, .medium)
        nameLabel.textAlignment = .center
        
        //ratingLabel
        ratingLabel.text = "Your Rating"
        ratingLabel.textColor = .black
        ratingLabel.font = .manrope(18, .medium)
        ratingLabel.textAlignment = .center
        
        //mainNameLabel
        mainNameLabel.text = "-"
        mainNameLabel.textColor = .black
        mainNameLabel.font = .manrope(18, .medium)
        mainNameLabel.textAlignment = .center
        
        //mainRaitingLabel
        mainRatingLabel.text = "-"
        mainRatingLabel.textColor = .black
        mainRatingLabel.font = .manrope(18, .medium)
        mainRatingLabel.textAlignment = .center
        
        //changeNameBtton
        changeNameButton.setTitle("Change", for: .normal)
        changeNameButton.backgroundColor = .white
        changeNameButton.setTitleColor(.systemBlue, for: .normal)
        changeNameButton.titleLabel?.font = .manrope(18, .medium)
        changeNameButton.addTarget(self, action: #selector(nameButtonTapped), for: .touchUpInside)
        
        //changeRatingButton
        changeRatingButton.setTitle("Change", for: .normal)
        changeRatingButton.backgroundColor = .white
        changeRatingButton.setTitleColor(.systemBlue, for: .normal)
        changeRatingButton.titleLabel?.font = .manrope(18, .medium)
        changeRatingButton.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
        
        //dateLabel
        dateLabel.text = "Release Date"
        dateLabel.textColor = .black
        dateLabel.font = .manrope(18, .medium)
        dateLabel.textAlignment = .center
        
        //linkLabel
        linkLabel.text = "YouTube Link"
        linkLabel.textColor = .black
        linkLabel.font = .manrope(18, .medium)
        linkLabel.textAlignment = .center
        
        //mainDateLabel
        mainDateLabel.text = "-"
        mainDateLabel.textColor = .black
        mainDateLabel.font = .manrope(18, .medium)
        mainDateLabel.textAlignment = .center
        
        //mainLinkLabel
        mainLinkLabel.text = "-"
        mainLinkLabel.textColor = .black
        mainLinkLabel.font = .manrope(18, .medium)
        mainLinkLabel.textAlignment = .center
        
        //changeDateButton
        changeDateButton.setTitle("Change", for: .normal)
        changeDateButton.backgroundColor = .white
        changeDateButton.setTitleColor(.systemBlue, for: .normal)
        changeDateButton.titleLabel?.font = .manrope(18, .medium)
        changeDateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        
        //changeLinkButton
        changeLinkButton.setTitle("Change", for: .normal)
        changeLinkButton.backgroundColor = .white
        changeLinkButton.setTitleColor(.systemBlue, for: .normal)
        changeLinkButton.titleLabel?.font = .manrope(18, .medium)
        changeLinkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        
        //descLabel
        descLabel.text = "Description"
        descLabel.textColor = .black
        descLabel.textAlignment = .center
        descLabel.font = .manrope(18, .medium)
        
        //descTextField
        descTextView.textColor = .lightGray
        descTextView.text = "Enter your description..."
        descTextView.font = .manrope(14, .regular)

    }
    
    private func navControllerSetup(){
        title = "Add new"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
    }
    
    func nameDelegate(_ name: String) {
        receivedName = name
        mainNameLabel.text = receivedName
    }
    
    func ratingDelegate(_ rating: String) {
        mainRatingLabel.text = rating
    }
    
    func dateDelegate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        mainDateLabel.text = dateFormatter.string(from: date)
    }
    
    func linkDelegate(_ url: URL) {
        mainLinkLabel.text = url.absoluteString
    }
    
    func updateMovieImage(_ image: UIImage?) {
        movieImageView.image = image
        pickedImage = image
    }
    
//MARK: - Action Buttons
    
    @objc private func movieImageTapped() {
        viewModel.movieImageTapped()
    }
    
    @objc private func nameButtonTapped() {
        viewModel.nameButtonTapped()
    }
    
    @objc private func ratingButtonTapped() {
        viewModel.ratingButtonTapped()
    }
    
    @objc private func dateButtonTapped() {
        viewModel.dateButtonTapped()
    }
    
    @objc private func linkButtonTapped() {
        viewModel.linkButtonTapped()
    }
    
    @objc private func saveButtonTapped() {
        saveButtonClick()
    }
    
    @objc private func saveButtonClick() {
        if isCheckFieldsForEmpty() {
            saveMovie(mainNameLabel.text!,
                      mainRatingLabel.text!,
                      mainDateLabel.text!,
                      descTextView.text!,
                      mainLinkLabel.text!,
                      pickedImage ?? UIImage())
            navigationController?.popViewController(animated: true)
        } else {
            showAllert("Fill all fields")
        }
    }
    
    private func showAllert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func isCheckFieldsForEmpty() -> Bool {
        if mainNameLabel.text != "-",
           mainDateLabel.text != "-",
           mainRatingLabel.text != "-",
           mainLinkLabel.text != "-",
           pickedImage != nil,
           descTextView.text != ""
        {
            return true
        } else {
            return false
        }
    }
    
    private func checkDataSaved() {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
            
            do {
                let movies = try context.fetch(fetchRequest)
                if !movies.isEmpty {
                    print("Data Saved")
                } else {
                    print("Data Error")
                }
            } catch {
                print("Catch Error: \(error.localizedDescription)")
            }
        }
    }
}
