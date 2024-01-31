import CoreData
import UIKit

final class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    //MARK: - Properties
    
    private let mainTableView = UITableView()
    private var moviesInfo: [Movie] = []
    private var fetchResultController: NSFetchedResultsController<Movie>!
    
    var viewModel: ViewModel!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addSetups()
        addConstraints()
        addNavigationControllerUI()
        mainTableView.register(MovieInfoTableViewCell.self, forCellReuseIdentifier: MovieInfoTableViewCell.identifier)
        coreDataSetups()
        
        viewModel = DefaultViewModel()
        if let viewModel = viewModel as? DefaultViewModel {
            viewModel.setNavigationController(self.navigationController)
        }
    }
    
    //MARK: - CoreData
    
    private func coreDataSetups() {
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    moviesInfo = fetchedObjects
                }
            } catch {
                print(error)
            }
        }
    }
    
    //MARK: - AddSubviews
    
    private func addSubViews() {
        view.addSubview(mainTableView)
    }
    
    //MARK: - Constraints
    
    private func addConstraints() {
        mainTableView.translatesAutoresizingMaskIntoConstraints = false
        mainTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        mainTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mainTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mainTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    //MARK: - Setups
    
    private func addSetups() {
        addSetupsTableView()
    }
    
    private func addSetupsTableView() {
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.separatorStyle = .none
        mainTableView.backgroundColor = UIColor(named: "bgColor")
    }
    
    private func addNavigationControllerUI() {
        title = "My Movie List"
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(addNewButtonClick)
        )
    }
    
    //MARK: - Action
    
    @objc private func addNewButtonClick() {
        viewModel.addNewButtonClick()
    }
    
    //MARK: - RatingEditor
    
    private func ratingMovieInfo(_ indexPath: IndexPath) -> NSMutableAttributedString {
        let firstAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor(named: "black_white") ?? "",
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        let secondAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 0.592, green: 0.592, blue: 0.592, alpha: 1),
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .light)
        ]
        let firstString = NSMutableAttributedString(
            string: "\(moviesInfo[indexPath.row].rating!)",
            attributes: firstAttributes
        )
        let secondString = NSAttributedString(
            string: "/10",
            attributes: secondAttributes
        )
        firstString.append(secondString)
        return firstString
    }
    
}

//MARK: - TableViewExtensions

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesInfo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: MovieInfoTableViewCell.identifier, for: indexPath) as? MovieInfoTableViewCell {
            let movie = moviesInfo[indexPath.row]
            cell.setInfoMovie(
                NameMovie: movie.name!,
                RatingMovie: ratingMovieInfo(indexPath),
                ImageMovie: UIImage(data: movie.image! as Data)!
            )
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailScreenVC = storyboard.instantiateViewController(withIdentifier: DetailScreenViewController.identifier) as? DetailScreenViewController {
            detailScreenVC.movieInfo = moviesInfo[indexPath.item]
            navigationController?.pushViewController(detailScreenVC, animated: true)
        }
    }
}
