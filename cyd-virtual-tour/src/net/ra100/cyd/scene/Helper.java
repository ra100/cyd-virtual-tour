/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package net.ra100.cyd.scene;

import com.sun.j3d.utils.image.TextureLoader;
import java.awt.image.BufferedImage;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.media.j3d.Appearance;
import javax.media.j3d.TransparencyAttributes;
import com.sun.j3d.loaders.Scene;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import org.jdesktop.j3d.loaders.vrml97.VrmlLoader;

/**
 *
 * @author ra100
 */
public class Helper {

    /**
     * Nastavuje uroven priehladnosti
     * @param ap - Appearance, ktoremu nastavi priehladnost
     * @param trans - uroven priehladnosti
     */
    public static void setTransparency(Appearance ap, float trans) {
            TransparencyAttributes ta =
                    new TransparencyAttributes(TransparencyAttributes.SCREEN_DOOR, trans);
            ap.setTransparencyAttributes(ta);
    }

    /**
     * Nastavuje uroven priehladnosti
     * @param ap - Appearance, ktoremu nastavi priehladnost
     * @param trans - uroven priehladnosti
     * @param attr - typ priehladnosti
     */
    public static void setTransparency(Appearance ap, float trans, int attr) {
            TransparencyAttributes ta =
                new TransparencyAttributes(attr, trans);
            ap.setTransparencyAttributes(ta);
    }

    /**
     * Vyhladanie objektu reprezentovaneho jeho nazvom
     * @param sx - Zoznam objektov, v ktorom hladat
     * @param name - nazov, ktory vyhladat
     * @return - objekt popisujuci panoramu
     */
    public static Shape findShapeByTitle(SceneXML sx, String name) {
        Iterator<Shape> shi = sx.getShapes().iterator();
        while (shi.hasNext()) {
            Shape sh = shi.next();
            if (sh.getTitle().matches(name)) {
                return sh;
            }
        }
        return null;
    }

    /**
     * Vyhladanie objektu reprezentovaneho jeho nazvom, podla mena
     * @param sx - Zoznam objektov, v ktorom hladat
     * @param name - nazov, ktory vyhladat
     * @return - objekt popisujuci panoramu
     */
    public static Shape findShape(SceneXML sx, String name) {
        Iterator<Shape> shi = sx.getShapes().iterator();
        while (shi.hasNext()) {
            Shape sh = shi.next();
            if (sh.getName().matches(name)) {
                return sh;
            }
        }
        return null;
    }

    /**
     * Najde panoramu, ktorej prislucha hladane ohranicenie
     * @param sx - zoznam objektov, v ktorom hladat
     * @param name - nazov hladaneho objektu
     * @return - Objekt popisujuci panoramu
     */
    public static Shape findBoundShape(SceneXML sx, String name) {
        Iterator<Shape> shi = sx.getShapes().iterator();
        while (shi.hasNext()) {
            Shape sh = shi.next();
            Iterator<String> is = sh.getBoundNames().iterator();
            while (is.hasNext()) {
                if (is.next().matches(name)) {
                    return sh;
                }
            }
        }
        return null;
    }

    /**
     * Najdenie, v ktorej panorame sa nachadza rozsirenie
     * @param sx - zoznam objektov
     * @param name - hladany nazov
     * @return - Objekt panoramy
     */
    public static Shape findExtensionShape(SceneXML sx, String name) {
        Iterator<Shape> shi = sx.getShapes().iterator();
        while (shi.hasNext()) {
            Shape sh = shi.next();
            Iterator<PanoExtension> is = sh.getExtended().iterator();
            while (is.hasNext()) {
                if (is.next().getName().matches(name)) {
                    return sh;
                }
            }
        }
        return null;
    }

    /**
     * najdenie, ktorej panorame patri stred
     * @param sx - zoznam objektov
     * @param name - hladny nazov
     * @return - panorama
     */
    public static Shape findCenterShape(SceneXML sx, String name) {
        Iterator<Shape> shi = sx.getShapes().iterator();
        while (shi.hasNext()) {
            Shape sh = shi.next();
            String is = sh.getCenterName();
            if (is.matches(name)) {
                return sh;
            }
        }
        return null;
    }

