/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package sk.ra100.cyd.scene;

import javax.media.j3d.Appearance;
import javax.media.j3d.Shape3D;
import javafx.scene.image.Image;

/**
 *
 * @author ra100
 */
public class PanoExtension {

    public static final int IMAGE = 1;
    public static final int TEXT = 2;
    public static final int GUESTBOOK = 3;

    private String name = null;
    private Shape3D shape = null;
    private boolean visible;
    private int type = 0;
    private Image image = null;
    private String url = "";

    public PanoExtension(Shape3D _shape) {
        this.shape = _shape;
    }

    public PanoExtension() {
    }

    public Shape3D getShape() {
        return shape;
    }

    public void setShape(Shape3D shape) {
        this.shape = shape;
    }

        public boolean isVisible() {
        return visible;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setVisible(boolean visible) {
        Appearance ap = shape.getAppearance();
        if (visible) {
            Helper.setTransparency(ap, 0.0f);
            shape.setPickable(true);
        } else {
            Helper.setTransparency(ap, 1.0f);
            shape.setPickable(false);
        }
        this.visible = visible;
    }

    public void setTransparency(float trans) {
        Appearance ap = shape.getAppearance();
        Helper.setTransparency(ap, trans);
        if (trans >= 1.0f) {
            shape.setPickable(false);
        } else {
            shape.setPickable(true);
        }
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

}
