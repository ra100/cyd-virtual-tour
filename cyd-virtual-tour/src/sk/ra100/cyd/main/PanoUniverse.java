/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package sk.ra100.cyd.main;

import sk.ra100.cyd.scene.PanoScene;
import java.awt.BorderLayout;
import java.awt.Dimension;

import java.awt.event.MouseListener;

import javax.media.j3d.Background;
import javax.media.j3d.BoundingSphere;
import javax.media.j3d.Bounds;
import javax.media.j3d.BranchGroup;
import javax.media.j3d.Canvas3D;
import javax.media.j3d.DirectionalLight;
import javax.media.j3d.GraphicsConfigTemplate3D;
import javax.media.j3d.Locale;
import javax.media.j3d.PhysicalBody;
import javax.media.j3d.PhysicalEnvironment;
import javax.media.j3d.PickInfo;
import javax.media.j3d.Transform3D;
import javax.media.j3d.TransformGroup;
import javax.media.j3d.View;
import javax.media.j3d.ViewPlatform;
import javax.media.j3d.VirtualUniverse;

import javax.swing.JPanel;

import javax.vecmath.Point3d;
import javax.vecmath.Vector3d;

import com.sun.j3d.utils.pickfast.PickCanvas;

// FXCanvas3D API 3.0, see http://www.interactivemesh.org/testspace/j3dmeetsjfx.html
import com.interactivemesh.j3d.community.gui.FXCanvas3DRepainter;
import com.interactivemesh.j3d.community.gui.FXCanvas3DSB;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Observable;
import javafx.async.RunnableFuture;
import javax.media.j3d.Shape3D;

import sk.ra100.cyd.navigation.*;
import sk.ra100.cyd.scene.Helper;
import sk.ra100.cyd.scene.PanoExtension;
import sk.ra100.cyd.scene.Shape;

/**
 *
 * @author ra100
 */
public class PanoUniverse extends Observable implements RunnableFuture {

    static {
        System.out.println("\nRa100 : PanoUniverse\n");
    }
    private BoundingSphere globalBounds = null;
    private View view = null;
    private Locale locale = null;
    private WalkBehavior walkBeh = null;
    private PickCanvas pickCanvas = null;
    private BranchGroup sceneBranch = null;
    private BranchGroup viewBranch = null;
    private BranchGroup enviBranch = null;
    private ArrayList<Shape> shapes = null;
    private ArrayList<Shape3D> centers = null;
    private int loaded = 0;
    private PanoExtension extension = null;
    private String trace = "pano01";
    private long lastTime = 0;
    private boolean extras = false;
    private boolean iscenter = false;

    PanoUniverse() {
        // Transparent 3D scene background
//        System.setProperty("j3d.transparentOffScreen", "true");
    }

    // JavaFX Interface RunnableFuture
    @Override
    public void run() {
        initUniverse();
    }

    // Creates and returns the lightweight 3D canvas
    FXCanvas3DSB createFXCanvas3D(FXCanvas3DRepainter repainter, JPanel parent,
            boolean fullscreen) {

        FXCanvas3DSB fxCanvas3D = null;

        try {
            GraphicsConfigTemplate3D gCT = new GraphicsConfigTemplate3D();

            fxCanvas3D = new FXCanvas3DSB(gCT);
            fxCanvas3D.setRepainter(repainter);
        } catch (Exception e) {
            System.out.println("PanoUniverse: FXCanvas3D failed !!");
            e.printStackTrace();
            System.exit(0);
        }

        // Transparent component background
        parent.setOpaque(true);
        fxCanvas3D.setOpaque(true);

        // Due to Java 3D's implementation of off-screen rendering:
        // 1. Set size
        // 2. Provide a parent
        // 3. Get the heavyweight off-screen Canvas3D and add this to the view object

        // 1. Size
        Dimension dim = parent.getSize();
        if (dim.width < 1 || dim.height < 1) {
            dim.width = 100;
            dim.height = 100;
            parent.setSize(dim);
        }
        parent.setPreferredSize(dim);
        fxCanvas3D.setPreferredSize(dim);
        fxCanvas3D.setSize(dim);

        // 2. Parent
        // BorderLayout
        parent.setLayout(new BorderLayout());
        parent.add(fxCanvas3D, BorderLayout.CENTER);

        // 3. Heavyweight off-screen Canvas3D of the lightweight FXCanvas3D
        Canvas3D offCanvas3D = fxCanvas3D.getOffscreenCanvas3D();
        if (offCanvas3D != null) {
            // View renders into the off-screen Canvas3D
            view.addCanvas3D(offCanvas3D);

            // PickCanvas operates on the not visible off-screen Canvas3D
            pickCanvas = new PickCanvas(offCanvas3D, sceneBranch);
            pickCanvas.setMode(PickInfo.PICK_GEOMETRY);
            pickCanvas.setFlags(PickInfo.NODE);
            pickCanvas.setTolerance(4.0f);
        } else {
            System.out.println("PanoUniverse: Off-screen Canvas3D = null !!");
            System.exit(0);
        }

        // MouseAdapter for picking
        MouseListener mouseAdapter = new MousePickListener(this);

        NavigationKeyListener keyListener = new NavigationKeyListener(walkBeh);

        fxCanvas3D.addMouseListener(mouseAdapter);
        fxCanvas3D.addKeyListener(keyListener);

        // Navigator
        setupNavigator(fxCanvas3D, fullscreen);

        return fxCanvas3D;
    }

