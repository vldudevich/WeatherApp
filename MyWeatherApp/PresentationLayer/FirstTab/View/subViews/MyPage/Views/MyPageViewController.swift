import UIKit
import CoreData

class MyPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // MARK: Delegate methords
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = pages.firstIndex(of: pageContentViewController)!
        saveCurrentPage(for: pageControl.currentPage)
        //Utils.indexPage = pageControl.currentPage
    }
    
    // MARK: Data source functions.
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        saveCurrentPage(for: pageControl.currentPage)
        //Utils.indexPage = pageControl.currentPage
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            //            return orderedViewControllers.last
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard pages.count > previousIndex else {
            return nil
        }
        
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = pages.count
        saveCurrentPage(for: pageControl.currentPage)
        //Utils.indexPage = pageControl.currentPage
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            //            return orderedViewControllers.first
            // Uncommment the line below, remove the line above if you don't want the page control to loop.
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return pages[nextIndex]
    }
    
    let pageControl = UIPageControl()щ
    
    var pages = [UIViewController]()
    
    func addController(controller: TodayWeatherContentViewController) {
        pages.append(controller)
        setViewControllers([pages.last!], direction: .forward, animated: true, completion: nil)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = pages.count - 1
        saveCurrentPage(for: pageControl.currentPage)
        //Utils.indexPage = pageControl.currentPage
    }
    
    func removeCurrentPage() {
        
        let fetchRequest:
            NSFetchRequest<City> = City.fetchRequest()
        
        do {
            let last =  try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequest).last!
            PersistenceService.shared.persistentContainer.viewContext.delete(last)
            PersistenceService.shared.saveContext()
            
        } catch {}
        
        if pages.count > 1 {
            pages.remove(at: pageControl.currentPage)
            if pageControl.currentPage == 0 {
                setViewControllers([pages.last!], direction: .forward, animated: true, completion: nil)
            } else {
                setViewControllers([pages.first!], direction: .forward, animated: true, completion: nil)
            }
        } else {
            self.didMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }

        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = pages.count - 1
        saveCurrentPage(for: pageControl.currentPage)
        //Utils.indexPage = pageControl.currentPage
    }
    
    func saveCurrentPage(for index: Int) {
        let currentPage = CurrentPage(context: PersistenceService.shared.persistentContainer.viewContext)
        currentPage.cityIndex = Int16(index)
        PersistenceService.shared.saveContext()
    }
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        dataSource = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        configPageControl()
    }
    
    func configPageControl() {
        
        let controlHeight: CGFloat = 10
        let bottomSpace: CGFloat = 175
        let yPosition = controlHeight
        let fullScreenWidth = view.frame.size.width
        let frame = CGRect(x: 0, y: yPosition, width: fullScreenWidth, height: controlHeight)
        
        pageControl.frame = frame
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        self.view.addSubview(pageControl)
    }
}
