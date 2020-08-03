/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Table view controller used to display suggested search criteria.
*/

import UIKit
import MapKit

protocol SuggestionsTableResultDelegate {
    func shareCityTouchUpInside(_ city: String)
}

class SuggestionsTableViewController: UITableViewController {
    
    private var searchCompleter: MKLocalSearchCompleter?
    private var searchRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world)
    private var currentPlacemark: CLPlacemark?
    
    private var suggestionController: SuggestionsTableViewController!
    
    private var searchController: UISearchController!
    
    var delegate: SuggestionsTableResultDelegate?
    
    var completerResults: [MKLocalSearchCompletion]?
    var output: SuggestionsTableViewControllerOutput!
    var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(SuggestedCompletionTableViewCell.self, forCellReuseIdentifier: SuggestedCompletionTableViewCell.reuseID)
        tableView.delegate = self
        
        suggestionController = SuggestionsTableViewController(style: .grouped)
        searchController = UISearchController(searchResultsController: suggestionController)
        searchController.searchResultsUpdater = suggestionController
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchController.searchBar.delegate = self
        startProvidingCompletions()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopProvidingCompletions()
    }
    
    private func startProvidingCompletions() {
        searchCompleter = MKLocalSearchCompleter()
        searchCompleter?.delegate = self
        searchCompleter?.resultTypes = .address
    }
    
    private func stopProvidingCompletions() {
        searchCompleter = nil
        dismiss(animated: true, completion: nil)
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
        self.city = city
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
        tableView.reloadData()
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

    }
    
    
}

extension SuggestionsTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
