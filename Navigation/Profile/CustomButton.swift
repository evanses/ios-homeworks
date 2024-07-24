import UIKit

class CustomButton : UIButton {
    
    // MARK: - Data

    var action: (() -> Void)
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        self.action = {}
        
        super.init(frame: frame)
        
      }

    required init?(coder aDecoder: NSCoder) {
       self.action = {}

       super.init(coder: aDecoder)
    }
    
    init(title: String, titleColor: UIColor, backgroundColor: UIColor, action: (@escaping () -> Void)) {
    
        self.action = action
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.isEnabled = false
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // MARK: - Action
    
    @objc private func buttonTapped() {
        self.action()
    }
    
}
