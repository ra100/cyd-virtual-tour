package sk.ra100.cyd.scene;

import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.media.j3d.Appearance;
import javax.media.j3d.Bounds;
import javax.media.j3d.Shape3D;
import javax.media.j3d.Transform3D;
import javax.vecmath.Vector3f;

/**
 * datova struktura na popisky 3d objektov, reprezentujuce jednotlive panoramy
 * @author ra100
 */
public class Shape {

    /**
     * meno objektu
     */
    private String name = null;

    /**
     * cesta k texture
     */
    private String texture = null;

    /**
     * skrateny nazov, pouziva sa na vytvorenie prepojeni medzi panoramami, susednosti
     */
    private String title = null;

    /**
     * objekt sceny reprezentujuci panoramu
     */
    private Shape3D pano = null;

    /**
     * viditelnost panoramy
     */
    private boolean visible = false;

    /**
     * pomoc pre dynamicke loadovanie textur, zmeni sa na tru, ked sa nastavi textura
     */
    private boolean textureLoaded = false;

    /**
     * jedinecne meno objektu, ktory je v strede panoramy
     */
    private String centerName = null;

    /**
     * objek sceny v strede panoramy
     */
    private Shape3D center = null;

    /**
     * suradnice stredu panoramy na minimape, x,y,z
     * TODO
     */
    private float[] mapcoordinates = new float[3];

    /**
     * nazvy hranic panoramy
     */
    private ArrayList<String> boundNames = new ArrayList<String>();

    /**
     * vnutorne hranice panoramy
     */
    private ArrayList<Bounds> bound = new ArrayList<Bounds>();

    /**
     * zoznam susednych panoram
     */
    private ArrayList<Shape> connection = new ArrayList<Shape>();

    /**
     * prepojenie na susedne panoramy cez ich Title
     */
    private ArrayList<String> connectionNames = new ArrayList<String>();

    /**
     * zoznam rozsireni pre danu panoramu
     */
    private ArrayList<PanoExtension> extended = new ArrayList<PanoExtension>();

    /**
     * cesta k VRML suboru
     */
    public static String path = null;

    /**
     * getter
     * @return
     */
    public String getName() {
        return name;
    }

    /**
     * setter
     * @param name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * getter
     * @return
     */
    public String getTexture() {
        return texture;
    }

    /**
     * setter
     * @param texture
     */
    public void setTexture(String texture) {
        this.texture = texture;
    }

    /**
     * getter
     * @return
     */
    public String getTitle() {
        return title;
    }

    /**
     * setter
     * @param title
     */
    public void setTitle(String title) {
        this.title = title;
    }

    /**
     * getter
     * @return
     */
    public boolean isTextureLoaded() {
        return textureLoaded;
    }

    /**
     * naloadovanie textury
     * ak je true a este nebola nacitana textura, tak ju nacita
     * @param textureLoaded
     */
    public void setTextureLoaded(boolean textureLoaded) {
        if (!textureLoaded) {
            this.textureLoaded = textureLoaded;
        } else {
            if (!this.textureLoaded) {
               this.textureLoaded =
                        Helper.loadTexture(pano.getAppearance(), this, path);
            } else {
                this.textureLoaded = textureLoaded;
            }
        }
    }

    /**
     * zistenie visibility
     * @return
     */
    public boolean isVisible() {
        return visible;
    }

    /**
     * nastavenie viditelnosti
     * @param visible
     */
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

    /**
     * nastaveni priehladnosti
     * @param trans
     */
    public void setTransparency(float trans) {
        Appearance ap = pano.getAppearance();
        Helper.setTransparency(ap, trans);
    }

    /**
     * oridanie hranicneho objektu
     * @param bound
     */
    public void addBound(Bounds bound) {
        this.bound.add(bound);
    }

    /**
     * vrati cely zoznam hranic
     * @return
     */
    public ArrayList<Bounds> getBound() {
        return bound;
    }

