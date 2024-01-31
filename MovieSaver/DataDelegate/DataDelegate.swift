import UIKit

protocol NameDelegate: AnyObject {
    func nameDelegate(_ name: String)
}

protocol RatingDelegate: AnyObject {
    func ratingDelegate(_ rating: String)
}

protocol DateDelegate: AnyObject {
    func dateDelegate(_ date: Date)
}

protocol LinkDelegate: AnyObject {
    func linkDelegate(_ url: URL)
}
