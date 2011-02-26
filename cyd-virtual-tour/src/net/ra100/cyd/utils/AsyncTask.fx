/*
 * AsyncTask.fx
 *
 * Created on 21.3.2010, 15:19:27
 */

package net.ra100.cyd.utils;
import javafx.async.Task;

/**
 * http://blog.alutam.com/2009/08/26/custom-asynchronous-tasks-in-javafx/
 * @author Martin Matula
 */
public class AsyncTask extends Task, AsyncTaskHelper.Task {
    /** Function that should be run asynchronously.
     */
    public var run: function() = null;

    // the helper
    def peer = new AsyncTaskHelper(this);

    // used to start the task
    override function start() {
        started = true;
        if (onStart != null) onStart();
        peer.start();
    }

    // don't need stop - isn't implemented
    override function stop() {
        // do nothing
    }

    // called from the helper Java class from a different thread
    override function taskRun() {
        // run the code to be run asynchronously
        if (run != null) run();
        // send a notification (on the dispatch thread) the code finished running
        FX.deferAction(function() {
            done = true;
            if (onDone != null) onDone();
        });
    }
}
