package net.ra100.cyd.scene;

import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.media.j3d.Shape3D;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

/**
 * objek na nacitanie XML popisu sceny
 * @author ra100
 */
public class SceneXML {

    /**
     * staticke texty na identifikaciu, parsovanie z xml
     */
    public final static String PANORAMA = "panorama";
    public final static String PATH = "path";
    public final static String SHAPE = "shape";
    public final static String TEXTURE = "texture";
    public final static String NAME = "name";
    public final static String TITLE = "title";
    public final static String MAINPATH = "mainpath";
    public final static String BOUNDS = "bounds";
    public final static String CONNECTION = "connection";
    public final static String CENTER = "center";
    public final static String EXTENDED = "extended";
    public final static String TYPE = "type";
    public final static String IMAGE = "image";
    public final static String GUESTBOOK = "guestbook";
    public final static String TEXT = "text";
    public final static String URL = "url";

    /**
     * cety k texturam
     */
    private ArrayList<String> paths = null;

    /**
     * jednotlive panoramy
     */
    private ArrayList<Shape> shapes = null;

    /**
     * stredy panoram
     */
    private ArrayList<Shape3D> centers = null;

    /**
     * base path
     */
    private String path = null;

    /**
     * constructor
     */
    public SceneXML() {
        Logger.getLogger(SceneXML.class.getName()).log(Level.INFO, "Loading XML.");
        paths = new ArrayList<String>();
        shapes = new ArrayList<Shape>();
    }

    /**
     * nacitanie popisneho XML suboru z adresy (vo vnutri balicka)
     * @param _path - cesta k suboru
     */
    public void load(String _path) {
        Document document = getDocument(_path);
//        String xPath = "//";

//        List<Node> nodes = document.selectNodes(xPath);
        Element root = document.getRootElement();

        Iterator<Element> it = root.elementIterator();
        while (it.hasNext()) {
            nodeResolve(it.next());
        }
    }

    /**
     * nacitavanie XML suboru a  vytvaranie prislusnych objektov
     * @param node uzol dokumentu
     */
    private void nodeResolve(Element node) {

        if (node.getName().matches(PANORAMA)) {
            paths.add(node.element(PATH).getText());
            Iterator<Element> it = node.elementIterator();
            while (it.hasNext()) {
                nodeResolve(it.next());
            }
        } else if (node.getName().matches(SHAPE)){
            Shape s = new Shape();
            s.setName(node.element(NAME).getText());
            s.setTexture(node.element(TEXTURE).getText());
            s.setTitle(node.element(TITLE).getText());
            s.setCenterName(node.element(CENTER).getText());

            Iterator<Element> bounds = node.elements(BOUNDS).iterator();
            while (bounds.hasNext()){
                s.addBoundName(bounds.next().getText());
            }

            Iterator<Element> connections = node.elements(CONNECTION).iterator();
            while (connections.hasNext()){
                s.addConnectionName(connections.next().getText());
            }

            Iterator<Element> extensions = node.elements(EXTENDED).iterator();
            while (extensions.hasNext()){
                Element el = extensions.next();
                String type = el.attributeValue(TYPE);
                PanoExtension pe = new PanoExtension();
                pe.setName(el.getText());
                if (type != null) {
                    if (type.matches(IMAGE)){
                        pe.setType(PanoExtension.IMAGE);
                        pe.setUrl(el.attributeValue(URL));
                    } else if (type.matches(TEXT)){
                        pe.setType(PanoExtension.TEXT);
                    } else if (type.matches(GUESTBOOK)){
                        pe.setType(PanoExtension.GUESTBOOK);
                    }
                }
                s.addExtended(pe);
            }

            shapes.add(s);
            Logger.getLogger(SceneXML.class.getName()).log(Level.INFO, "{0} {1} {2}", 
                    new Object[]{s.getTitle(), s.getName(), s.getTexture()});
        } else if (node.getName().matches(MAINPATH)){
            path = node.getText();
            Shape.path = path;
        }
    }

    /**
     * This method is used to load the xml file to a document and return it
     *
     * @param xmlFileName is the xml file name to be loaded
     * @return Document
     */
    public Document getDocument(String xmlFileName) {
        URL url = this.getClass().getResource(xmlFileName);

        Document document = null;
        SAXReader reader = new SAXReader();
        try {
            document = reader.read(url);
        } catch (DocumentException e) {
            Logger.getLogger(SceneXML.class.getName()).log(Level.INFO, e.toString());
        }
        return document;
    }

    /**
     * getter
     * @return ArrayList<String>
     */
    public ArrayList<String> getPaths() {
        return paths;
    }

    /**
     * setter
     * @param paths
     */
    public void setPaths(ArrayList<String> paths) {
        this.paths = paths;
    }

    /**
     * getter
     * @return ArrayList<Shape>
     */
    public ArrayList<Shape> getShapes() {
        return shapes;
    }

    /**
     * setter
     * @param shapes
     */
    public void setShapes(ArrayList<Shape> shapes) {
        this.shapes = shapes;
    }

    /**
     * getter
     * @return
     */
    public String getPath() {
        return path;
    }

    /**
     * setter
     * @param path
     */
    public void setPath(String path) {
        this.path = path;
    }

    /**
     * getter
     * @return
     */
    public ArrayList<Shape3D> getCenters() {
        return centers;
    }

    /**
     * setter
     * @param centers
     */
    public void setCenters(ArrayList<Shape3D> centers) {
        this.centers = centers;
    }
    
}