    void closeUniverse() {
        view.removeAllCanvas3Ds();
        view.attachViewPlatform(null);
        locale.getVirtualUniverse().removeAllLocales();
    }

    //
    // Create universe
    //
    private void initUniverse() {
            setLoaded(0);
        createUniverse();
            setLoaded(23);
        createScene();
            setLoaded(87);
        setLive();
            setLoaded(100);
        lastTime = System.currentTimeMillis()/1000;
    }

    // Setup navigation
    private void setupNavigator(JPanel component, boolean fullscreen) {

        walkBeh.setAWTComponent(component);
        walkBeh.setParent(this);

        if (!fullscreen) {
            walkBeh.setTranslateEnable(false);
        }

        double sceneRadius = 1.0f;

        Bounds bounds = sceneBranch.getBounds();
        BoundingSphere sphereBounds = null;

        if (bounds.isEmpty()) {
            sphereBounds = new BoundingSphere();
        } else {
            if (bounds instanceof BoundingSphere) {
                sphereBounds = (BoundingSphere) bounds;
            } else {
                sphereBounds = new BoundingSphere(bounds);
            }
        }

//        sceneRadius = sphereBounds.getRadius();

        walkBeh.setTransFactors(sceneRadius / 0.1f, sceneRadius / 0.1f);
        walkBeh.setZoomFactor(sceneRadius / 0.1f);
        walkBeh.setRotFactors(0.3f, 0.3f);

        walkBeh.setFieldOfView(1.5d);

//        orbitBehInterim.setPureParallelEnabled(true);
//        orbitBehInterim.setProportionalZoom(true);

        walkBeh.setClippingBounds(sphereBounds);

        walkBeh.goHome();
    }

    private void createScene() {
        PanoScene ps = new PanoScene();
        setLoaded(73);
        sceneBranch.addChild(ps.getScene());
        shapes = ps.getSceneXml().getShapes();
        centers = ps.getSceneXml().getCenters();
        walkBeh.setShapes(shapes);
    }

    // Set live
    private void setLive() {
        sceneBranch.compile();
        locale.addBranchGraph(sceneBranch);
        locale.addBranchGraph(viewBranch);
        locale.addBranchGraph(enviBranch);
    }

