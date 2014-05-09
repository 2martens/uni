
public class Umrechner {
    public int convertToCelsius(int fahrenheit) {
        return Math.round(5.0f / 9.0f * (fahrenheit - 32));
    }

    public int convertToFahrenheit(int celsius) {
        return Math.round(1.8f * celsius + 32);
    }
}