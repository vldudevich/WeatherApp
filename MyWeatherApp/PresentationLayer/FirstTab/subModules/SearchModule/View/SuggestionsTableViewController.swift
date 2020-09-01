/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Table view controller used to display suggested search criteria.
*/

import UIKit
import MapKit
import CoreLocation

protocol SuggestionsTableResultDelegate {
    func shareCityTouchUpInside(_ city: String)
}

class SuggestionsTableViewController: UITableViewController {

    private let locationManager = CLLocationManager()
    
    private var searchCompleter: MKLocalSearchCompleter?
    
    private var suggestionController: UITableViewController!
    
    private var searchController: UISearchController!
    
    var delegate: SuggestionsTableResultDelegate?
    
    private var completerResults: [MKLocalSearchCompletion]?
    
    var output: SuggestionsTableViewControllerOutput!
    
    private var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.onViewDidLoad()
    }
    
    func configureButtoCurrentLocation() {
        var currentLocationButton = UIButton()
        currentLocationButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        currentLocationButton.addTarget(self, action: #selector(getCurrentLocation), for: .touchUpInside)
        currentLocationButton.setTitle("Use current location", for: .normal)
        currentLocationButton.setTitleColor(.blue, for: .normal)
        currentLocationButton.backgroundColor = UIColor.lightGray
        self.view.addSubview(currentLocationButton)
    }
    
    func retriveCurrentLocation(){
        
        var currentLoc: CLLocation!
        
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() == .authorizedAlways) {
           currentLoc = locationManager.location

        }
        
        CLGeocoder().reverseGeocodeLocation(currentLoc) { placemarks, error in
            
            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }

            guard let reversedGeoLocation = placemark.locality else { return }
            self.delegate?.shareCityTouchUpInside(reversedGeoLocation)
            self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopProvidingCompletions()
    }
    
    private func startProvidingCompletions() {
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
    }
    
    private func stopProvidingCompletions() {
        searchCompleter = nil
        dismiss(animated: true, completion: nil)
    }
    
    @objc func getCurrentLocation() {
        retriveCurrentLocation()
    }
}

extension SuggestionsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return completerResults?.count ?? 0
    }

    /// - Tag: HighlightFragment
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SuggestedCompletionTableViewCell.reuseID, for: indexPath)

        if let suggestion = completerResults?[indexPath.row] {
            cell.textLabel?.attributedText = createHighlightedString(text: suggestion.title, rangeValues: suggestion.titleHighlightRanges)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let city = completerResults?[indexPath.row].title else { return }
        delegate?.shareCityTouchUpInside(city)
        self.navigationController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    private func createHighlightedString(text: String, rangeValues: [NSValue]) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.backgroundColor: UIColor(named: "suggestionHighlight")! ]
        let highlightedString = NSMutableAttributedString(string: text)
        
        // Each `NSValue` wraps an `NSRange` that can be used as a style attribute's range with `NSAttributedString`.
        let ranges = rangeValues.map { $0.rangeValue }
        ranges.forEach { (range) in
            highlightedString.addAttributes(attributes, range: range)
        }
        
        return highlightedString
    }
}

extension SuggestionsTableViewController: MKLocalSearchCompleterDelegate {
    
    /// - Tag: QueryResults
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        // As the user types, new completion suggestions are continuously returned to this method.
        // Overwrite the existing results, and then refresh the UI with the new results.
        completerResults = completer.results
        suggestionController.tableView.reloadData()
    }
}

extension SuggestionsTableViewController: UISearchResultsUpdating {

    /// - Tag: UpdateQuery
    func updateSearchResults(for searchController: UISearchController) {
        // Ask `MKLocalSearchCompleter` for new completion suggestions based on the change in the text entered in `UISearchBar`.
        searchCompleter?.queryFragment = searchController.searchBar.text ?? ""
    }
}

private class SuggestedCompletionTableViewCell: UITableViewCell {
    
    static let reuseID = "SuggestedCompletionTableViewCellReuseID"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SuggestionsTableViewController: SuggestionsTableViewControllerInput {
    func setupState() {
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        configureButtoCurrentLocation()
        
        suggestionController = UITableViewController(style: .grouped)
        suggestionController.tableView.register(SuggestedCompletionTableViewCell.self, forCellReuseIdentifier: SuggestedCompletionTableViewCell.reuseID)
        suggestionController.tableView.dataSource = self
        suggestionController.tableView.delegate = self
        
        searchController = UISearchController(searchResultsController: suggestionController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        startProvidingCompletions()
    }
}

extension SuggestionsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