    // Base world
    private void createUniverse() {

        // Bounds
        globalBounds = new BoundingSphere();
        globalBounds.setRadius(Double.MAX_VALUE);

        //
        // Viewing
        //
        view = new View();
        view.setPhysicalBody(new PhysicalBody());
        view.setPhysicalEnvironment(new PhysicalEnvironment());

        //
        // SuperStructure
        //
        VirtualUniverse vu = new VirtualUniverse();
        locale = new Locale(vu);

        //
        // BranchGraphs
        //
        sceneBranch = new BranchGroup();
        viewBranch = new BranchGroup();
        enviBranch = new BranchGroup();

        // ViewBranch

        TransformGroup viewTG = new TransformGroup();
        viewTG.setCapability(TransformGroup.ALLOW_TRANSFORM_WRITE);

        ViewPlatform vp = new ViewPlatform();
        view.attachViewPlatform(vp);

        walkBeh = new WalkBehavior(OrbitBehaviorInterim.DISABLE_ZOOM);
        walkBeh.setViewingTransformGroup(viewTG);
        walkBeh.setVpView(view);
        walkBeh.setSchedulingBounds(globalBounds);
        walkBeh.setClippingEnabled(true);

        Transform3D homeTransform = new Transform3D();
        homeTransform.setTranslation(new Vector3d(0.0, 0.0, 0.0));
        walkBeh.setHomeTransform(homeTransform);
        walkBeh.setHomeRotationCenter(new Point3d(0.0, 0.0, 0.0));

        DirectionalLight headLight = new DirectionalLight();
        headLight.setInfluencingBounds(globalBounds);

        viewTG.addChild(vp);
        viewTG.addChild(walkBeh);
//        viewTG.addChild(headLight);

        viewBranch.addChild(viewTG);

        // EnviBranch

        Background bg = new Background();
        bg.setApplicationBounds(globalBounds);

        enviBranch.addChild(bg);
    }

    public void showCenters() {
        setCentersTransparency(0.5f);
        walkBeh.getActualShape().setTransparency(0.8f);
        iscenter = true;
    }

    public void hideCenters() {
        setCentersTransparency(1.0f);
        walkBeh.getActualShape().setTransparency(0.0f);
        iscenter = false;
    }

    public void hideCentersNo() {
        setCentersTransparency(1.0f);
        walkBeh.getActualShape().setTransparency(0.0f);
    }

    protected void setCentersTransparency(float trans) {
        Iterator<Shape3D> it = centers.iterator();
        while (it.hasNext()) {
            Shape3D sp = it.next();
            Helper.setTransparency(sp.getAppearance(), trans);
            if (trans >= 1.0f) {
                sp.setPickable(false);
            } else {
                if (!sp.equals(walkBeh.getActualShape().getCenter())) {
                    sp.setPickable(true);
                } else {
                    Helper.setTransparency(sp.getAppearance(), 1.0f);
                }
            }
        }
    }

    public void showExtras() {
        if (!extras) {
            setExtraTransparency(0.8f);
            extras = true;
        }
    }

    protected void hideExtras() {
        if (extras) {
            setExtraTransparency(1.0f);
            extras = false;
        }
    }

    private void setExtraTransparency(float trans) {
        ArrayList<PanoExtension> pe = walkBeh.getActualShape().getExtended();
        Iterator<PanoExtension> it = pe.iterator();
        while (it.hasNext()) {
            PanoExtension pee = it.next();
            if (pee!=null) pee.setTransparency(trans);
        }
    }

    public ArrayList<Shape3D> getCenters() {
        return centers;
    }

    public void setCenters(ArrayList<Shape3D> centers) {
        this.centers = centers;
    }

    public PickCanvas getPickCanvas() {
        return pickCanvas;
    }

    public void setPickCanvas(PickCanvas pickCanvas) {
        this.pickCanvas = pickCanvas;
    }

    public ArrayList<Shape> getShapes() {
        return shapes;
    }

    public void setShapes(ArrayList<Shape> shapes) {
        this.shapes = shapes;
    }

    private void startNotification() {
        setChanged();
        notifyObservers();
    }

    public int getLoaded() {
        return loaded;
    }

    public void setLoaded(int loaded) {
        this.loaded = loaded;
        startNotification();
    }

    public WalkBehavior getWalkBeh() {
        return walkBeh;
    }

    public PanoExtension getExtension() {
        return extension;
    }

    public void setExtension(PanoExtension extension) {
        this.extension = extension;
        startNotification();
    }

    public void setExtensionNo(PanoExtension extension) {
        this.extension = extension;
    }

    public void addTrace(String name) {
        long oldTime = lastTime;
        lastTime = System.currentTimeMillis()/1000;
        String time = Long.toString(lastTime - oldTime);
        trace = trace+"-"+time+","+name;
    }

    public String getTrace(){
        return trace;
    }

    public boolean isExtras(){
        return extras;
    }
    
    public void setExtras(boolean ex) {
        extras = ex;
    }

    public boolean isIscenter() {
        return iscenter;
    }

    public void setIscenter(boolean iscenter) {
        this.iscenter = iscenter;
    }



}
