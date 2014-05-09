import javax.swing.JFrame;
import javax.swing.event.ChangeListener;
import javax.swing.event.ChangeEvent;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;


public class Controller {
    private Temperature _temperature;
    private UserInterface _ui;
    private JFrame _frame;

    public Controller() {
        _temperature = new Temperature();
        _ui = new UserInterface(this);
        _frame = _ui.getUIFrame();
        _temperature.addObserver(_ui);
        _ui.initGUI();
        registriereUIAktionen();
        _ui.zeigeFenster();
    }

    private void registriereUIAktionen() {
        _ui.getCelsius().addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                _ui.getCelsiusSlider().setValue(Integer.valueOf(_ui.getCelsius().getText()));
            }
        });

        _ui.getCelsiusSlider().addChangeListener(new ChangeListener() {
            public void stateChanged(ChangeEvent changeEvent) {
                int celsius = _ui.getCelsiusSlider().getValue();
                _ui.getCelsius().setText(Integer.toString(celsius));
            }
        });

        _ui.getFahrenheit().addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent actionEvent) {
                _ui.getFahrenheitSlider().setValue(Integer.valueOf(_ui.getFahrenheit().getText()));
            }
        });

        _ui.getFahrenheitSlider().addChangeListener(new ChangeListener() {
            public void stateChanged(ChangeEvent changeEvent) {
                int fahrenheit = _ui.getFahrenheitSlider().getValue();
                _ui.getFahrenheit().setText(Integer.toString(fahrenheit));
            }
        });

        _ui.getCelsiusButton().addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                int celsius = _ui.getCelsiusSlider().getValue();
                _temperature.setCelsiusTemperature(celsius);
            }
        });

        _ui.getFahrenheitButton().addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                int fahrenheit = _ui.getFahrenheitSlider().getValue();
                _temperature.setFahrenheitTemperature(fahrenheit);
            }
        });
    }
}