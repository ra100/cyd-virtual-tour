/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import net.ra100.cyd.scene.Shape;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.input.MouseEvent;
import javafx.scene.control.Label;
import javafx.scene.effect.Effect;
import javafx.scene.effect.Bloom;
import javafx.scene.effect.ColorAdjust;
import net.ra100.cyd.UI.res.Point;
import javafx.scene.layout.Stack;
import javafx.scene.layout.Panel;
import net.ra100.cyd.utils.DataElement;

/**
 * @author ra100
 */

public class MapPoint extends CustomNode {

    protected var point: Node = Point {
            onMouseEntered: function(e: MouseEvent): Void {
                mouseOver();
            }
            onMouseExited: function(e: MouseEvent): Void {
                mouseOut();
            }
            onMouseClicked: function(e: MouseEvent): Void {
                setActive();
            }
        }

    protected var size: Float;

    protected var name: String;

    protected var shape: Shape;

    protected var panel: MapPanel;

    protected var actUsers: Integer = 0;
    
    public def overEffect: Effect = Bloom {threshold: 0.5}
    public def activeEffect: Effect = ColorAdjust {
	brightness: 0.0
	contrast: 1.0
	hue: 0.7
	saturation: 0.5 }

    public-read var active: Boolean = false;

    protected var label: Label;

    public override function create(): Node {
        return point
    }

    public function setShape() {
        name = shape.getName();

        var x: Float = shape.getMapcoordinates()[0] + panel.xoffset;
        var y: Float = shape.getMapcoordinates()[2] + panel.yoffset;
        x = x * panel.scale;
        y = y * panel.scale;
        size = 1;

        point.translateX = x;
        point.translateY = y;
        point.scaleX = size;
        point.scaleY = size;
    }

    /**
     nastavenie aktivnej panoramy a zmena pozicie
    */
    protected function setActive(): Void {
        panel.myScene.dataloader.action = 'leave';
        panel.myScene.dataloader.input = [DataElement{ value: this.shape.getTitle(), key: 'panoname'}];
        panel.myScene.dataloader.load(0);
        panel.myScene.changeShape(shape);
        active = true;
        this.effect = activeEffect;
        panel.getActive().leave();
        panel.setActive(this);
        //zapis po nacitani
        panel.myScene.dataloader.action = 'enter';
        panel.myScene.dataloader.input = [DataElement{ value: this.shape.getTitle(), key: 'panoname'}];
        panel.myScene.dataloader.load(0);
        //---
    }

    /**
    zmeni obrazok na mape, ked sa meni panorama pohybom sipkami
    */
    protected function changeActive(): Void {
        panel.myScene.dataloader.action = 'leave';
        panel.myScene.dataloader.input = [DataElement{ value: this.shape.getTitle(), key: 'panoname'}];
        panel.myScene.dataloader.load(0);
        active = true;
        this.effect = activeEffect;
        panel.getActive().leave();
        panel.setActive(this);
        //zapis po nacitani
        panel.myScene.dataloader.action = 'enter';
        panel.myScene.dataloader.input = [DataElement{ value: this.shape.getTitle(), key: 'panoname'}];
        panel.myScene.dataloader.load(0);
    }


    /**
    * nastavi vychodziu panoramu
    */
    protected function setFirst() {
        panel.myScene.changeShape(shape);
        active = true;
        this.effect = activeEffect;
    }


    protected function leave(): Void {
        active = false;
        this.effect = null;
    }

    protected function mouseOver() {
        point.scaleX = 1.3;
        point.scaleY = 1.3;
        label.text = Integer.toHexString(actUsers);
        label.visible = true;
    }

    protected function mouseOut() {
        point.scaleX = 1.0;
        point.scaleY = 1.0;
        label.visible = false;
    }

    public function getTitle(): String {
        return shape.getTitle();
    }


}
