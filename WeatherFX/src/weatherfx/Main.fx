/*
 * Main.fx
 *
 * Created on Feb 21, 2010, 2:14:54 PM
 */
package weatherfx;

import javafx.stage.Stage;
import javafx.scene.Scene;
import javafx.scene.text.Text;
import javafx.scene.text.Font;
import javafx.scene.layout.HBox;
import javafx.scene.control.TextBox;
import javafx.scene.control.Button;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.VBox;
import javafx.data.pull.PullParser;
import javafx.io.http.HttpRequest;
import java.io.InputStream;
import java.lang.Exception;
import javafx.scene.paint.Color;
import javafx.scene.Group;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.text.TextAlignment;
import javafx.scene.text.TextOrigin;
import javafx.scene.Node;
import javafx.scene.effect.DropShadow;
import javafx.animation.transition.FadeTransition;

/**
 * @author santosh
 */
var city: String = "Mumbai";
def googleWeatherUrl = "http://www.google.com/ig/api?weather={city}";
var gwd = GoogleWeatherData { };
var bgImage: ImageView = ImageView {
            image: Image {
                url: "{__DIR__}clouds_bg.jpg"
            }
        }
var forecastGroup: Node[];
var scene: Scene;
var currWthrImage: Image;
var curr_cond: HBox;
var forecastNode: HBox;

Stage {
    title: "WeatherFX"
    resizable: false
    scene: Scene {
        width: 400
        height: 300

        fill: Color.TRANSPARENT
        content: Group {
            
            content: [bgImage,
                VBox {
                    spacing: 20
                    height: bind scene.height
                    layoutX:30
                    layoutY:20
                    content: [
                        HBox {
                            height: 50
                            spacing: 10
                            content: [Text {
                                    font: Font {
                                        size: 22
                                        name: "Arial Bold"
                                    }
                                    x: 10
                                    y: 30
                                    content: "City"
                                    textAlignment: TextAlignment.LEFT
                                    textOrigin: TextOrigin.BASELINE
                                }, TextBox {
                                    text: bind city with inverse
                                }, Button {
                                    text: "Check Weather"
                                    onMouseClicked: function (me: MouseEvent) {
                                        println("Call 2 Google");
                                        def http: HttpRequest = HttpRequest {
                                                    method: HttpRequest.GET;
                                                    location: "http://www.google.com/ig/api?weather={city}";
                                                    onResponseCode: function (code: Integer) {
                                                        /* if (code != 200 and onFailure != null)
                                                        onFailure("HTTP code {code}");*/
                                                        println("{code}")
                                                    }
                                                    onException: function (ex: Exception) {
                                                        /*if (onFailure != null)
                                                        onFailure(ex.toString());*/
                                                    }
                                                    onInput: function (ip: InputStream) {
                                                        println("Google Data Arrived");
                                                        gwd = GoogleWeatherData { }
                                                        def parser = PullParser {
                                                                    documentType: PullParser.XML;
                                                                    input: ip;
                                                                    onEvent: gwd.xmlEvent;
                                                                };
                                                        parser.parse();
                                                        parser.input.close();
                                                        
                                                        println(gwd);
                                                        
                                                        currWthrImage = Image {
                                                            url: "http://www.google.com{gwd.icon}"
                                                        }

                                                        delete  forecastGroup;
                                                        for (fc in gwd.forcast) {
                                                            println(fc);
                                                            def f: ForecastNode = ForecastNode {
                                                                        forecast: fc
                                                                    }
                                                            insert f into forecastGroup;
                                                        }

                                                        /*FadeTransition {
                                                            node: forecastNode;
                                                            fromValue: 0; toValue: 1;
                                                            duration: 5s;
                                                            action: function () {
                                                                    delete  forecastGroup;
                                                                    for (fc in gwd.forcast) {
                                                                        println(fc);
                                                                        def f: ForecastNode = ForecastNode {
                                                                                    forecast: fc
                                                                                }
                                                                        insert f into forecastGroup;
                                                                    }
                                                                }
                                                        }.play();*/

                                                        /*delete  forecastGroup;
                                                        for (fc in gwd.forcast) {
                                                            println(fc);
                                                            FadeTransition {
                                                                node: forecastNode;
                                                                fromValue: 0; toValue: 1;
                                                                duration: 2s;
                                                                action: function () {

                                                                            def f: ForecastNode = ForecastNode {
                                                                                        forecast: fc
                                                                                    }
                                                                            insert f into forecastGroup;

                                                                    }
                                                            }.play();
                                                        }*/
                                                    }
                                                };
                                        http.start();
                                    }
                                }
                            ]
                        },
                        HBox {
                            height: 100
                            content: [
                                curr_cond = HBox {
                                    layoutX: (scene.width - curr_cond.width) / 2
                                    spacing: 10
                                    content: [
                                        ImageView {
                                            fitHeight: 50
                                            fitWidth: 50
                                            effect: DropShadow { }
                                            image: bind currWthrImage;
                                        },
                                        VBox {
                                            spacing: 5
                                            content: [
                                                Text {
                                                    font: Font { name: "Arial Bold", size: 22 }
                                                    content: bind "{gwd.city}"
                                                },
                                                Text {
                                                    font: Font { name: "Arial Bold", size: 18 }
                                                    content: bind if (not (gwd.temp_f.equals("") or gwd.temp_c.equals("")))
                                                        "{gwd.temp_f} F/{gwd.temp_c} C" else
                                                        ""
                                                },
                                                Text {
                                                    font: Font { name: "Arial Bold", size: 14 }
                                                    content: bind "{gwd.humidity}"
                                                },
                                                Text {
                                                    font: Font { name: "Arial Bold", size: 14 }
                                                    content: bind "{gwd.wind_condition}"
                                                }]
                                        }
                                    ]
                                }
                            ]
                        },
                        forecastNode = HBox {
                            height: 250
                            spacing: 20
                            content: bind for (n in forecastGroup)
                                n
                        }
                    ]
                }
            ]
        }
    }
}
