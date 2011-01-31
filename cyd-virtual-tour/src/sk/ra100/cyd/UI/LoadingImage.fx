/*
 * loadingImage.fx
 *
 * Created on 19.3.2010, 21:19:36
 */
package sk.ra100.cyd.UI;

import javafx.scene.image.Image;
import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;

/**
 * @author ra100
 */
public class LoadingImage extends CustomNode {

    def limage = Image { }
    public var screenWidth ;
    public var screenHeight ;

    public override function create(): Node {
        return Group {
                    content: [ 
                       
                    ]
                };
    }

}
