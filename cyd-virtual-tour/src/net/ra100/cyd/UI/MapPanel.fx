/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import net.ra100.cyd.main.PanoScene;
import javafx.scene.control.Label;

/**
 * @author ra100
 * panel pre zobrazenie mapy
 */

public class MapPanel extends CustomNode {
    public var hideWidth: Integer = 27;
    public var hideHeight: Integer = 27;
    public var myScene: PanoScene;
    var label = Label {text: " "
    style: "font-family: 'Helvetica'; font-size: 12pt"};
}
