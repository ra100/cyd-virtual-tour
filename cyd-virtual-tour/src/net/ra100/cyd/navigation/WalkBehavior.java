package net.ra100.cyd.navigation;

import java.awt.event.MouseEvent;
import java.util.ArrayList;
import java.util.Iterator;
import javax.media.j3d.Bounds;
import javax.media.j3d.Transform3D;
import javax.media.j3d.View;
import javax.vecmath.Point3d;
import javax.vecmath.Vector3d;
import net.ra100.cyd.main.PanoUniverse;
import net.ra100.cyd.scene.PanoExtension;
import net.ra100.cyd.scene.Shape;

/**
 *
 * @author ra100
 */
public class WalkBehavior extends OrbitBehaviorInterim {

    /**
     * zoznam panoram
     */
    private ArrayList<Shape> shapes = null;

    /**
     * aktualna panorama
     */
    private Shape actualShape = null;

    /**
     * odkaz na PanoUniverse, z ktoreho sa tato trieda vola
     */
    private PanoUniverse parent = null;

    /**
     * pomocne premenne, aby sa dalo k nim pristupovat z vlakna
     */
    private Shape pom = null;
    private Transform3D t3 = null;
    private Point3d newPos = null;
    /**
     * Constructs a OrbitBehaviorInterim with a null source of Component,
     * null targets of TransformGroup and View, and specified constructor flags.
     *
     * @param flags The option flags
     */
    public WalkBehavior(int flags) {
        super(MOUSE_LISTENER | MOUSE_MOTION_LISTENER | MOUSE_WHEEL_LISTENER | flags);

        // since 1.1
        updateFlags(flags);
    }

    /**
     * posun kamery v smeroch x,y,z
     * @param x
     * @param y
     * @param z
     * @return
     */
    public boolean moveCamera(double x, double y, double z){

        Transform3D tpom = new Transform3D();
        t3 = new Transform3D();
        getViewingTransform(t3);
        Vector3d vec = new Vector3d();

        vec.x=x;
        vec.y=y;
        vec.z=z;

        tpom.setTranslation(vec);
        t3.mul(tpom);
        vec = new Vector3d();
        t3.get(vec);

        newPos = new Point3d(vec.x, vec.y, vec.z);

        if (isInBounds(newPos, actualShape)) {
            setViewingTransform(t3);
            setRotationCenter(newPos);
            return true;
        } else {
            Iterator<Shape> it = actualShape.getConnection().iterator();
            while(it.hasNext()) {
                pom = it.next();  
                if (isInBounds(newPos, pom)) {
                    new Thread(new Runnable() {
                        @Override
                        public void run() {
                            parent.setUpdateMap(true);
                            parent.setShape(pom);
                            parent.setLoaded(-1);
                            hideExtras();
                            actualShape.setVisible(false);
                            actualShape = pom;
                            actualShape.setTextureLoaded(true);
                            actualShape.setVisible(true);
                            if (parent.isExtras()) {
                                showExtras();
                            }
                            setViewingTransform(t3);
                            setRotationCenter(newPos);
                            parent.setLoaded(100);
                        }
                    }).start();
                    return true;
                }
            }
            return false;
        }
    }

    /**
     *
     * @param vec vektor kamery, pohlad
     * @param newAct panorama, do ktorej sa ma presunut
     * @return
     */
    public boolean moveCamera(Vector3d vec, Shape newAct){

        t3 = new Transform3D();
        getViewingTransform(t3);

        t3.setTranslation(vec);
        vec = new Vector3d();
        t3.get(vec);

        newPos = new Point3d(vec.x, vec.y, vec.z);
        
        hideExtras();
        if (actualShape != null) {
            actualShape.setVisible(false);
            actualShape = newAct;
            actualShape.setTextureLoaded(true);
            actualShape.setVisible(true);
        }
        if ((parent.isExtras())) {
            showExtras();
        }
        setViewingTransform(t3);
        setRotationCenter(newPos);
        return true;
    }

