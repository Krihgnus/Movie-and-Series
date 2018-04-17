import UIKit
import Foundation

var views: [UIViewController] = [InitialViewController.viewControllerGenerate("initial1VC"), InitialViewController.viewControllerGenerate("initial2VC"), InitialViewController.viewControllerGenerate("initial3VC")]

class InitialViewController: UIPageViewController {
    
    weak var initialDelegate: IconsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        //Apresentando primeiramente sempre a initial1
        if let firstViewController = views.first {
            setViewControllers([firstViewController],direction: .forward, animated: true, completion: nil)
        }
        
        initialDelegate?.InitialViewController(InitialViewController: self, didUpdatePageCount: views.count)
        
    }
    
    //Func que retorna uma UIViewController a partir de um identifier
    static func viewControllerGenerate(_ nome: String) -> UIViewController {
        let view = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: nome)
        return view
    }
}


//Atendendo ao protocolo UIPageViewControllerDataSource
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

//Atendendo ao protocolo UIPageViewControllerDelegate
extension InitialViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let firstViewController = viewControllers?.first, let index = views.index(of: firstViewController) {
            initialDelegate?.InitialViewController(InitialViewController: self, didUpdatePageIndex: index)
        }
    }
    
}
