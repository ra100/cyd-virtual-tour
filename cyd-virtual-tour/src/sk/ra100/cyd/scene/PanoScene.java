/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.ra100.cyd.scene;

import java.util.logging.Level;
import java.util.logging.Logger;
import com.sun.j3d.loaders.Scene;
import com.sun.j3d.utils.image.TextureLoader;
import com.sun.j3d.utils.picking.PickTool;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import javax.media.j3d.Appearance;
import javax.media.j3d.BoundingPolytope;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.Group;
import javax.media.j3d.OrderedGroup;
import javax.media.j3d.SceneGraphObject;
import javax.media.j3d.Shape3D;
import javax.media.j3d.Node;
import javax.media.j3d.Texture;
import javax.media.j3d.Transform3D;

/**
 *
 * @author ra100
 */
public class PanoScene {

    /**
     * cesta k XML popisu sceny
     */
    public static final String XMLPATH = "res/scene.xml";
//    public static final String BGPATH = "res/bgmask.png";

    /**
     * zoznam objektov v scene
     */
    private OrderedGroup orderedGroup = null;

    /**
     * Objekt s nacitanym scene.xml
     */
    private SceneXML sceneXml = null;

    /**
     * textura pozadia
     */
    private Texture tex = null;


    /**
     * getter pre sceneXml
     * @return SceneXML
     */
    public SceneXML getSceneXml() {
        return sceneXml;
    }

