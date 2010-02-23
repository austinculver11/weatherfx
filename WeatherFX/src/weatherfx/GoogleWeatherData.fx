/*
 * GoogleWeatherData.fx
 *
 * Created on Feb 21, 2010, 3:00:00 PM
 */
package weatherfx;

import javafx.data.pull.Event;
import javafx.data.pull.PullParser;
import javafx.data.xml.QName;

/**
 * @author santosh
 */
public class GoogleWeatherData {

    public-read var city: String;
    public-read var postal_code: String;
    public-read var forecast_date: String;
    public-read var current_date_time: String;
    public-read var latitude: String;
    public-read var longitude: String;
    public-read var current_condition: String;
    public-read var temp_f: String;
    public-read var temp_c: String;
    public-read var humidity: String;
    public-read var wind_condition: String;
    public-read var icon: String;
    public-read var forcast: Forecast[];
    var f: Forecast;
    var isReadingForecast: Boolean;

    public function xmlEvent(ev: Event): Void {
        //println(ev.qname.name);
        if ((ev.type == PullParser.END_ELEMENT) and ev.qname.name == "current_conditions") {
            isReadingForecast = true;
        }
        if (isReadingForecast) {

            if ((ev.type == PullParser.START_ELEMENT) and ev.qname.name == "forecast_conditions") {
                println("get Forecast Info");
                f = Forecast { }
            }

            if ((ev.type == PullParser.END_ELEMENT) and ev.qname.name == "forecast_conditions") {
                println("add collected Forecast Info");
                insert f into forcast
            }

            if (ev.level == 3 and ev.qname.name == "day_of_week") {
                f.day_of_week = readAttrS(ev, "data");
            }
            if (ev.level == 3 and ev.qname.name == "low") {
                f.low_temp = readAttrS(ev, "data");
            }
            if (ev.level == 3 and ev.qname.name == "high") {
                f.high_temp = readAttrS(ev, "data");
            }
            if (ev.level == 3 and ev.qname.name == "icon") {
                f.icon = readAttrS(ev, "data");
            }
            if (ev.level == 3 and ev.qname.name == "condition") {
                f.condition = readAttrS(ev, "data");
            }
        }
        if (ev.level == 3 and ev.qname.name == "city") {
            city = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "postal_code") {
            postal_code = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "latitude") {
            latitude = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "longitude") {
            longitude = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "forecast_date") {
            forecast_date = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "current_date_time") {
            current_date_time = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "condition") {
            current_condition = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "temp_f") {
            temp_f = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "temp_c") {
            temp_c = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "humidity") {
            humidity = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "icon") {
            icon = readAttrS(ev, "data");
        }
        if (ev.level == 3 and ev.qname.name == "wind_condition") {
            wind_condition = readAttrS(ev, "data");
        }
        //println("{readAttrS(ev, "data")}");
    }

    function readAttrS(ev: Event, attr: String): String {
        def qn = QName { name: attr };
        return ev.getAttributeValue(qn) as String;
    }

    override function toString(): String {
        "city:{city} ""postal_code:{postal_code} latitude:{latitude} longitude:{longitude} ""forecast_date:{forecast_date} current_date_time:{current_date_time}"
    }

}

package class Forecast {

    public-read var day_of_week: String;
    public-read var low_temp: String;
    public-read var high_temp: String;
    public-read var icon: String;
    public-read var wind_condition: String;
    public-read var condition: String;

    override function toString(): String {
        "day_of_week:{day_of_week} ""low_temp:{low_temp} high_temp:{high_temp} icon:{icon} ""wind_condition:{wind_condition} condition:{condition}"
    }

}
