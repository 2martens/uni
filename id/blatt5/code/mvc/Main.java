import javax.swing.SwingUtilities;
import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

public class Main {
    public static void main(String[] argv) {
        SwingUtilities.invokeLater(new Runnable()
        {
            @Override
            public void run()
            {
                try
                {
                    UIManager.setLookAndFeel(UIManager
                            .getSystemLookAndFeelClassName());
                }
                catch (ClassNotFoundException | InstantiationException
                        | IllegalAccessException
                        | UnsupportedLookAndFeelException e)
                {
                    e.printStackTrace();
                }
                new Controller();
            }
        });
    }
}