/*
 * TopPanel.fx
 *
 * Created on 1.4.2010, 8:35:26
 */
package net.ra100.cyd.UI;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.animation.transition.TranslateTransition;
import javafx.scene.effect.Glow;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import net.ra100.cyd.main.PanoScene;
import javafx.geometry.VPos;
import net.ra100.cyd.UI.res.TopMenuBG;
import javafx.scene.layout.Stack;
import net.ra100.cyd.UI.res.*;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image;
import javafx.ext.swing.SwingLabel;

/**
 * @author ra100
 */
public class TopPanel extends CustomNode {

    public var myScene: PanoScene;
    public var width: Integer;
    public var hideHeight: Integer = 48;
    var active: Boolean = true;
    var label = SwingLabel {text: " "
    style: "font-family: 'Helvetica'; font-size: 12pt"};

    var naviButton = RSwitch {
        primary : RButton {
            image: HideNavButton { };
            text: ##"ShowNavButton"
            label : label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                showMap();
            }
        };
        secondary :  RButton {
            image: ShowNavButton { };
            text: ##"HideNavButton"
            label : label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                hideMap();
            }
            visible : false;
        };
    }

    var extrasButton = RSwitch {
        primary : RButton {
            image: HideExtButton { };
            text: ##"ShowExtrasButton"
            label : label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                showExtras();
            }
        };
        secondary :  RButton {
            image: ShowExtButton { };
            text: ##"HideExtrasButton"
            label : label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                hideExtras();
            }
            visible : false;
        }
    }

    var hideButton = RSwitch {
            translateX: 24
            translateY: 50
        primary: RButton {
            image: HideButton { };
            text: ##"Hide Panel"
            label : label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
               hide();
            }
        }
        secondary: RButton {
            image: ShowButton { };
            text: ##"Show Panel"
            label : label
            visible: false
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                show();
            }
        }
    }

    var helpButton = RButton {
            translateX : 16
            text: ##"Help Button"
            label: label
            image: HelpButton { }
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
               myScene.extensionDisplay.textName = "help";
               myScene.extensionDisplay.setText();
               myScene.extensionDisplay.visible = true;
            }
        };

    var langButton = RSwitch {
            translateX : 16
        primary : RButton {
            image: ImageView {
                image: Image {
                        url: "{__DIR__}res/LangButtonSk.png"
                }
            }
            text: ##"English"
            label : label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                myScene.changeLanguage(myScene.EN);
                updateLang();
            }
        };
        secondary :  RButton {
            image: ImageView {
                image: Image {
                        url: "{__DIR__}res/LangButtonEn.png"
                }
            }
            text: ##"Slovak"
            label : label
            overEffect: Glow {
                level: 1
            }
            action: function (): Void {
                myScene.changeLanguage(myScene.SK);
                updateLang();
            }
            visible : false;
        }
    }

    def bg = TopMenuBG{};

    public override function create(): Node {
        return Stack {
                nodeVPos: VPos.TOP,
            content: [
        bg,
        VBox {
                spacing : 2
            content: [
                HBox {
                    spacing : 4
                    content: [
                        naviButton,
                        extrasButton,
                        langButton,
                        helpButton
                    ]
                }
                label,
            ]
        }
        hideButton
        ]
        }
    }

    public function show() {
        active = true;
        TranslateTransition {
            duration: 0.5s
            node: this
            fromY: 0 - hideHeight
            toY: 0
            repeatCount: 1
        }.play();
    }

    public function hide() {
        active = false;
        TranslateTransition {
            duration: 0.5s
            node: this
            fromY: 0
            toY: 0 - hideHeight
            repeatCount: 1
        }.play();
    }

    public function changeState() {
        if (active) {
            hide();
        } else {
            show();
        }
    }

    public function updateLang(){
        naviButton.primary.text = ##"ShowNavButton";
        naviButton.secondary.text = ##"HideNavButton";
        extrasButton.primary.text = ##"ShowExtrasButton";
        extrasButton.secondary.text = ##"HideExtrasButton";
        hideButton.primary.text = ##"Hide Panel";
        hideButton.secondary.text = ##"Show Panel";
        helpButton.text = ##"Help Button";
    }

    function showMap() {
        myScene.showCenters();
    }

    function hideMap() {
        myScene.hideCenters();
    }

    function showExtras() {
        myScene.showExtras();
    }

    function hideExtras() {
        myScene.hideExtras;
    }

}
