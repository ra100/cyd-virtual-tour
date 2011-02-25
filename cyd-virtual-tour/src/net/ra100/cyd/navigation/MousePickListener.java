/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.ra100.cyd.navigation;

import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.media.j3d.PickInfo;
import javax.media.j3d.Shape3D;
import javax.media.j3d.Transform3D;
import javax.swing.SwingUtilities;
import javax.vecmath.Vector3d;
import net.ra100.cyd.main.PanoUniverse;
import net.ra100.cyd.scene.PanoExtension;
import net.ra100.cyd.scene.Shape;

/**
 *
 * @author ra100
 */
public class MousePickListener implements MouseListener {

    private PanoUniverse parent;
    private Vector3d vector = null;
    private Shape shape = null;

    public MousePickListener(PanoUniverse pu) {
        this.parent = pu;
    }

    @Override
    public void mouseClicked(MouseEvent me) {
        int clicks = me.getClickCount();
        if (clicks == 2 && SwingUtilities.isLeftMouseButton(me)) {
            pick(me);
        }
    }

    @Override
    public void mousePressed(MouseEvent me) {
    }

    @Override
    public void mouseReleased(MouseEvent me) {
    }

    @Override
    public void mouseEntered(MouseEvent me) {
    }

    @Override
    public void mouseExited(MouseEvent me) {
    }

    private void pick(MouseEvent me) {

        parent.getPickCanvas().setShapeLocation(me.getX(), me.getY());
        PickInfo pickInfo = parent.getPickCanvas().pickClosest();

        if (pickInfo != null) {

            Shape3D pickedShape3D = (Shape3D) pickInfo.getNode();
            Logger.getLogger(MousePickListener.class.getName()).log(Level.INFO,
                    "Picked object: {0}", pickedShape3D.getName());
            processShape(pickedShape3D);
        }

    }

    /**
     * zisti ci zadanu objekt je stred panoramy alebo extended objekt panoramy
     * @param sp najdeny objekt
     */
    private void processShape(Shape3D sp) {
        Iterator<PanoExtension> it = parent.getWalkBeh().getActualShape()
                .getExtended().iterator();
        while (it.hasNext()) {
            PanoExtension pe = it.next();
            if (pe.getShape().equals(sp)) {
                parent.setExtension(pe);
            }
        }
    }

//    private Shape findShape(Shape3D sp) {
//        Iterator<Shape> it = parent.getShapes().iterator();
//        while (it.hasNext()) {
//            Shape sh = it.next();
//            if (sh.getCenter().getName().matches(sp.getName())) {
//                return sh;
//            }
//        }
//        return null;
//    }
}
