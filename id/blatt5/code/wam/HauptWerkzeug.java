import javax.swing.JFrame;
import javax.swing.JSlider;
import javax.swing.JTextField;
import javax.swing.event.ChangeListener;
import javax.swing.event.ChangeEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;

public class HauptWerkzeug {
    private Umrechner __rechner;
    private HauptWerkzeugUI __ui;

    private JFrame __frame;

    public HauptWerkzeug(Umrechner rechner) {
        __rechner = rechner;
        __ui = new HauptWerkzeugUI();
        __frame = __ui.getUIFrame();
        __ui.initGUI();
        registriereUIAktionen();
        __ui.zeigeFenster();
    }

    private void registriereUIAktionen() {
        __ui.getCelsius().addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                __ui.getCelsiusSlider().setValue(Integer.valueOf(__ui.getCelsius().getText()));
            }
        });

        __ui.getCelsiusSlider().addChangeListener(new ChangeListener() {
            public void stateChanged(ChangeEvent changeEvent) {
                int celsius = __ui.getCelsiusSlider().getValue();
                __ui.getCelsius().setText(Integer.toString(celsius));
            }
        });

        __ui.getFahrenheit().addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                __ui.getFahrenheitSlider().setValue(Integer.valueOf(__ui.getFahrenheit().getText()));
            }
        });

        __ui.getFahrenheitSlider().addChangeListener(new ChangeListener() {
            public void stateChanged(ChangeEvent changeEvent) {
                int fahrenheit = __ui.getFahrenheitSlider().getValue();
                __ui.getFahrenheit().setText(Integer.toString(fahrenheit));
            }
        });

        __ui.getCelsiusButton().addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                int celsius = __ui.getCelsiusSlider().getValue();
                int fahrenheit = __rechner.convertToFahrenheit(celsius);
                __ui.getFahrenheitSlider().setValue(fahrenheit);
                __ui.getFahrenheit().setText(Integer.toString(fahrenheit));
            }
        });

        __ui.getFahrenheitButton().addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                int fahrenheit = __ui.getFahrenheitSlider().getValue();
                int celsius = __rechner.convertToCelsius(fahrenheit);
                __ui.getCelsiusSlider().setValue(celsius);
                __ui.getCelsius().setText(Integer.toString(celsius));
            }
        });
    }
}