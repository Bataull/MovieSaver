import UIKit

final class MovieInfoTableViewCell: UITableViewCell {
    
    static let identifier = "MovieInfoTableViewCell"
    
    private let movieImageView = UIImageView()
    private let nameMovieeLabel = UILabel()
    private let ratingMovieLabel = UILabel()
    private let mainView = UIView()
    private let infoStackView = UIStackView()
    private let mainStackView = UIStackView()
    
    override init(style:UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview()
        addConstraints()
        addSetup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInfoMovie(NameMovie name: String, RatingMovie rating: NSAttributedString, ImageMovie image: UIImage) {
        nameMovieeLabel.text = name
        ratingMovieLabel.attributedText = rating
        movieImageView.image = image
    }
    
    private func addSubview() {
        contentView.addSubview(mainView)
        mainView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(movieImageView)
        mainStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(nameMovieeLabel)
        infoStackView.addArrangedSubview(ratingMovieLabel)
    }
    
    private func addConstraints() {
        
        //mainView
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        //mainStackView
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        
        //movieImgaeView
        movieImageView.widthAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.5).isActive = true
        movieImageView.heightAnchor.constraint(equalTo: mainView.heightAnchor).isActive = true
        
        //nameMovieLabel
        nameMovieeLabel.translatesAutoresizingMaskIntoConstraints = false
        nameMovieeLabel.heightAnchor.constraint(equalTo: infoStackView.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    private func addSetup() {
        
        //contentView
        contentView.backgroundColor = UIColor(named: "bgColor")
        
        //movieImageView
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        
        //mainView
        mainView.backgroundColor = UIColor(named: "white_black")
        mainView.layer.cornerRadius = 10
        
        //mainStackView
        mainStackView.axis = .horizontal
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        mainStackView.layer.cornerRadius =  10
        
        //infoStackView
        infoStackView.axis = .vertical
        infoStackView.alignment = .center
        infoStackView.distribution = .fillProportionally
        
        //nameMovieLabel
        nameMovieeLabel.textColor = UIColor(named: "black_white")
        nameMovieeLabel.textAlignment = .center
        nameMovieeLabel.font = .manrope(18, .medium)
        nameMovieeLabel.numberOfLines = 3
        
        //ratingMovieLabel
        ratingMovieLabel.textColor = UIColor(named: "black_white")
        ratingMovieLabel.textAlignment = .center
        ratingMovieLabel.font = .manrope(18, .medium)
    }
}