    @Override
    /**
     * spracovanie udalosti z mysi
     */
    void processMouseEvent( final MouseEvent evt ) {

        if (evt.getID()==MouseEvent.MOUSE_PRESSED) {
            mouseX = evt.getX();
            mouseY = evt.getY();
            motion=true;
        }
        else if (evt.getID()==MouseEvent.MOUSE_DRAGGED) {
            int xchange = evt.getX() - mouseX;
            int ychange = evt.getY() - mouseY;
            // rotate
            if (rotate(evt)) {
            	if (reverseRotate) {
            		longditude -= xchange * rotXMul;
            		latitude -= ychange * rotYMul;
            	}
            	else {
            		longditude += xchange * rotXMul;
            		latitude += ychange * rotYMul;
            	}
                //proti pretoceniu
                if (latitude > Math.PI/2f) latitude = Math.PI/2f;
                if (latitude < -Math.PI/2f) latitude = -Math.PI/2f;
            }
            
            // translate
            else if (translate(evt)) {
            	if (reverseTrans) {
            		xtrans -= xchange * transXMul;
            		ytrans += ychange * transYMul;
            	}
            	else {
            		xtrans += xchange * transXMul;
            		ytrans -= ychange * transYMul;
            	}
            }
            // zoom
            else if (zoom(evt)) {
            	doZoomOperations( ychange );
            }
            mouseX = evt.getX();
            mouseY = evt.getY();
            motion = true;
        }
        else if (evt.getID()==MouseEvent.MOUSE_RELEASED ) {
        }
        else if (evt.getID()==MouseEvent.MOUSE_WHEEL ) {
        	if (zoom(evt)) {
        		// if zooming is done through mouse wheel,
        		// the amount of increments the wheel changed,
        		// multiplied with wheelZoomFactor is used,
        		// so that zooming speed looks natural compared to mouse movement zoom.
        		if ( evt instanceof java.awt.event.MouseWheelEvent){
        			// I/O differenciation is made between
        			// java.awt.event.MouseWheelEvent.WHEEL_UNIT_SCROLL or
        			// java.awt.event.MouseWheelEvent.WHEEL_BLOCK_SCROLL so
        			// that behavior remains stable and not dependent on OS settings.
        			// If getWheelRotation() was used for calculating the zoom,
        			// the zooming speed could act differently on different platforms,
        			// if, for example, the user sets his mouse wheel to jump 10 lines
        			// or a block.
        			int zoom = ((int)(((java.awt.event.MouseWheelEvent)evt).getWheelRotation() * wheelZoomFactor));
        			doZoomOperations( zoom );
        			motion = true;
        		}
        	}
        }
   }

