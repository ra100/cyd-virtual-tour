/*
 * Main.fx
 *
 * Created on 25.1.2010, 8:36:32
 */
package net.ra100.cyd.main;

import java.util.Locale;

/**
 * @author ra100
 */
function run(args: String[]): Void {
    Locale.setDefault(new Locale("SK"));
    var scene: PanoScene = new PanoScene();
    scene.create();
}
