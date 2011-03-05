/*
 * FXCanvas3DSBComp.fx
 *
 * Created on 25.1.2010, 8:42:10
 */

package net.ra100.cyd.main;

import javax.swing.JPanel;

import javafx.ext.swing.SwingComponent;

// FXCanvas3D API 3.0

import com.interactivemesh.j3d.community.gui.FXCanvas3DRepainter;
import com.interactivemesh.j3d.community.gui.FXCanvas3DSB;

/**
 * FXCanvas3DSBComp.fx
 *
 * Version: 1.0
 * Date: 2009/11/09
 *
 * Copyright (c) 2009
 * August Lammersdorf, InteractiveMesh e.K.
 * Kolomanstrasse 2a, 85737 Ismaning
 * Germany / Munich Area
 * www.InteractiveMesh.com/org
 *
 * Please create your own implementation.
 * This source code is provided "AS IS", without warranty of any kind.
 * You are allowed to copy and use all lines you like of this source code
 * without any copyright notice,
 * but you may not modify, compile, or distribute this 'FXCanvas3DSBComp.fx'.
 *
 */

package class FXCanvas3DSBCompR extends SwingComponent, FXCanvas3DRepainter {

    // Parent of FXCanvas3DSB
    var container: JPanel;

    // FXCanvas3DSB instance
    var fxCanvas3D: FXCanvas3DSB;
    var panoscene = null;

    package var isScreenSize: Boolean = false;

     // Create SwingComponent - called at construction time
    override protected function createJComponent(): JPanel{
        container = new JPanel();
    }

    // Called from Main
    package function initFXCanvas3D(universe: PanoUniverse, scene: PanoScene) {
        fxCanvas3D = universe.createFXCanvas3D(this, container, isScreenSize);
        panoscene = scene;
    }
    
    // Interface FXCanvas3DRepainter

    // Called from FXCanvas3DSB
    override function repaintFXCanvas3D() {
        /*
         JavaFX API :
         A deferAction represents an action that should be executed
         at a later time of the system's choosing.
         In systems based on event dispatch, such as Swing, execution of a
         deferAction generally means putting it on the event queue for later processing.
        */
        FX.deferAction(
            function(): Void {

                // Now we are in the JavaFX painting loop and on the EDT

                // Repaint FXCanvas3DSB

                // Call doesn't wait, paintComponent() will be called in the next loop !?
                fxCanvas3D.repaint();
            }
        );
    }
}
