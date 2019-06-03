import UIKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
    
 @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
    
    if recognizer.state == UIGestureRecognizerState.ended {
        // 1
        let velocity = recognizer.velocity(in: self.view)
        let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
        let slideMultiplier = magnitude / 200
        print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
        
        // 2
        let slideFactor = 0.1 * slideMultiplier     //Increase for more of a slide
        // 3
        var finalPoint = CGPoint(x:recognizer.view!.center.x + (velocity.x * slideFactor),
                                 y:recognizer.view!.center.y + (velocity.y * slideFactor))
        // 4
        finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
        finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
        
        // 5
        UIView.animate(withDuration: Double(slideFactor * 2),
                       delay: 0,
                       // 6
            options: UIViewAnimationOptions.curveEaseOut,
            animations: {recognizer.view!.center = finalPoint },
            completion: nil)
    }

    }

  
  @IBAction func handlePinch(recognizer : UIPinchGestureRecognizer) {
    if let view = recognizer.view {
        view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
        recognizer.scale = 1
    }

  }
  
  @IBAction func handleRotate(recognizer : UIRotationGestureRecognizer) {
    if let view = recognizer.view {
        view.transform = view.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
    }

    
  }
  
  @objc func handleTap(recognizer: UITapGestureRecognizer) {
    
  }
  
}


extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }

}

