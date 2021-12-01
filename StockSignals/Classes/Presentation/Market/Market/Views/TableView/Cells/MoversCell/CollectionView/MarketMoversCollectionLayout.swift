//
//  MarketMoversCollectionLayout.swift
//  StockSignals
//
//  Created by Andrey Chernyshev on 30.11.2021.
//

final class MarketMoversCollectionLayout: UICollectionViewLayout {
    private lazy var cache: [UICollectionViewLayoutAttributes] = []
    
    private lazy var contentWidth = CGFloat()
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: 192.scale)
    }

    override func prepare() {
        guard cache.isEmpty, let view = collectionView else {
            return
        }
        
        var xRow1 = CGFloat(0)
        var xRow2 = CGFloat(50.5.scale)
        
        for item in 0 ..< view.numberOfItems(inSection: 0) {
            let even = item % 2 == 0
            
            let x = even ? xRow1 : xRow2
            let y = even ? 16.scale : 104.scale
            
            let origin = CGPoint(x: x, y: y)
            let size = CGSize(width: 101.scale, height: 76.scale)
            let frame = CGRect(origin: origin, size: size)
            
            let indexPath = IndexPath(item: item, section: 0)
            
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attrs.frame = frame
            
            cache.append(attrs)
            
            let addX = 16.scale + 101.scale
            xRow1 += even ? addX : 0
            xRow2 += even ? 0 : addX
            
            contentWidth = max(contentWidth, frame.maxX)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        cache[indexPath.item]
    }
}