    /**
     * prida vsetky hranice naraz
     * @param bound
     */
    public void setBound(ArrayList<Bounds> bound) {
        this.bound = bound;
    }

    /**
     * prida meno hranice
     * @param bn
     */
    public void addBoundName(String bn) {
        this.boundNames.add(bn);
    }

    /**
     * vrati zoznam mien hranic
     * @return
     */
    public ArrayList<String> getBoundNames() {
        return boundNames;
    }

    /**
     * nastavi cely zoznam hranic
     * @param boundNames
     */
    public void setBoundNames(ArrayList<String> boundNames) {
        this.boundNames = boundNames;
    }

    /**
     * vrati vsetky susedne Shapes
     * @return ArrayList<Shape>
     */
    public ArrayList<Shape> getConnection() {
        return connection;
    }

    /**
     * nastavi susedne panoramy
     * @param connection
     */
    public void setConnection(ArrayList<Shape> connection) {
        this.connection = connection;
    }

    /**
     * prida susednu poanoramu
     * @param shape
     */
    public void addConnection(Shape shape) {
        connection.add(shape);
    }

    /**
     * vrati objekt sceny prisluchajuci panorame (gulova plocha s texturou panoramy)
     * @return
     */
    public Shape3D getPano() {
        return pano;
    }

    /**
     * nastavi objekt sceny prisluchajuci panorame
     * @param pano
     */
    public void setPano(Shape3D pano) {
        this.pano = pano;
    }

    /**
     * vrati zoznam mien susedov
     * @return
     */
    public ArrayList<String> getConnectionNames() {
        return connectionNames;
    }

    /**
     * nastavi mena susedov
     * @param connectionNames
     */
    public void setConnectionNames(ArrayList<String> connectionNames) {
        this.connectionNames = connectionNames;
    }

    /**
     * prida meno sused
     * @param cname
     */
    public void addConnectionName(String cname){
        connectionNames.add(cname);
    }

    /**
     * vrati objekt sceny pre stred panoramy
     * @return
     */
    public Shape3D getCenter() {
        return center;
    }

    /**
     * nastavi objekt sceny pre stred
     * @param center
     */
    public void setCenter(Shape3D center) {
        this.center = center;
        Transform3D t = new Transform3D();
        center.getLocalToVworld(t);
        Vector3f vec = new Vector3f();
        t.get(vec);
        this.mapcoordinates[0] = vec.getX();
        this.mapcoordinates[1] = vec.getY();
        this.mapcoordinates[2] = vec.getZ();
        Logger.getLogger(Shape.class.getName()).log(Level.INFO,
                        "Position: {0} {1} {2}", new Object[]{
                        String.valueOf(this.mapcoordinates[0]),
                        String.valueOf(this.mapcoordinates[1]),
                        String.valueOf(this.mapcoordinates[2])});
    }

    /**
     * vrati nazov stredu
     * @return
     */
    public String getCenterName() {
        return centerName;
    }

    /**
     * nastavi meno stredu
     * @param centerName
     */
    public void setCenterName(String centerName) {
        this.centerName = centerName;
    }

    /**
     * vrati zoznam rozsireni
     * @return
     */
    public ArrayList<PanoExtension> getExtended() {
        return extended;
    }

    /**
     * nastavi zoznam rozsireni
     * @param extended
     */
    public void setExtended(ArrayList<PanoExtension> extended) {
        this.extended = extended;
    }

    /**
     * prida rozsirenie
     * @param pe
     */
    public void addExtended(PanoExtension pe) {
        this.extended.add(pe);
    }

    /**
     * vrati suradnice stredu pre minimapu
     * @return
     */
    public float[] getMapcoordinates() {
        return mapcoordinates;
    }

    /**
     * nastavi suradnice stradu pre minimapu
     * @param mapcoordinates
     */
    public void setMapcoordinates(float[] mapcoordinates) {
        this.mapcoordinates = mapcoordinates;
    }

}
