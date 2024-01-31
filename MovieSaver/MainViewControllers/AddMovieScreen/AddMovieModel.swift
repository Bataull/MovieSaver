import UIKit

//MARK: - Protocol

protocol AddMovieModel: AnyObject {
    func setNavigationController(_ navigationController: UINavigationController?)
    func movieImageTapped()
    func nameButtonTapped()
    func ratingButtonTapped()
    func dateButtonTapped()
    func linkButtonTapped()
    func setNameDelegate(_ nameDelegate: NameDelegate?)
    func setRatingDelegate(_ ratingDelegate: RatingDelegate?)
    func setDateDelegate(_ date: DateDelegate?)
    func setLinkDelegate(_ url: LinkDelegate?)
    
}

//MARK: - Default

final class DefaultAddMovieModel: NSObject, AddMovieModel, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    private var navigationController: UINavigationController?
    private var presentingViewController: UIViewController?
    private var pickedImage: UIImage? 
    private var movieImageView: UIImageView = UIImageView()
    
    
    weak var nameDelegate: NameDelegate?
    weak var ratingDelegate: RatingDelegate?
    weak var dateDelegate: DateDelegate?
    weak var linkDelegate: LinkDelegate?
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
        }
    
    func setNavigationController(_ navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func setNameDelegate(_ delegate: NameDelegate?) {
        self.nameDelegate = delegate
    }
    
    func setRatingDelegate(_ ratingDelegate: RatingDelegate?) {
        self.ratingDelegate = ratingDelegate
    }
    
    func setDateDelegate(_ date: DateDelegate?) {
        self.dateDelegate = date
    }
    
    func setLinkDelegate(_ url: LinkDelegate?) {
        self.linkDelegate = url
    }
    
    //MARK: - ChangeButtons
    
    func nameButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nameVC = storyboard.instantiateViewController(withIdentifier: FilmNameViewController.identifier) as? FilmNameViewController {
            nameVC.delegate = nameDelegate
            navigationController?.pushViewController(nameVC, animated: true)
        }
    }
    
    func ratingButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let ratingVC = storyboard.instantiateViewController(withIdentifier: RatingViewController.identifier) as? RatingViewController {
            ratingVC.delegate = ratingDelegate
            navigationController?.pushViewController(ratingVC, animated: true)
        }
    }
    
    func dateButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let dateVC = storyboard.instantiateViewController(withIdentifier: DatePickerViewController.identifier) as? DatePickerViewController {
            dateVC.delegate = dateDelegate
            navigationController?.pushViewController(dateVC, animated: true)
        }
    }
    
    func linkButtonTapped() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let linkVC = storyboard.instantiateViewController(withIdentifier: TrailerLinkViewController.identifier) as? TrailerLinkViewController {
            linkVC.delegate = linkDelegate
            navigationController?.pushViewController(linkVC, animated: true)
        }
    }
    
    //MARK: - Camera Setups
    
    func movieImageTapped() {
        let alert = UIAlertController(title: nil , message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            self.openCamera()
        }))

        alert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            self.openGallery()
        }))

        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        if let presentingViewController = presentingViewController {
                    presentingViewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            if let presentingViewController = presentingViewController {
                presentingViewController.present(imagePicker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Warning", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let presentingViewController = presentingViewController {
                    presentingViewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            if let presentingViewController = presentingViewController {
                presentingViewController.present(imagePicker, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Warning", message: "Error", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                if let presentingViewController = presentingViewController {
                    presentingViewController.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            pickedImage = image
        }
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pickedImage = image
        }
        if let addMovieViewController = presentingViewController as? AddMovieViewController {
            addMovieViewController.updateMovieImage(pickedImage)
        }
    }
}
