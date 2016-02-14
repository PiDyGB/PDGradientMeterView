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

import Foundation
import UIKit

@IBDesignable
public class PDGradientMeterView: UIView {
    
    @IBInspectable public var minimumColor: UIColor = UIColor.redColor()
    @IBInspectable public var mediumColor: UIColor = UIColor.yellowColor()
    @IBInspectable public var maximumColor: UIColor = UIColor.greenColor()
    
    @IBInspectable public var minimumValue: CGFloat = 0
    @IBInspectable public var maximumValue: CGFloat = 100
    
    private var mValue: CGFloat = 0.5
    private var animateValue = false
    @IBInspectable public var value: CGFloat {
        set {
            var finalValue = newValue
            if newValue <= minimumValue {
                finalValue = minimumValue
            } else  if newValue >= maximumValue {
                finalValue = maximumValue
            }
            mValue = finalValue / (maximumValue - minimumValue)
            if (!animateValue) {
                self.setNeedsLayout()
            } else {
                self.indicator.frame.origin.x = self.frame.size.width * mValue - (self.indicator.frame.width / 2)
            }
        }
        get {
            return mValue * (maximumValue - minimumValue)
        }
    }
    
    public func setValue(value: CGFloat, animated: Bool) {
        self.animateValue = animated
        self.value = value
        self.animateValue = false
    }
    
    @IBInspectable public var indicatorColor: UIColor = UIColor.blackColor() {
        didSet {
            self.indicator.backgroundColor = indicatorColor
        }
    }
    
    private var mIndicator: UIView = UIView()
    public var indicator: UIView {
        set {
            self.mIndicator.removeFromSuperview()
            self.mIndicator = newValue
            self.addSubview(mIndicator)
        }
        get {
            return mIndicator
        }
    }
    
    @IBInspectable public var gradientInset: CGFloat = 4
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addDefaultIndicator()
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.addDefaultIndicator()
        
    }
    
    private func addDefaultIndicator() {
        let defaultIndicator = UIView(frame: CGRect(x: 0, y: 0, width: 2, height: self.frame.height))
        defaultIndicator.backgroundColor = indicatorColor
        
        self.indicator = defaultIndicator
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        var indicatorOriginX = self.frame.size.width * mValue - (self.indicator.frame.width / 2)
        if indicatorOriginX < 0 {
            indicatorOriginX = 0
        } else if indicatorOriginX > (self.frame.maxX - self.frame.minX) {
            indicatorOriginX = self.frame.maxX - self.frame.minX - self.indicator.frame.width
        }
        let originY =   (self.frame.height - self.indicator.frame.height) / 2
        let indicatorFrame = CGRect(x: indicatorOriginX, y: originY, width: self.indicator.frame.width, height: self.indicator.frame.height)
        indicator.frame = indicatorFrame
        
    }
    
    private func drawLinearGradient(context: CGContextRef, rect: CGRect) {
        
        let startPoint = CGPointMake(rect.minX, rect.midY);
        let endPoint = CGPointMake(rect.maxX, rect.midY);
        
        CGContextSaveGState(context);
        CGContextAddRect(context, rect);
        CGContextClip(context);
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations: [CGFloat] = [0, 0.5, 1]
        let colors: [CGColor] = [minimumColor.CGColor, mediumColor.CGColor, maximumColor.CGColor]
        let gradient = CGGradientCreateWithColors(colorSpace, colors, locations)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, []);
        
        CGContextRestoreGState(context);
        
    }
    
    override public func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        if let ctx = UIGraphicsGetCurrentContext() {
            
            let gradientRect = CGRectInset(rect, 0, gradientInset)
            
            self.drawLinearGradient(ctx, rect: gradientRect)
        }
        
    }
}
