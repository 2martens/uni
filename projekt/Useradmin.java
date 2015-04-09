import java.io.*;
import java.nio.file.*;
import java.nio.charset.*;
import java.util.List;

class Useradmin {
	
	public static void main(String[] args) {
		if (args.length == 2) {
			String method = args[0];
			String username = args[1];
			Console console = System.console();
			System.out.println("Enter the password:");
			String password = console.readLine();
			Useradmin useradmin = new Useradmin();
			switch (method) {
				case "addUser":
					useradmin.addUser(username, password.toCharArray());
					break;
				case "checkUser":
					boolean result = useradmin.checkUser(username, password.toCharArray());
					System.out.println("Does the user " + username + " exist? " + result);
					break;
			}
		}
		else {
			System.out.println("Please provide 2 parameters: addUser|checkUser <username>");
		}
	}

	public void addUser(String username, char[] password) {
		char[] hashedPW = password;
		String hashedPWString = String.valueOf(hashedPW);
		String format = username + ":" + hashedPWString;
		try(PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter("passwords.txt", true)))) {
		    out.println(format);
		    System.out.println("User has been created");
		} catch (IOException e) {
		    //exception handling left as an exercise for the reader
		}
	}

	public boolean checkUser(String username, char[] password) {
		char[] hashedPW = password;
		String hashedPWString = String.valueOf(hashedPW);
		boolean result = false;
		try {
			List<String> passwords = Files.readAllLines(Paths.get("passwords.txt"), StandardCharsets.UTF_8);

			for (String uidPW : passwords) {
				int indexOfColon = uidPW.indexOf(':');
				String user = uidPW.substring(0, indexOfColon);
				String pw = uidPW.substring(indexOfColon + 1);
				if (user.equals(username) && pw.equals(hashedPWString)) {
					result = true;
				}
			}
		}
		catch (IOException ioe) {

		}
		return result;
	}
}