/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.navigation;

import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;

/**
 *
 * @author ra100
 */
public class NavigationKeyListener implements KeyListener{

    private WalkBehavior walkBeh = null;
    private double speed = 10;

    public NavigationKeyListener(WalkBehavior wb){
        super();
        walkBeh = wb;
    }

    @Override
    public void keyTyped(KeyEvent ke) {

    }

    @Override
    public void keyPressed(KeyEvent ke) {
        switch (ke.getKeyCode()){
            case KeyEvent.VK_LEFT:  walkBeh.moveCamera(-0.1*speed, 0, 0); break;
            case KeyEvent.VK_A:     walkBeh.moveCamera(-0.1*speed, 0, 0); break;

            case KeyEvent.VK_RIGHT: walkBeh.moveCamera(0.1*speed, 0, 0); break;
            case KeyEvent.VK_D:     walkBeh.moveCamera(0.1*speed, 0, 0); break;

            case KeyEvent.VK_UP:    walkBeh.moveCamera(0.0, 0, -0.1*speed); break;
            case KeyEvent.VK_W:     walkBeh.moveCamera(0.0, 0, -0.1*speed); break;

            case KeyEvent.VK_DOWN:  walkBeh.moveCamera(0.0, 0, 0.1*speed); break;
            case KeyEvent.VK_S:     walkBeh.moveCamera(0.0, 0, 0.1*speed); break;

            case KeyEvent.VK_Z:     walkBeh.moveCamera(0.0, -0.1*speed, 0); break;

            case KeyEvent.VK_X:     walkBeh.moveCamera(0.0, 0.1*speed, 0); break;

            default: break;
        }
    }

    @Override
    public void keyReleased(KeyEvent ke) {

    }
}
