/*
* Copyright (C) 2016 Giuseppe Buzzanca
*
* Licensed under the Apache License, Version 2.0 (the "License"); you may not
* use this file except in compliance with the License. You may obtain a copy of
* the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
* WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
* License for the specific language governing permissions and limitations under
* the License.
*/

import UIKit
import PDGradientMeterView

class ViewController: UIViewController {
    
    @IBOutlet weak var slider1: PDGradientMeterView!
    @IBOutlet weak var slider2: PDGradientMeterView!
    @IBOutlet weak var slider3: PDGradientMeterView!
    
    var slider3Indicator: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "ic_keyboard_arrow_up_36pt")?.imageWithRenderingMode(.AlwaysTemplate)
        slider3Indicator = UIImageView(image: image)
        slider3Indicator!.contentMode = .Bottom
        slider3Indicator!.frame = CGRect(x: 0, y: 0, width: slider3Indicator!.frame.width, height: slider3Indicator!.frame.height * 1.4)
        slider3Indicator!.tintColor = slider3.mediumColor
        slider3.indicator = slider3Indicator!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeAction(sender: UIButton) {
        let num1 = Int(arc4random_uniform(UInt32(self.slider1.maximumValue) + 1))
        let num2 = Int(arc4random_uniform(UInt32(self.slider2.maximumValue) + 1))
        let num3 = Int(arc4random_uniform(UInt32(self.slider3.maximumValue) + 1))
        
        UIView.animateWithDuration(0.5, animations: {
            self.slider1.setValue(CGFloat(num1), animated: true)
            self.slider2.setValue(CGFloat(num2), animated: true)
            self.slider3.setValue(CGFloat(num3), animated: true)
        })
    }
}

