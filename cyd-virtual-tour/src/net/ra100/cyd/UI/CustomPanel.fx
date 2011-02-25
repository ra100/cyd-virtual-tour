/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.layout.Panel;

/**
 * @author ra100
 */

public class CustomPanel extends Panel {

   public function onLayout():Void {
        for (node in content) {
            positionNode(node, node.layoutX, node.layoutY);
        }
    }
}
