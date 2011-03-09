/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI.res;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;

/**
 * @author Rastislav R@100 Švarba
 */

public class ShowPathButton extends CustomNode {

    public override function create(): Node {
        Group {
            content: [
                ImageView {
                    image: Image {url: "{__DIR__}ShowPath.png"}
                   }
                ]
        }
    }

}
