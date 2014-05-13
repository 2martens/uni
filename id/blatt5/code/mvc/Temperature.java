import java.util.Observable;

public class Temperature extends Observable {
    private int _celsius;
    private int _fahrenheit;

    public Temperature() {
        _celsius = 0;
        _fahrenheit = 32;
    }

    public int getCelsiusTemperature() {
        return _celsius;
    }

    public int getFahrenheitTemperature() {
        return _fahrenheit;        
    }

    public void setCelsiusTemperature(int celsius) {
        _celsius = celsius;
        _fahrenheit = convertToFahrenheit(_celsius);
        setChanged();
        notifyObservers();
    }

    public void setFahrenheitTemperature(int fahrenheit) {
        _fahrenheit = fahrenheit;
        _celsius = convertToCelsius(fahrenheit);
        setChanged();
        notifyObservers();
    }

    private int convertToFahrenheit(int celsius) {
        return Math.round(1.8f * celsius + 32);
    }

    private int convertToCelsius(int fahrenheit) {
        return Math.round(5.0f / 9.0f * (fahrenheit - 32));
    }
}