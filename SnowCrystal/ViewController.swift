//
//  ViewController.swift
//  SnowCrystal
//
//  Created by user on 2018/10/16.
//  Copyright © 2018年 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    // 生成した雪をたくさん載せるところ
    @IBOutlet weak var snowsView: UIView!
    
    // NSAttributeText用の描画設定
    var attribute:[NSAttributedStringKey : Any]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 文字書式設定
        let font = UIFont(name: "Hiragino Maru Gothic ProN", size: 60)!
        let paragraph = NSMutableParagraphStyle()
        attribute = [
            .font: font,
            .paragraphStyle: paragraph,
            .foregroundColor: UIColor.blue,
            .strokeColor: UIColor.white,
            .strokeWidth: -5
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }
    
    // タッチ
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        /* イメージビュー作成　*/
        var image = UIImage(named: "img03")!
        
        image = image.withRenderingMode(.alwaysTemplate)
        
        let snowImageView = UIImageView(image: image)
        snowImageView.tintColor = UIColor.white
        
        let x = arc4random_uniform(UInt32(view.bounds.width))
        snowImageView.frame = CGRect(x: Int(x), y: 0, width: 30, height: 30)
        self.snowsView.addSubview(snowImageView)
        
        // 雪の数を更新する
        let string = "雪の数\(self.snowsView.subviews.count)"
        label.attributedText = NSAttributedString(string: string, attributes:attribute )
        
        // アニメーション指定
        UIView.animate(withDuration: 5, animations: {
            
            // 画面の下まで平行移動
            var transform = CGAffineTransform(translationX: 0, y: self.view.bounds.height)
            
            // 180度回転を追加
            transform = transform.rotated(by: CGFloat(180*Double.pi/180))
            
            // 半分に縮小を追加
            transform = transform.scaledBy(x: 0.5, y: 0.5)
            
            // 雪のImageViewに適用
            snowImageView.transform = transform
            
            // 透明にする
            snowImageView.alpha = 0
            
        }) { (finish) in
            
            // 終わったら削除
            snowImageView.removeFromSuperview()
            
            // 雪の数を更新する
            let string = "雪の数\(self.snowsView.subviews.count)"
            self.label.attributedText = NSAttributedString(string: string, attributes:self.attribute )
        }
    }
}

