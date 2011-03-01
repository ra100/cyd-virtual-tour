/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import net.ra100.cyd.main.PanoScene;
import javafx.scene.control.Label;
import net.ra100.cyd.UI.res.MapBG;
import javafx.scene.Node;
import javafx.geometry.VPos;
import javafx.scene.layout.Stack;
import javafx.animation.transition.TranslateTransition;
import javafx.scene.Group;
import javafx.scene.layout.VBox;
import javafx.scene.layout.HBox;
import net.ra100.cyd.scene.Shape;
import javafx.scene.layout.Panel;
import javafx.scene.layout.Flow;
import javafx.scene.shape.Line;
import javafx.scene.paint.Color;
import javafx.scene.shape.Rectangle;

/**
 * @author ra100
 * panel pre zobrazenie mapy
 */

public class MapPanel extends CustomNode {
    def height: Float = 150;
    def width: Float = 150;
    public var hideWidth: Float = 164;
    public var myScene: PanoScene;
    var active: Boolean = true;
    var label = Label {
        translateX: 5
        text: " "};
    def bg = MapBG{};

    public var scale: Float = 1;
    public var xoffset: Float = 0;
    public var yoffset: Float = 0;

    public var activePano: MapPoint;
    public var mapPanos: MapPoint[];
    
    /*helper*/
    def back: Rectangle = Rectangle {
	x: 0, y: 0
	width: 150, height: 200
	fill: Color.web("#cccccc")
        opacity: 0.0
    }

    public var map: CustomPanel = CustomPanel { content: [back]  }

    public override function create(): Node {
        hide();
        return Stack {
            content: [
        bg,
        VBox {
            content: [
                HBox {
                    height: 32
                    spacing : 4
                    content: [
                        label
                    ]
                }
                map
            ]
        }
        ]
        }

    }

    public function initMap() {
       var minx: Float = 0;
       var maxx: Float = 0;
       var miny: Float = 0;
       var maxy: Float = 0;
       var shapes: Shape[] = myScene.getShapes();
       for (a in shapes) {
           var mp: MapPoint = MapPoint{};
           mp.shape = a;
           mp.panel = this;
           mp.label = this.label;
           insert mp into mapPanos;

           if (minx > a.getMapcoordinates()[0]) minx = a.getMapcoordinates()[0];
           if (maxx < a.getMapcoordinates()[0]) maxx = a.getMapcoordinates()[0];
           if (miny > a.getMapcoordinates()[2]) miny = a.getMapcoordinates()[2];
           if (maxy < a.getMapcoordinates()[2]) maxy = a.getMapcoordinates()[2];
       }

       var xscale: Float = width / (maxx - minx);
       var yscale: Float = height / (maxy - miny);

       if (xscale < yscale) scale = xscale
       else scale = yscale;

       xoffset = ((-1)*minx);
       yoffset = ((-1)*miny);

       for (a in mapPanos) {
           a.setShape();
           insert a into map.content;
           if (a.shape.getFirst()) {
               activePano = a;
               activePano.setFirst();
           }

       }


    }

    public function show() {
        active = true;
        TranslateTransition {
            duration: 0.5s
            node: this
            fromX: 0 - hideWidth
            toX: 0
            repeatCount: 1
        }.play();
    }

    public function hide() {
        active = false;
        TranslateTransition {
            duration: 0.5s
            node: this
            fromX: 0
            toX: 0 - hideWidth
            repeatCount: 1
        }.play();
    }

    public function changeState() {
        if (active) {
            hide();
        } else {
            show();
        }
    }

    public function getScene(): PanoScene {
        return myScene;
    }

    public function setActive(mp: MapPoint) {
        activePano = mp;
    }

    public function getActive() : MapPoint {
        return activePano;
    }



}
