import UIKit
import WebKit

final class DetailScreenViewController: UIViewController {
    
    static let identifier = "DetailScreenViewController"
    
    var movieInfo: Movie = .init()
    
    private let scrollView = UIScrollView()
    private let viewHelperInScroll = UIView()
    private let movieImage = UIImageView()
    private let mainView = UIView()
    private let nameMovieLabel = UILabel()
    private let ratingAndYearLabel = UILabel()
    private let descTextView = UITextView()
    private let linkWebView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        addConstraints()
        addSetup()
    }
    
    private func addSubview(){
        view.addSubview(movieImage)
        view.addSubview(mainView)
        mainView.addSubview(scrollView)
        scrollView.addSubview(viewHelperInScroll)
        viewHelperInScroll.addSubview(nameMovieLabel)
        viewHelperInScroll.addSubview(ratingAndYearLabel)
        viewHelperInScroll.addSubview(descTextView)
        viewHelperInScroll.addSubview(linkWebView)
    }
    
    private func addConstraints(){
        
        //movieImage
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        movieImage.heightAnchor.constraint(equalToConstant: 286).isActive = true
        
        //mainView
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: movieImage.bottomAnchor,constant: -90).isActive = true
        mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        
        //viewHelper
        viewHelperInScroll.translatesAutoresizingMaskIntoConstraints = false
        viewHelperInScroll.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        viewHelperInScroll.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        viewHelperInScroll.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        viewHelperInScroll.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        viewHelperInScroll.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        viewHelperInScroll.heightAnchor.constraint(equalToConstant: 630).isActive = true
        
        //nameMovieLabel
        nameMovieLabel.translatesAutoresizingMaskIntoConstraints = false
        nameMovieLabel.topAnchor.constraint(equalTo: viewHelperInScroll.topAnchor, constant: 15).isActive = true
        nameMovieLabel.leadingAnchor.constraint(equalTo: viewHelperInScroll.leadingAnchor, constant: 19).isActive = true
        nameMovieLabel.trailingAnchor.constraint(equalTo: viewHelperInScroll.trailingAnchor, constant: -19).isActive = true
        nameMovieLabel.heightAnchor.constraint(equalToConstant: 58).isActive = true
        
        //ratingAndYearLabel
        ratingAndYearLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingAndYearLabel.topAnchor.constraint(equalTo: nameMovieLabel.bottomAnchor, constant: 10).isActive = true
        ratingAndYearLabel.leadingAnchor.constraint(equalTo: viewHelperInScroll.leadingAnchor, constant: 19).isActive = true
        ratingAndYearLabel.trailingAnchor.constraint(equalTo: viewHelperInScroll.trailingAnchor, constant: -19).isActive = true
        ratingAndYearLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        //descTextView
        descTextView.translatesAutoresizingMaskIntoConstraints = false
        descTextView.topAnchor.constraint(equalTo: ratingAndYearLabel.bottomAnchor, constant: 13).isActive = true
        descTextView.trailingAnchor.constraint(equalTo: viewHelperInScroll.trailingAnchor, constant: -19).isActive = true
        descTextView.leadingAnchor.constraint(equalTo: viewHelperInScroll.leadingAnchor, constant: 19).isActive = true
        descTextView.heightAnchor.constraint(equalToConstant: 138).isActive = true
        
        //linkWebView
        linkWebView.translatesAutoresizingMaskIntoConstraints = false
        linkWebView.topAnchor.constraint(equalTo: descTextView.bottomAnchor, constant: 24).isActive = true
        linkWebView.leadingAnchor.constraint(equalTo: viewHelperInScroll.leadingAnchor, constant: 19).isActive = true
        linkWebView.trailingAnchor.constraint(equalTo: viewHelperInScroll.trailingAnchor, constant: -19).isActive = true
        linkWebView.bottomAnchor.constraint(equalTo: viewHelperInScroll.bottomAnchor, constant: -30).isActive = true
    }
    
    private func addSetup() {
        //movieImage
        movieImage.contentMode = .scaleAspectFill
        
        //mainView
        mainView.layer.cornerRadius = 16
        mainView.backgroundColor = .white
        
        //nameMovieLabel
        nameMovieLabel.textColor = .black
        nameMovieLabel.font = .manrope(24, .bold)
        nameMovieLabel.numberOfLines = 2
        
        //ratingAndYearLabel
        ratingAndYearLabel.textColor = .black
        
        //descTextView
        descTextView.textColor = .black
        descTextView.font = .manrope(15, .regular)
    }
    
    private func addMovieInfo() {
        movieImage.image = (UIImage(data: movieInfo.image!))!
        nameMovieLabel.text = movieInfo.name
        descTextView.text = movieInfo.desc
        linkWebView.load(URLRequest(url: movieInfo.trailerLink!))
        addRatingAndYearLabelInfo()
    }
    
    private func addRatingAndYearLabelInfo() {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "Star.png")
        let attachmentString = NSMutableAttributedString(attachment: attachment)
        
        let firstAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.manrope(14, .bold)
        ]
        let secondAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .light)
        ]
        let thirdAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1),
            NSAttributedString.Key.font: UIFont.manrope(14, .light)
        ]

        let firstString = NSMutableAttributedString(string: "  \(movieInfo.rating!)", attributes: firstAttributes)
        let secondString = NSAttributedString(string: "/10", attributes: secondAttributes)
        let thirdString = NSAttributedString(string: " \(movieInfo.releaseDate!)", attributes: thirdAttributes)
        attachmentString.append(firstString)
        attachmentString.append(secondString)
        attachmentString.append(thirdString)
        ratingAndYearLabel.attributedText = attachmentString
    }
}
