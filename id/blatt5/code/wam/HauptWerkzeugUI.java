import java.awt.GridLayout;
import java.awt.BorderLayout;
import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JLabel;
import javax.swing.JSlider;
import javax.swing.JTextField;
import javax.swing.WindowConstants;

class HauptWerkzeugUI {
    public static final String NAME = "Temperature converter";

    private JFrame __frame;
    private JPanel __panel;
    private JTextField __celsius;
    private JTextField __fahrenheit;
    private JSlider __celsiusSlider;
    private JSlider __fahrenheitSlider;
    private JButton __convertCelsiusButton;
    private JButton __convertFahrenheitButton;

    private GridLayout __layout;

    private static final int CELSIUS_MIN = -18;
    private static final int CELSIUS_MAX = 100;
    private static final int CELSIUS_INIT = 0;

    private static final int FAHRENHEIT_MIN = 0;
    private static final int FAHRENHEIT_MAX = 212;
    private static final int FAHRENHEIT_INIT = 32;

    public HauptWerkzeugUI() {
        __frame = new JFrame();
        __frame.setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);
        __frame.setTitle(NAME);
    }

    public void initGUI() {
        __panel = new JPanel();
        __layout = new GridLayout(1, 3);
        __panel.setLayout(__layout);

        JPanel celsiusPanel = new JPanel();
        BoxLayout boxLayoutCelsius = new BoxLayout(celsiusPanel, BoxLayout.Y_AXIS);
        celsiusPanel.setLayout(boxLayoutCelsius);

        __celsius = new JTextField();
        __celsius.setText(Integer.toString(CELSIUS_INIT));
        __celsiusSlider = new JSlider(JSlider.VERTICAL, CELSIUS_MIN, CELSIUS_MAX, CELSIUS_INIT);
        celsiusPanel.add(__celsius);
        celsiusPanel.add(__celsiusSlider);
        celsiusPanel.add(new JLabel("Celsius"));

        JPanel fahrenheitPanel = new JPanel();
        BoxLayout boxLayoutFahrenheit = new BoxLayout(fahrenheitPanel, BoxLayout.Y_AXIS);
        fahrenheitPanel.setLayout(boxLayoutFahrenheit);

        __fahrenheit = new JTextField();
        __fahrenheit.setText(Integer.toString(FAHRENHEIT_INIT));
        __fahrenheitSlider = new JSlider(JSlider.VERTICAL, FAHRENHEIT_MIN, FAHRENHEIT_MAX, FAHRENHEIT_INIT);
        fahrenheitPanel.add(__fahrenheit);
        fahrenheitPanel.add(__fahrenheitSlider);
        fahrenheitPanel.add(new JLabel("Fahrenheit"));

        JPanel middlePanel = new JPanel();
        middlePanel.setLayout(new BoxLayout(middlePanel, BoxLayout.Y_AXIS));
        __convertCelsiusButton = new JButton("Convert to Fahrenheit");
        __convertFahrenheitButton = new JButton("Convert to Celsius");
        middlePanel.add(__convertCelsiusButton);
        middlePanel.add(__convertFahrenheitButton);

        __panel.add(celsiusPanel);
        __panel.add(middlePanel);
        __panel.add(fahrenheitPanel);        

        __frame.getContentPane().add(__panel, BorderLayout.CENTER);
        __frame.pack();
    }

    /**
     * Gibt das JFrame der UI zurück.
     * 
     * @return Das JFrame der UI.
     */
    public JFrame getUIFrame()
    {
        return __frame;
    }

    /**
     * Zeigt das Hauptfenster an.
     */
    public void zeigeFenster()
    {
        __frame.setLocationRelativeTo(null);
        __frame.setVisible(true);
    }

    /**
     * Schließt das Fenster.
     */
    public void schliesseFenster()
    {
        __frame.dispose();
    }

    public JTextField getCelsius() {
        return __celsius;
    }

    public JTextField getFahrenheit() {
        return __fahrenheit;
    }

    public JSlider getCelsiusSlider() {
        return __celsiusSlider;
    }

    public JSlider getFahrenheitSlider() {
        return __fahrenheitSlider;
    }
    
    public JButton getCelsiusButton() {
        return __convertCelsiusButton;
    }

    public JButton getFahrenheitButton() {
        return __convertFahrenheitButton;
    }

    /**
     * Aktualisiert das Layout.
     */
    private void aktualisiereLayout()
    {
        __frame.validate();
    }
}