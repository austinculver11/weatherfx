/*
 * ForecastNode.fx
 *
 * Created on Feb 21, 2010, 4:46:08 PM
 */
package weatherfx;

import javafx.scene.CustomNode;
import javafx.scene.Node;
import javafx.scene.Group;
import javafx.scene.layout.VBox;
import javafx.scene.shape.Rectangle;
import javafx.scene.paint.Color;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.text.Font;
import weatherfx.GoogleWeatherData.Forecast;

/**
 * @author santosh
 */
public class ForecastNode extends CustomNode {

    public-init var forecast: Forecast;
    var imgV: ImageView;

    override function create(): Node {
        Group {
            content: [
                VBox {
                    height: 100;
                    spacing: 5
                    content: [
                        Group {
                            content: [
                                Rectangle {
                                    width: bind imgV.fitWidth;
                                    height: 15
                                    arcWidth: 20 arcHeight: 20
                                    fill: Color.BLUEVIOLET
                                },
                                Group {
                                    layoutX: 5
                                    //layoutY:5
                                    content: [
                                        Label {
                                            text: "High:{forecast.high_temp}"
                                        }
                                    ]
                                }
                            ]
                        },
                        Group {
                            content: [
                                Rectangle {
                                    width:bind imgV.fitWidth;
                                    height: 15
                                    arcWidth: 20 arcHeight: 20
                                    fill: Color.BLUEVIOLET
                                },
                                Group {
                                    layoutX: 5
                                    //layoutY:5
                                    content: [
                                        Label {
                                            text: "Low:{forecast.low_temp}"
                                        }
                                    ]
                                }
                            ]
                        },
                        Group {
                            content: [
                                Rectangle {
                                    //width: 100 height: 100
                                    height: bind imgV.image.height + 20;
                                    width: bind imgV.fitWidth
                                    //arcWidth: 20 arcHeight: 20
                                    fill: Color.BLUE
                                },
                                Label {
                                    height: 20;
                                    width: bind imgV.fitWidth
                                    font: Font { name: "Arial Bold", size: 14 }
                                    text: "{forecast.day_of_week}"
                                },
                                Group {
                                    layoutX:0
                                    layoutY:20
                                    content: [
                                        imgV = ImageView {
                                            fitHeight: 50
                                            fitWidth: 50
                                            image: Image {
                                                url: "http://www.google.com{forecast.icon}"
                                            }
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        };
    }

}
