import UIKit
import Foundation

var views: [UIViewController] = [InitialViewController.viewControllerGenerate("initial1VC"), InitialViewController.viewControllerGenerate("initial2VC"), InitialViewController.viewControllerGenerate("initial3VC")]

class InitialViewController: UIPageViewController {
    
    weak var initialDelegate: IconsViewControllerDelegate?
    
    override func viewDidLoad() {
        
        print("test")
        
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        //APRESENTANDO PRIMEIRAMENTE SEMPRE A INITIAL1
        if let firstViewController = views.first {
            setViewControllers([firstViewController],direction: .forward, animated: true, completion: nil)
        }
        
        initialDelegate?.InitialViewController(InitialViewController: self, didUpdatePageCount: views.count)
        
    }
    
    //FUNC QUE RETORNA UMA VIEWCONTROLLER A PARTIR DE UM IDENTIFIER
    static func viewControllerGenerate(_ nome: String) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: nome)
        return view
    }
}


//ATENDENDO AO PROTOCOLO UIPageViewControllerDataSource
extension InitialViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = views.index(of: viewController) else { return nil }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else { return nil }
        
        guard views.count > previousIndex else { return nil }
        
        return views[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = views.index(of: viewController) else { return nil }
        
        let nextIndex = viewControllerIndex + 1
        
        guard views.count != nextIndex else { return nil }
        
        guard views.count > nextIndex else { return nil }
        
        return views[nextIndex]
    }
}

//ATENDENDO AO PROTOCOLO UIPageViewControllerDelegate
extension InitialViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first, let index = views.index(of: firstViewController) {
            initialDelegate?.InitialViewController(InitialViewController: self, didUpdatePageIndex: index)
        }
    }
    
}
