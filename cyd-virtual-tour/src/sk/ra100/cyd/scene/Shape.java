/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.ra100.cyd.scene;

import java.util.ArrayList;
import javax.media.j3d.Appearance;
import javax.media.j3d.Bounds;
import javax.media.j3d.Shape3D;

/**
 * datova struktura na popisky 3d objektov
 * @author ra100
 */
public class Shape {

    private String name = null;
    private String texture = null;
    private String title = null;
    private Shape3D pano = null;
    private boolean visible = false;
    private boolean textureLoaded = false;
    private String centerName = null;
    private Shape3D center = null;
    private ArrayList<String> boundNames = new ArrayList<String>();
    private ArrayList<Bounds> bound = new ArrayList<Bounds>();
    private ArrayList<Shape> connection = new ArrayList<Shape>();
    private ArrayList<String> connectionNames = new ArrayList<String>();
    private ArrayList<PanoExtension> extended = new ArrayList<PanoExtension>();
    public static String path = null;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTexture() {
        return texture;
    }

    public void setTexture(String texture) {
        this.texture = texture;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public boolean isTextureLoaded() {
        return textureLoaded;
    }

    public void setTextureLoaded(boolean textureLoaded) {
        if (!textureLoaded) {
            this.textureLoaded = textureLoaded;
        } else {
            if (!this.textureLoaded) {
               this.textureLoaded =
                        Helper.loadTexture(pano.getAppearance(), this, path);
            }
        }
    }

    public boolean isVisible() {
        return visible;
    }

    public void setVisible(boolean visible) {
        if (visible) {
            setTransparency(0.0f);
            setTextureLoaded(true);
            if (center != null) {
            center.setPickable(false);}
        } else {
            setTransparency(1.0f);
            if (center != null) {
            center.setPickable(true);}
        }
        this.visible = visible;
    }

    public void setTransparency(float trans) {
        Appearance ap = pano.getAppearance();
        Helper.setTransparency(ap, trans);
    }

    public void addBound(Bounds bound) {
        this.bound.add(bound);
    }

    public ArrayList<Bounds> getBound() {
        return bound;
    }

    public void setBound(ArrayList<Bounds> bound) {
        this.bound = bound;
    }

    public void addBoundName(String bn) {
        this.boundNames.add(bn);
    }

    public ArrayList<String> getBoundNames() {
        return boundNames;
    }

    public void setBoundNames(ArrayList<String> boundNames) {
        this.boundNames = boundNames;
    }

    public ArrayList<Shape> getConnection() {
        return connection;
    }

    public void setConnection(ArrayList<Shape> connection) {
        this.connection = connection;
    }

    public void addConnection(Shape shape) {
        connection.add(shape);
    }

    public Shape3D getPano() {
        return pano;
    }

    public void setPano(Shape3D pano) {
        this.pano = pano;
    }

    public ArrayList<String> getConnectionNames() {
        return connectionNames;
    }

    public void setConnectionNames(ArrayList<String> connectionNames) {
        this.connectionNames = connectionNames;
    }

    public void addConnectionName(String cname){
        connectionNames.add(cname);
    }

    public Shape3D getCenter() {
        return center;
    }

    public void setCenter(Shape3D center) {
        this.center = center;
    }

    public String getCenterName() {
        return centerName;
    }

    public void setCenterName(String centerName) {
        this.centerName = centerName;
    }

    public ArrayList<PanoExtension> getExtended() {
        return extended;
    }

    public void setExtended(ArrayList<PanoExtension> extended) {
        this.extended = extended;
    }

    public void addExtended(PanoExtension pe) {
        this.extended.add(pe);
    }

}