    /**
     * aktualizacia transformacii po posunuti
     */
    @Override
    protected synchronized void integrateTransforms() {
    	// No longer: Check if the transform has been changed by another behavior
    	//targetTG.getTransform(currentXfm) ;
    	//if (! targetTransform.equals(currentXfm))
    	//	resetView() ;
//    	longditudeTransform.rotY( longditude );
//    	latitudeTransform.rotX( latitude );

        rotateTransform.setEuler(new Vector3d(latitude, longditude, 0));
//    	rotateTransform.mul(rotateTransform, latitudeTransform);
//    	rotateTransform.mul(rotateTransform, longditudeTransform);

    	// Change of distance since last resetView
    	// distanceFromCenter = startDistanceFromCenter; +/-= ychange*zoomMul
    	distanceVector.z = distanceFromCenter - startDistanceFromCenter;

    	temp1.set(distanceVector);
    	temp1.mul(rotateTransform, temp1);

    	// want to look at rotationCenter
    	transVector.x = rotationCenter.x + xtrans; // xtrans = centerToView.x; +/-= xchange * transXMul
    	transVector.y = rotationCenter.y + ytrans; // ytrans = centerToView.y; +/-= zchange * transYMul;
    	transVector.z = rotationCenter.z + ztrans; // ztrans = centerToView.z; fix while dragging

    	translation.set(transVector);
    	targetTransform.mul(temp1, translation);

    	// handle rotationCenter
    	temp1.set(centerVector);
    	temp1.mul(targetTransform);

    	invertCenterVector.x = -centerVector.x;
    	invertCenterVector.y = -centerVector.y;
    	invertCenterVector.z = -centerVector.z;

    	temp2.set(invertCenterVector);
    	targetTransform.mul(temp1, temp2);

		// Version 2.0
    	//
		// perspective width: tanFoVHalf
		// default screen scale: physicalScreenWidth/2
		// parallel scale factor: perspective width / default screen scale
		// --> parallelScaleFactor = tanFoVHalf * 2.0 / physicalScreenWidth;
    	//
    	// scale in inversely proportion to distance 'Viewplatform <-> RotationCenter'
    	// --> screenScale = 1 / (distanceFromCenter * parallelScaleFactor)

		if (projection == View.PARALLEL_PROJECTION) {

			if (isPureParallelProjection) {
				parallelScale = distanceFromCenter * parallelScaleFactor * parallelScalePure;
			}
			else {
				parallelScale = distanceFromCenter * parallelScaleFactor;
			}

			if (parallelScale > 0) {
				view.setScreenScale(1/parallelScale);
			}
		}

    	targetTG.setTransform(targetTransform);

    	// Version 2.0
    	if (isClippingUpdate)
    		setClippingDistances();

    	// reset yaw and pitch angles
//    	longditude = 0.0;
//        latitude = 0.0;
    }

    /**
     * getter
     * @return
     */
    public ArrayList<Shape> getShapes() {
        return shapes;
    }

    /**
     * nastavenie zoznamu shapes
     * @param shapes
     */
    public void setShapes(ArrayList<Shape> shapes) {
        this.shapes = shapes;
        for (int i = 0; i < shapes.size(); i++){
            /* TODO upravit, mozno odstranit */
            if (shapes.get(i).getTitle().matches("01")) {
                actualShape = shapes.get(i);
                break;
            }
        }
    }

    /**
     * zisti ci sa po pohybe bude kamera nachadzat v hraniciach panoramy
     * @param newPos
     * @param shape
     * @return
     */
    private boolean isInBounds(Point3d newPos, Shape shape){
        Iterator<Bounds> it = shape.getBound().iterator();
        while (it.hasNext()) {
            if (it.next().intersect(newPos)) return true;
        }
        return false;
    }

    /**
     * getter
     * @return
     */
    public Shape getActualShape() {
        return actualShape;
    }

    /**
     * setter
     * @param actualShape
     */
    public void setActualShape(Shape actualShape) {
        this.actualShape = actualShape;
    }

    /**
     * skrytie rozsireni
     */
    private void hideExtras(){
        ArrayList<PanoExtension> pe = getActualShape().getExtended();
        Iterator<PanoExtension> it = pe.iterator();
        while (it.hasNext()) {
            it.next().setTransparency(1.0f);
        }
    }

    /**
     * zobrazenie rozsireni
     */
    private void showExtras(){
        ArrayList<PanoExtension> pe = getActualShape().getExtended();
        Iterator<PanoExtension> it = pe.iterator();
        while (it.hasNext()) {
            it.next().setTransparency(0.0f);
        }
    }

    /**
     * nastavanie rodica
     * @param parent
     */
    public void setParent(PanoUniverse parent) {
        this.parent = parent;
    }

    /**
     * vrati poziciu kamery
     * @return
     */
    public Point3d getCenter() {
        Point3d center = new Point3d();
        this.getRotationCenter(center);
        return center;
    }

    /**
     * vrati sirku
     * @return
     */
    public double getLongitude() {
        return longditude;
    }

    /**
     * inicializacia smeru pohladu
     */
    public void initDirection(double longd, double lat){
        this.longditude = longd;
        this.latitude = lat;
    }

}
