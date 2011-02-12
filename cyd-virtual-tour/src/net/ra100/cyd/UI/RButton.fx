/*
 * RButton.fx
 *
 * Created on 1.4.2010, 9:33:10
 */
package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import javafx.scene.Group;
import javafx.scene.Node;
import javafx.scene.input.MouseEvent;
import javafx.scene.effect.Effect;
import javafx.scene.effect.SepiaTone;
import javafx.scene.effect.Glow;
import javafx.ext.swing.SwingLabel;

/**
 * @author ra100
 */
public class RButton extends CustomNode {

    public var image: Node;
    public var isOver: Boolean;
    public var overEffect: Effect = Glow {
                    level: 1
                };
    public var activeEffect : Effect;
    public var text : String;
    public var label : SwingLabel;

    public var showGroup = Group {
                content: [image]
                effect: bind activeEffect;
                onMouseClicked: function (e: MouseEvent): Void {
                    action();
                }
                onMouseEntered: function (e: MouseEvent): Void {
                    mouseOver();
                }
                onMouseExited: function (e: MouseEvent): Void {
                    mouseOut();
                }
                onMousePressed: function (e: MouseEvent): Void {
                    mousePressed();
                }
                onMouseReleased: function (e: MouseEvent): Void {
                    mouseReleased();
                }


            };

    public override function create(): Node {
        showGroup;
    }

    public var action: function(): Void;

    function mouseOver() {
        activeEffect = overEffect;
        label.text = text;
        label.visible = true;
        isOver = true;
    }

    function mouseOut() {
        activeEffect = null;
        label.visible = false;
        isOver = false;
    }

    function mousePressed() {
        activeEffect = SepiaTone {
            level: 0.5
        }
    }
    
    function mouseReleased() {
            if (isOver) {activeEffect = overEffect;}
            else {activeEffect = null;}
    }



}

