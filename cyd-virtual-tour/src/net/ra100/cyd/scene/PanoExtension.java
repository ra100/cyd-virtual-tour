/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package net.ra100.cyd.scene;

import net.ra100.cyd.utils.Helper;
import javax.media.j3d.Appearance;
import javax.media.j3d.Shape3D;
import javafx.scene.image.Image;
import javax.media.j3d.TransparencyAttributes;

/**
 * rozsirenia pre panoramu, obrazky, texty, guestbook, ...
 * @author ra100
 */
public class PanoExtension {

    /**
     * jedinecne meno
     */
    private String name = null;

    /**
     * objekt v grafe sceny
     */
    private Shape3D shape = null;

    /**
     * viditelnost
     */
    private boolean visible;

    /**
     * v pripade typu 1, obrazok
     */
    private Image image = null;

    /**
     * constructor
     * @param _shape objekt sceny, ktoremu patri toto rozsirenie
     */
    public PanoExtension(Shape3D _shape) {
        this.shape = _shape;
    }

    /**
     * constructor
     * @param meno extension
     */
    public PanoExtension(String _name) {
        this.name = _name;
    }

    /**
     * zakladny contructor
     */
    public PanoExtension() {
    }

    /**
     * getter
     * @return objekt sceny
     */
    public Shape3D getShape() {
        return shape;
    }

    /**
     * setter
     * @param shape objekt sceny
     */
    public void setShape(Shape3D shape) {
        this.shape = shape;
    }

    /**
     * vrati visibilitu objektu
     * @return true/false
     */
    public boolean isVisible() {
        return visible;
    }

    /**
     * vrati meno objektu
     * @return String
     */
    public String getName() {
        return name;
    }

    /**
     * nastavenie mena
     * @param name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * nastavenie viditelnosti objaktu na scene
     * @param visible
     */
    public void setVisible(boolean visible) {
        Appearance ap = shape.getAppearance();
        if (visible) {
            Helper.setTransparency(ap, 0.0f, TransparencyAttributes.BLENDED);
            shape.setPickable(true);
        } else {
            Helper.setTransparency(ap, 1.0f, TransparencyAttributes.FASTEST);
            shape.setPickable(false);
        }
        this.visible = visible;
    }

    /**
     * nastavenie presnej urovne priehladnosti, ak je uplne priehladny, neda sa nan kliknut
     * @param trans uroven priehladnosti
     */
    public void setTransparency(float trans) {
        Appearance ap = shape.getAppearance();
        if (trans >= 1.0f) {
            Helper.setTransparency(ap, trans, TransparencyAttributes.SCREEN_DOOR);
            shape.setPickable(false);
        } else {
            Helper.setTransparency(ap, 0.0f, TransparencyAttributes.BLENDED);
            shape.setPickable(true);
        }
    }

    /**
     * getter
     * @return
     */
    public Image getImage() {
        return image;
    }

    /**
     * setter
     * @param image
     */
    public void setImage(Image image) {
        this.image = image;
    }
}
