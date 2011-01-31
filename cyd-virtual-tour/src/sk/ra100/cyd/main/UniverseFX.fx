/*
 * UniverseFX.fx
 *
 * Created on 25.1.2010, 8:38:41
 */
package sk.ra100.cyd.main;

import javafx.async.JavaTaskBase;
import javafx.async.RunnableFuture;
import java.util.Observer;
import java.util.Observable;
import sk.ra100.cyd.UI.ExtensionDisplay;
import sk.ra100.cyd.UI.AsyncTask;
import javafx.scene.image.Image;
import java.awt.image.BufferedImage;
import javafx.ext.swing.SwingUtils;
import java.awt.Component;
import java.awt.Rectangle;
import java.awt.Graphics;
import javafx.animation.transition.ScaleTransition;

/**
 * @author ra100
 */
package class UniverseFX extends JavaTaskBase, Observer {

    public def FORWARD: Integer = 1;
    public def BACKWARD: Integer = 2;
    public def RIGHT: Integer = 3;
    public def LEFT: Integer = 4;
    public def UP: Integer = 5;
    public def DOWN: Integer = 6;
    def speed: Integer = 50;

    public-read var universe: PanoUniverse;
    var scene : PanoScene;
    
    // Implemented in Main, called here from 'onDone'
    package var initUniverse: function(universe: PanoUniverse): Void;

    //
    // Universe interaction
    //
    package function closeUniverse() {
        universe.closeUniverse();
    }

    //
    // Implementation of JavaTaskBase
    //
    // Create RunnableFuture: PanoUniverse
    // Called in function 'start()'
    protected override function create(): RunnableFuture {
        universe = new PanoUniverse();
        universe.addObserver(this);
        return universe;
    }
    // Called from Main.fx
    // Initializes the 3D scene : calls run() on RunnableFuture 'universe'

    protected override function start(): Void {
        // Nothing to do
        super.start();
    }
    // Callback: Finish init

    override var onDone = function (): Void {
                initUniverse(universe);
            };

    package function showCenters() {
        universe.showCenters();
            }

    package function hideCenters() {
        universe.hideCenters();
            }

    package function showExtras() {
        universe.showExtras();
        universe.setExtras(true);
            }

    package function hideExtras() {
        universe.hideExtras();
        universe.setExtras(false);
            }

    package var move: Boolean = false;

    /**
    * smer
    * 1 dopredu, 2 dozadu, 3 vpravo, 4 vlavo, 5 hore, 6 dole
    */
    package function moveCamera(direction: Integer) {
         if (direction == FORWARD) {universe.getWalkBeh().moveCamera(0.0, 0, -0.1*speed);}
         else if (direction == BACKWARD) {universe.getWalkBeh().moveCamera(0.0, 0, 0.1*speed); }
         else if (direction == RIGHT) {universe.getWalkBeh().moveCamera(0.1*speed, 0, 0); }
         else if (direction == LEFT) {universe.getWalkBeh().moveCamera(-0.1*speed, 0, 0); }
         else if (direction == UP) {universe.getWalkBeh().moveCamera(0.0, -0.1*speed, 0); }
         else if (direction == DOWN) {universe.getWalkBeh().moveCamera(0.0, 0.1*speed, 0); }
         //scene.updateScreen();
    }

    protected var loaded: Integer = 0;
    protected var loaderVisible: Boolean = true;
    protected var extension: ExtensionDisplay = new ExtensionDisplay();

    override public function update(arg0: Observable, arg1: Object): Void {
        FX.deferAction(
        function (): Void {
            loaded = universe.getLoaded();
            scene.loaded = loaded;
            if (loaded == 100) {
                scene.block = true;
                loaderVisible = false;
            } else {
                setLoaderImage();
            }
            if (universe.getExtension() != null) {
                scene.loaded = 0;
                loaderVisible = true;
                AsyncTask {
                    run: function() {
                        extension.setExtension(universe.getExtension());
                    }

                    onDone: function() {
                        extension.visible = true;
                        scene.loaded = 100;
                        loaderVisible = false;
                        scene.updateScreen();
                    }
                }.start();
            } else {
                extension.visible = false;
            }
            scene.updateScreen();
            });
    }

    function setLoaderImage() {
        var bi : BufferedImage = componentToImage(scene.fxCanvas3DComp.getJComponent());
        scene.progressBackground.image = SwingUtils.toFXImage(bi);

        loaderVisible = true;
    }

    function componentToImage(cmp : Component) : BufferedImage  {
        var d : Rectangle = cmp.getBounds();
        var bi : BufferedImage = new BufferedImage (d.width,d.height,
                                BufferedImage.TYPE_BYTE_INDEXED);
        var g : Graphics = bi.createGraphics();
        g.setColor(java.awt.Color.white);
        g.fillRect(0, 0, d.width, d.height);
        g.setClip(0, 0, d.width, d.height);
        cmp.printAll(g);

        return(bi);
    }


    public function deleteExt(){
        universe.setExtensionNo(null);
    }

    public function setScene(sc: PanoScene){
        scene = sc;
        extension.setScene(sc);
    }

    public function getTrace():String{
        return universe.getTrace();
    }


}
