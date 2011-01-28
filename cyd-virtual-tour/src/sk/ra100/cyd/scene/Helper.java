/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.ra100.cyd.scene;

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

    public static void setTransparency(Appearance ap, float trans) {
        TransparencyAttributes ta =
                new TransparencyAttributes(TransparencyAttributes.SCREEN_DOOR, trans);
//        ta.setCapability(TransparencyAttributes.FASTEST);
//        ta.setTransparency(trans);
        ap.setTransparencyAttributes(ta);
    }

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
        } finally {
            TextureLoader tex = new TextureLoader(img);
            ap.setTexture(tex.getTexture());
            return true;
        }
    }

    public static BufferedImage loadBack() {
        BufferedImage img = null;
        try {
            URL loadUrl = new URL("http://ra100.scifi-guide.net/brhlovce/files/resources/back.png");
            URLConnection con = loadUrl.openConnection();
            //                        BufferedReader in = new BufferedReader(
            //                                new InputStreamReader(
            //                                con.getInputStream()));
            img = ImageIO.read(con.getInputStream());
        } catch (Exception e) {
            Logger.getLogger(Helper.class.getName()).log(Level.SEVERE,
                    "Chyba pri nahravani suboru: ", e);
        } finally {
            return img;
        }
    }

//    public static boolean loadTextureBound(Appearance ap) {
//        Image img = null;
//
//        try {
//            img = Toolkit.getDefaultToolkit().createImage(PanoScene.XMLPATH);
//        } catch (Exception e) {
//            Logger.getLogger(Helper.class.getName()).log(Level.SEVERE,
//                    "Chyba pri nahravani suboru: ", e);
//        } finally {
//            TextureLoader tex = new TextureLoader((BufferedImage) img);
//            ap.setTexture(tex.getTexture());
//            return true;
//        }
//    }
    
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