    /**
     * constructor
     */
    public PanoScene() {
        Logger.getLogger(PanoScene.class.getName()).log(Level.INFO, "Creating PanoScene.");
        try {
            createScene();
        } catch (FileNotFoundException ex) {
            Logger.getLogger(PanoScene.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * getter
     * @return OrderedGroup
     */
    public OrderedGroup getScene() {
        return orderedGroup;
    }

    /**
     * Vytvorenie sceny<br>
     * nacita XML subory popisujuce scenu a vztahy objektov, nacita texturu
     * pre pozadie extension objektov, vytvori graf sceny
     * @throws FileNotFoundException
     */
    private void createScene() throws FileNotFoundException {
//        Loader vrmlLoader = new VrmlLoader();

        sceneXml = new SceneXML();
        sceneXml.load(XMLPATH);
        tex = new TextureLoader(Helper.loadBack(), "RGBA").getTexture();

        orderedGroup = new OrderedGroup();

        BranchGroup sceneRoot;

        Iterator<String> it = sceneXml.getPaths().iterator();
        while (it.hasNext()) {
            sceneRoot = new BranchGroup();
            sceneRoot = loadVrmlFile(sceneXml.getPath() + "" + it.next());
            orderedGroup.addChild(sceneRoot);
        }
        compileShapes(sceneXml.getShapes());
    }

    /**
     * nacitanie VRML suboru
     * @param location
     * @return
     */
    private BranchGroup loadVrmlFile(String location) {
        BranchGroup sceneGroup = null;
        Scene scene = Helper.loadVRMLScene(location);

        if (scene != null) {
            // get the scene group
            sceneGroup = scene.getSceneGroup();

            sceneGroup.setCapability(BranchGroup.ALLOW_BOUNDS_READ);
            sceneGroup.setCapability(BranchGroup.ALLOW_CHILDREN_READ);

            Hashtable namedObjects = scene.getNamedObjects();
            Logger.getLogger(PanoScene.class.getName()).log(Level.INFO,
                    "*** Named Objects in VRML file: \n{0}", namedObjects);

            // recursively set the user data here
            // so we can find our objects when they are picked
            java.util.Enumeration enumValues = namedObjects.elements();
            java.util.Enumeration enumKeys = namedObjects.keys();

            if (enumValues != null) {
                while (enumValues.hasMoreElements() != false) {
                    Object value = enumValues.nextElement();
                    Object key = enumKeys.nextElement();

                    recursiveSetUserData(sceneGroup, value, key);
                }
            }
        }

        return sceneGroup;
    }

    /** method to recursively set the user data for objects in the scenegraph
    * tree
    * we also set the capabilites on Shape3D and Morph objects required by the
    * PickTool
    */
    void recursiveSetUserData(BranchGroup sceneGroup, Object value, Object key) {
        if (value instanceof SceneGraphObject != false) {
            // set the user data for the item
            SceneGraphObject sg = (SceneGraphObject) value;
            sg.setUserData(key);
            sg.setName(key.toString());

            // recursively process group
            if (sg instanceof Group) {
                Group g = (Group) sg;

                // recurse on child nodes
                java.util.Enumeration enumKids = g.getAllChildren();

                while (enumKids.hasMoreElements() != false) {
                    recursiveSetUserData(sceneGroup, enumKids.nextElement(), key);
                }
            } else if (sg instanceof Shape3D) {

                Shape3D sp = (Shape3D) sg;

                sg.setCapability(Node.ALLOW_PICKABLE_WRITE);
                sg.setCapability(Shape3D.ALLOW_APPEARANCE_READ
                        | Shape3D.ALLOW_APPEARANCE_WRITE);

                Appearance ap = sp.getAppearance();
                ap.setCapability(Appearance.ALLOW_TRANSPARENCY_ATTRIBUTES_READ
                        | Appearance.ALLOW_TRANSPARENCY_ATTRIBUTES_WRITE);
                ap.setCapability(Appearance.ALLOW_TEXTURE_READ);
                ap.setCapability(Appearance.ALLOW_TEXTURE_WRITE);
                ap.setCapability(Appearance.ALLOW_TEXTURE_ATTRIBUTES_READ);
                ap.setCapability(Appearance.ALLOW_TEXTURE_ATTRIBUTES_WRITE);
                ap.setCapability(Appearance.ALLOW_TEXGEN_READ);
                ap.setCapability(Appearance.ALLOW_TEXGEN_WRITE);
                Shape shape = Helper.findShape(sceneXml, sp.getName());
                /*
                 * -1 nenaslo sa
                 *  0 je to panorama
                 *  1 bound
                 *  2 extended
                 *  3 center
                 */
                int shapeSwitch = -1;
                Logger.getLogger(PanoScene.class.getName()).log(Level.INFO,
                        "Shape processing: {0}", sp.getUserData());
                if (shape != null) {
                    shapeSwitch = 0;
                } else {
                    shape = Helper.findBoundShape(sceneXml, sp.getName());
                    if (shape != null) {
                        shapeSwitch = 1;
                    } else {
                        shape = Helper.findExtensionShape(sceneXml, sp.getName());
                        if (shape != null) {
                            shapeSwitch = 2;
                        } else {
                            shape = Helper.findCenterShape(sceneXml, sp.getName());
                            if (shape != null) {
                                shapeSwitch = 3;
                            }
                        }
                    }
                }

                switch (shapeSwitch) {
                    case 0:
                        shape.setPano(sp);
                        sp.setPickable(false);
                        shape.setTextureLoaded(false);
                        shape.setVisible(false);
                        break;
                    case 1:
                        Helper.setTransparency(ap, 1.0f);
                        sp.setPickable(false);
                        Transform3D t3 = new Transform3D();
                        sp.getLocalToVworld(t3);
                        BoundingPolytope bpt = new BoundingPolytope();
                        bpt.transform(sp.getBounds(), t3);
                        shape.addBound(bpt);
                        break;
                    case 2:
                        Helper.setTransparency(ap, 1.0f);
                        ap.setTexture(tex);
                        sp.setPickable(false);
                        PanoExtension pe = findExt(shape, sp.getName());
                        pe.setShape(sp);
                        break;
                    case 3:
                        Helper.setTransparency(ap, 1.0f);
                        sp.setPickable(false);
                        shape.setCenter(sp);
                        break;
                    default:
                        Logger.getLogger(PanoScene.class.getName()).log(
                                Level.INFO, "Nerozpoznany objekt.");
                        break;
                }

                Logger.getLogger(PanoScene.class.getName()).log(Level.INFO,
                        "Shape processed: {0}", sp.getUserData());

                PickTool.setCapabilities((Node) sg, PickTool.INTERSECT_FULL);
            }
        }
    }

    /**
     * nastavenie viditelnosti pre prvu panoramu (vychodzi bod), nastavenie
     * susedov pre panoramy
     * @param shapes
     */
    private void compileShapes(ArrayList<Shape> shapes) {
        Iterator<Shape> it = shapes.iterator();
        ArrayList<Shape3D> shp = new ArrayList<Shape3D>();
        while (it.hasNext()) {
            Shape sp = it.next();
            if (sp.getTitle().matches("01")) {
                sp.setVisible(true);
//                sp.getCenter().setPickable(false);
            }
            shp.add(sp.getCenter());
            Iterator<String> cons = sp.getConnectionNames().iterator();
            while (cons.hasNext()) {
                Shape pom = Helper.findShapeByTitle(sceneXml, cons.next());
                if (pom != null) {
                    sp.addConnection(pom);
                }
            }
        }
        sceneXml.setCenters(shp);
    }

    /**
     * najde v ktorej panorame je dany objekt
     * @param sp panorama
     * @param name meno rozsirenia
     * @return rozsirenie
     */
    private PanoExtension findExt(Shape sp, String name) {
        Iterator<PanoExtension> peit = sp.getExtended().iterator();
        while (peit.hasNext()) {
            PanoExtension pe = peit.next();
            if (pe.getName().matches(name)) {
                return pe;
            }
        }
        return null;
    }
}
