/*
 * UniverseFX.fx
 *
 * Created on 25.1.2010, 8:38:41
 */
package net.ra100.cyd.main;

import javafx.async.JavaTaskBase;
import javafx.async.RunnableFuture;
import java.util.Observer;
import java.util.Observable;
import net.ra100.cyd.UI.ExtensionDisplay;
import net.ra100.cyd.utils.AsyncTask;
import java.awt.image.BufferedImage;
import javafx.ext.swing.SwingUtils;
import java.awt.Component;
import java.awt.Rectangle;
import java.awt.Graphics;
import net.ra100.cyd.scene.Shape;

/**
 * @author ra100
 */
package class UniverseFX extends JavaTaskBase, Observer {
    
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
        universe = new PanoUniverse(scene.sceneurl);
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
    }

    package function changeShape(sp: Shape) {
        universe.changePanoFX(sp);
    }

    package function showExtras() {
        universe.showExtras();
        universe.setExtras(true);
    }

    package function hideExtras() {
        universe.hideExtras();
        universe.setExtras(false);
    }

    protected var loaded: Integer = 0;
    protected var loaderVisible: Boolean = true;
    protected var extension: ExtensionDisplay = new ExtensionDisplay();
    protected var initialized: Boolean = false;

    /* sledovanie zmien v PanoUniverse, spusti sa, ked sa zavola startNotification()*/
    override public function update(arg0: Observable, arg1: Object): Void {
        FX.deferAction(
        function (): Void {
            if (universe.getUpdateMap()) {
                scene.updateMap();
                universe.setUpdateMap(false);
                return;
            }
            if (not initialized) {
                if (universe.isInitialized()) {
                    initialized = true;
                    scene.firstInit();
                }
            }
            loaded = universe.getLoaded();
            if (loaded == 100) {
                scene.block = true;
                stopLoading();
            } else {
                setLoaderImage();
            }
            if (universe.getExtension() != null) {
                setLoaderImage();
                AsyncTask {
                    run: function() {
                        extension.setExtension(universe.getExtension());
                    }
                    onDone: function() {
                        if (extension.type != "pano") {
                            stopLoading();
                            extension.visible = true;
                        } else {
                            deleteExt();
                            scene.changePano(extension.url);
                            extension.visible = false;
                        }  
                    }
                }.start();
            } else {
                extension.visible = false;
            }
        });
    }

    public function setLoaderImage() {
        if (not loaderVisible) {
            var bi : BufferedImage = componentToImage(scene.fxCanvas3DComp.getJComponent());
            scene.progressBackground.image = SwingUtils.toFXImage(bi);

            startLoading();
        }
    }

    /*
    * spravi obrazok z componentu, aby nezmizol obraz, ked sa meni scena
    */
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

    public function startLoading(): Void {
        scene.showLoader();
        loaderVisible = true;
    }

    public function stopLoading(): Void {
        scene.hideLoader();
        loaderVisible = false;
    }

}