    /**
     * Nacitanie obrazku, ktory bude textura pre extension objekty
     * @return BufferedImage
     */
    public static BufferedImage loadBack() {
        BufferedImage img = null;
        try {
            URL loadUrl = new URL("http://ra100.scifi-guide.net/brhlovce/files/resources/back.png");
            URLConnection con = loadUrl.openConnection();
            img = ImageIO.read(con.getInputStream());
        } catch (Exception e) {
            Logger.getLogger(Helper.class.getName()).log(Level.SEVERE,
                    "Chyba pri nahravani suboru: ", e);
        } finally {
            return img;
        }
    }

    /**
     * pomocny objekt, vytori InputStream z URL
     * @param url
     * @return InputStream
     */
    public static InputStream urlInputStream(String url){
        try {
            URL loadUrl = new URL(url);
            URLConnection con = loadUrl.openConnection();
            //                        BufferedReader in = new BufferedReader(
            //                                new InputStreamReader(
            //                                con.getInputStream()));
            return con.getInputStream();
        } catch (Exception e) {
            Logger.getLogger(Helper.class.getName()).log(Level.SEVERE,
                    "Chyba pri nahravani suboru: ", e);
        }
        return null;
    }

    /**
     * Nahravanie textury(obrazok panoramy na objekt)
     * @param ap - kam nahrat texturu
     * @param shape - panorama, ktora ma odkaz na texturu
     * @param sceneXml - zoznam panoram
     * @return - ak prebehne uspesne, vrati TRUE, inak FALSE
     */
    public static boolean loadTexture(Appearance ap, Shape shape, SceneXML sceneXml) {
        BufferedImage img = null;
        try {
            URL loadUrl = new URL(sceneXml.getPath() + "" + shape.getTexture());
            URLConnection con = loadUrl.openConnection();
            //                        BufferedReader in = new BufferedReader(
            //                                new InputStreamReader(
            //                                con.getInputStream()));
            img = ImageIO.read(con.getInputStream());
        } catch (Exception e) {
            Logger.getLogger(Helper.class.getName()).log(Level.SEVERE,
                    "Chyba pri nahravani suboru: ", e);
            return false;
        } finally {
            TextureLoader tex = new TextureLoader(img);
            ap.setTexture(tex.getTexture());
            return true;
        }
    }

    /**
     * Nahravanie textury(obrazok panoramy na objekt)
     * @param ap - kam nahrat texturu
     * @param shape - panorama, ktora ma odkaz na texturu
     * @param path - root cesty k obrazku
     * @return - ak prebehne uspesne, vrati TRUE, inak FALSE
     */
    public static boolean loadTexture(Appearance ap, Shape shape, String path) {
        BufferedImage img = null;
        try {
            URL loadUrl = new URL(path + "" + shape.getTexture());
            URLConnection con = loadUrl.openConnection();
            //                        BufferedReader in = new BufferedReader(
            //                                new InputStreamReader(
            //                                con.getInputStream()));
            img = ImageIO.read(con.getInputStream());
        } catch (java.net.ConnectException ex) {
            Logger.getLogger(Helper.class.getName()).log(Level.WARNING,
                    "Chyba pri nahravani suboru, skusam znova.");
            return loadTexture(ap,shape,path);
        } catch (Exception e) {
            Logger.getLogger(Helper.class.getName()).log(Level.SEVERE,
                    "Chyba pri nahravani suboru: ", e);
        } finally {
            TextureLoader tex = new TextureLoader(img);
            ap.setTexture(tex.getTexture());
            return true;
        }
    }

    /**
     * Nacitanie sceny z .wrl suboru
     * @param location - umiestnenie suboru
     * @return vrati Scene objekt
     */
    public static Scene loadVRMLScene(String location) {
        Scene scene = null;
        VrmlLoader loader = new VrmlLoader();
        try {
            URL loadUrl = new URL(location);
            URLConnection con = loadUrl.openConnection();
            BufferedReader in = new BufferedReader(
                    new InputStreamReader(
                    con.getInputStream()));
            loader.setBaseUrl(loadUrl);
            scene = loader.load(in);
            in.close();
            return scene;
        } catch (Exception e) {
            Logger.getLogger(Helper.class.getName()).log(Level.SEVERE,
                    "Chyba pri nahravani suboru: ", e);
        }
        return null;
    }
}
