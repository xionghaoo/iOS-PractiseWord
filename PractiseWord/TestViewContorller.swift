//
//  TestViewContorller.swift
//  PractiseWord
//
//  Created by xionghao on 2019/6/13.
//  Copyright © 2019 xionghao. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    let questions: [String] = ["Question 1", "Question 2", "Question 3"]
    
    let answers: [String] = ["Answer 1", "Answer 2", "Answer 3"]
    
    var currentQuestionIndex = 0
    
    @IBOutlet weak var currentQuestionLabel: UILabel!
    @IBOutlet weak var currentQuestionLabelCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextQuestionLabel: UILabel!
    @IBOutlet weak var nextQuestionLabelCenterXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestionLabel.text = questions[currentQuestionIndex]
        
        updateOffScreenLabel()
    }
    
    // 每次view被添加到window之前调用, 在即将要显示之前
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nextQuestionLabel.alpha = 0
    }
    
    func updateOffScreenLabel() {
        let screenWidth = view.frame.width
        nextQuestionLabelCenterXConstraint.constant = -screenWidth
    }
    
    @IBAction func onClick(_ sender: UIButton) {
        switch sender.tag {
        case 0:
//            print("click show question")
            // show next question
            currentQuestionIndex += 1
            if currentQuestionIndex == questions.count {
                currentQuestionIndex = 0
            }
            nextQuestionLabel.text = questions[currentQuestionIndex]
            answerLabel.text = "???"
            
            /*
             If you modify the constant of a constraint within an animation block,
             no animation will occur. Why? After a constraint is modified, the system needs to recalculate the
             frames for all of the related views in the hierarchy to accommodate this change. It would be expensive
             for any constraint change to trigger this automatically. (Imagine if you updated quite a few constraints
             – you would not want it to recalculate the frames after each change.) So you must ask the system to
             recalculate the frames when you are done. To do this, you call the method layoutIfNeeded() on a
             view. This will force the view to lay out its subviews based on the latest constraints.
             
             在animation中改变constraint不会生效，这里应该是系统行为。
             解决方法是先设定好改变后的constraint值，再在动画结束时让view重新布局
             */
            let screenWidth = view.frame.width
            nextQuestionLabelCenterXConstraint.constant = 0
            currentQuestionLabelCenterXConstraint.constant += screenWidth
            
            UIView.animate(
                withDuration: 0.5,
                delay: 0,
                options: [],
                animations: {
                    self.currentQuestionLabel.alpha = 0
                    self.nextQuestionLabel.alpha = 1
                    self.view.layoutIfNeeded()
                },
                completion: { _ in
                    // 交换UIView对象的引用
                    swap(&self.currentQuestionLabel, &self.nextQuestionLabel)
                    swap(&self.currentQuestionLabelCenterXConstraint, &self.nextQuestionLabelCenterXConstraint)
                    
                    // 此时nextQuestionLabelCenterXConstraint为 +screenWidth, 要重置下
                    self.updateOffScreenLabel()
                }
            )
        case 1:
//            print("click show answer")
            answerLabel.text = answers[currentQuestionIndex]
        default:
            print("unknow button")
        }
    }
}
