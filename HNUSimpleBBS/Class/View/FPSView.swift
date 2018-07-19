//
//  FPSView.swift
//  HNUSimpleBBS
//
//  Created by CodingDoge on 2018/6/7.
//  Copyright © 2018年 CodingDoge. All rights reserved.
//

class FPSView: UIView {
    
    
    lazy var displayLabel: UILabel! = {
        
        let frame = CGRect.init(x: UIScreen.main.bounds.size.width - 100, y: UIScreen.main.bounds.size.height - 50, width: 80, height: 30)
        
        let label = UILabel.init(frame: frame)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.textAlignment = .center
        label.isUserInteractionEnabled = false
        label.backgroundColor = UIColor.init(white: 0.0, alpha: 0.7)
        
        return label
    }()
    
    private var link: CADisplayLink!
    private var count: NSInteger = 0
    private var lastTime: TimeInterval = 0.0
    public static let shared = FPSView(frame: .zero)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFpsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initFpsView() {
        
        
        
        self.initCADisplayLink()
        
        UIApplication.shared.keyWindow?.addSubview(displayLabel)
        
        
        
    }
    private func initCADisplayLink(){
        
        link = CADisplayLink(target: self, selector: #selector(tick(link:)))
        link.add(to: RunLoop.main, forMode: .commonModes)
        
        
    }
    
    @objc private func tick(link: CADisplayLink) {
        print("link.timestamp:\(link.timestamp) link.duration:\(link.duration)")
        if lastTime == 0 {
            lastTime = link.timestamp
            return
        }
        
        count += 1;//记录tick在1秒内执行的次数
        //计算本次刷新和上次更新fps的时间间隔
        let delta: TimeInterval = link.timestamp - lastTime
        //大于等于1秒时,来计算FPS
        if delta >= 1 {
            lastTime = link.timestamp
            let fps: CGFloat = CGFloat(TimeInterval(count) / delta) //次数 除以 时间 = FPS (次/秒)
            count = 0
            self.updateDisplayLabelText(fps: fps)
            
        }
        
    }
    
    private func updateDisplayLabelText(fps: CGFloat){
        
        let  progress: CGFloat = fps / 60.0
        let     color: UIColor = UIColor.init(hue: 0.27 * (progress - 0.2), saturation: 1, brightness: 0.9, alpha: 1)
        displayLabel.text = "\(Int(round(fps))) FPS"
        displayLabel.textColor = color
        
        
    }
    
    deinit {
        link.invalidate()
    }
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
